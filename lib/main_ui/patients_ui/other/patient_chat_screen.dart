import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makhosi_app/contracts/i_message_dialog_clicked.dart';
import 'package:makhosi_app/main_ui/general_ui/call_page.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientChatScreen extends StatefulWidget {
  String _practitionerUid, _myUid;

  PatientChatScreen(this._practitionerUid);

  @override
  _PatientChatScreenState createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen>
    implements IMessageDialogClicked {
  List<DocumentSnapshot> _chatList = [];
  StreamSubscription _subscription;
  var _messageController = TextEditingController();
  ScrollController _controller = ScrollController();
  int _selectedPosition;

  @override
  void initState() {
    widget._myUid = FirebaseAuth.instance.currentUser.uid;
    _subscription = _chatStream().listen((messages) {
      _chatList.clear();
      messages.docs.forEach((message) {
        _chatList.add(message);
      });
      _scrollToEnd();
      _markAsRead();
      setState(() {});
    });
    super.initState();
  }

  void _markAsRead() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .set(
      {
        'seen': true,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> _scrollToEnd() async {
    await Future.delayed(Duration(seconds: 2));
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbars.toolbar(
        context: context,
        title: 'Messages',
        isLeading: false,
        targetScreen: null,
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Stack(
      children: [
        ListView.builder(
          controller: _controller,
          padding: EdgeInsets.only(bottom: 80, left: 8, right: 8, top: 8),
          itemCount: _chatList.length,
          itemBuilder: (context, position) => _chatRow(position),
        ),
        _getSendMessageSection(),
      ],
    );
  }

  Widget _chatRow(int position) {
    DocumentSnapshot snapshot = _chatList[position];
    return GestureDetector(
      onLongPress: () {
        Others().hideKeyboard(context);
        _selectedPosition = position;
        Others.showMessageOptionsDialog(
          context: context,
          iMessageDialogClicked: this,
        );
      },
      child: Wrap(
        alignment: snapshot.get('is_received')
            ? WrapAlignment.start
            : WrapAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
            margin: EdgeInsets.only(
              top: 4,
              left: snapshot.get('is_received') ? 0 : 24,
              right: snapshot.get('is_received') ? 24 : 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: snapshot.get('is_received')
                  ? Colors.black38
                  : AppColors.COLOR_PRIMARY,
            ),
            child: Text(
              snapshot.get('message'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSendMessageSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(12),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                String message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  _sendMessage(message);
                }
              },
              child: Icon(
                Icons.send,
                color: AppColors.COLOR_PRIMARY,
                size: 40,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () async {
                await [Permission.camera, Permission.microphone].request();
                NavigationController.push(
                  context,
                  CallPage(widget._practitionerUid, ClientRole.Broadcaster),
                );
              },
              child: Icon(
                Icons.video_call,
                color: AppColors.COLOR_PRIMARY,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    //First we will update inbox data for patient i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': message,
        'seen': true,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to patient section
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': message,
        'is_received': false,
      },
    );
    //Now we will update inbox data for practitioner i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._practitionerUid)
        .collection('inbox')
        .doc(widget._myUid)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': message,
        'seen': false,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to practitioner section
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._practitionerUid)
        .collection('inbox')
        .doc(widget._myUid)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': message,
        'is_received': true,
      },
    );
    _messageController.text = '';
    Others().hideKeyboard(context);
  }

  Stream<QuerySnapshot> _chatStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void onCopyClicked() async {
    await Clipboard.setData(
      ClipboardData(
        text: _chatList[_selectedPosition].get('message'),
      ),
    );
    AppToast.showToast(message: 'Copied to clipboard');
  }

  @override
  void onDeleteClicked() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .doc(_chatList[_selectedPosition].id)
        .delete();
  }
}
