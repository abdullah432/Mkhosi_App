import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/contracts/i_dialogue_button_clicked.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/auth/patient_register_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_dialogues.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:makhosi_app/thirdMain.dart';
import 'package:makhosi_app/main_ui/general_ui/settingpage2.dart';
import 'package:makhosi_app/Screens/notification_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patient_inbox_screen.dart';
class PatientProfileScreen extends StatefulWidget {
  DocumentSnapshot _snapshot;
  bool _isViewer;

  PatientProfileScreen(this._snapshot, this._isViewer);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen>
    implements
        IRoundedButtonClicked,
        IOutlinedButtonClicked,
        IDialogueButtonClicked {
  bool _isLoading = false;
  String _uid;
  var seen=0;
  void finished() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     seen=prefs.getInt('count');
  }
  @override
  Widget build(BuildContext context) {
    finished();
    return Scaffold(
      body: Stack(
        children: [


          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/Gradient.png',
              width: ScreenDimensions.getScreenWidth(context),
              height: ScreenDimensions.getScreenWidth(context) / 1.25,
              fit: BoxFit.cover,
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(''),// You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_rounded, color: AppColors.COLOR_PRIMARY, size: 40,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.blue.withOpacity(0.1), //You can make this transparent
              elevation: 0.0, //No shadow
            ),),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 0,
                  height: ScreenDimensions.getScreenWidth(context) / 2.25,
                ),
                _getContentSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContentSection() {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: ScreenDimensions.getScreenWidth(context),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          widget._snapshot.get(AppKeys.FULL_NAME),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget._snapshot.get(AppKeys.ADDRESS),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'SERVICES\n LIKED',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              height: 45,
                              width: 2,
                              color: Colors.black38,
                            ),
                            Column(
                              children: [
                                Text(
                                  '2/5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'CUSTOMER\n RATING',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              height: 45,
                              width: 2,
                              color: Colors.black38,
                            ),
                            Column(
                              children: [
                                seen!=null?
                                Text(
                                  '$seen',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ):Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'POINTS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        !widget._isViewer
                            ? FlatButton(
                          height: 60,
                          minWidth:210,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          color: AppColors.COLOR_PRIMARY,
                          onPressed: () {
                            //NavigationController.push(
                            //context,
                            //BLogHomeScreen(_snapshot.id, true),
                            //);
                          },
                          child: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                  ),
              ),
              SizedBox(
                height: 16,
              ),
              !widget._isViewer ? Column(
    children: [
    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 15),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
      onPressed:(){
        NavigationController.push(
          context,
          app(),
        );
      },
    child: Row(
    children: [
    Text('MKHOSI KNOWLEDGE HUB', style: TextStyle(
    color: AppColors.COLOR_PRIMARY
    )
    ),
    SizedBox(
    width: 20,
    ),
    Icon(
    Icons.arrow_forward_ios_outlined,
    size: 20 ,


    )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),


    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 8),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
    onPressed: null,
    child: Row(
    children: [
    Text('FIND A SERVICE', style: TextStyle(
    color: AppColors.COLOR_PRIMARY,

    )
    ),

    SizedBox(
    width: 82,
    ),
    Icon(
    Icons.arrow_forward_ios_outlined,
    size: 20 ,


    )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid,
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),

    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 8),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
    onPressed: (){
      NavigationController.push(
        context,
        PractitionerInboxScreen(),
      );
    },
    child: Row(
    children: [
    Text('MESSAGES', style: TextStyle(
    color: AppColors.COLOR_PRIMARY,

    )
    ),

    SizedBox(
    width: 101,
    ),
    Icon(
    Icons.arrow_forward_ios_outlined,
    size: 20 ,


    )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid,
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),
    ],
    ) : Container(),
            ],
          ),
          !widget._isViewer
              ? Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(right: 15, top: 50),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Icon(
                        Icons.settings,
                        color: AppColors.COLOR_PRIMARY,
                        size: 32,
                      ),
                      onTap: () {
                        NavigationController.push(
                          context,
                          SettingPage(),
                        );

                      },
                    ),
                  ),

                ],
              ),
            ),
          )
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(left: 15, top: 50),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: Icon(
                        Icons.notifications,
                        color: AppColors.COLOR_PRIMARY,
                        size: 32,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new NotificationScreen()));

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _getImageSection(),

        ],
      ),
    );
  }

  Widget _getImageSection() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(bottom: 600) ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: !widget._isViewer ? () {
                _openGallery();
              } : null,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: NetworkImage(
                  widget._snapshot.get(AppKeys.PROFILE_IMAGE) == null
                      ? 'https://image.freepik.com/free-vector/follow-me-social-business-theme-design_24877-52233.jpg'
                      : widget._snapshot.get(AppKeys.PROFILE_IMAGE),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  _openGallery();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
            ),
            _isLoading
                ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _openGallery() async {
    var pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });
      Others.clearImageCache();
      _uploadImage(pickedFile);
    }
  }

  void _uploadImage(PickedFile pickedFile) {
    _uid = FirebaseAuth.instance.currentUser.uid;
    StorageReference ref = FirebaseStorage.instance.ref().child(
          'profile_images/$_uid.jpg',
        );
    StorageUploadTask task = ref.putFile(File(pickedFile.path));
    task.onComplete.then((_) async {
      String downloadUrl = await _.ref.getDownloadURL();
      _updateProfileData(downloadUrl);
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        AppToast.showToast(message: error.toString());
      });
    });
  }

  Future<void> _updateProfileData(String downloadUrl) async {
    try {
      await FirebaseFirestore.instance.collection('patients').doc(_uid).set(
        {
          AppKeys.PROFILE_IMAGE: downloadUrl,
        },
        SetOptions(merge: true),
      );
      widget._snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(_uid)
          .get();
      setState(() {
        _isLoading = false;
      });
    } catch (exc) {
      setState(() {
        _isLoading = false;
        AppToast.showToast(message: exc.toString());
      });
    }
  }

  @override
  onClick(ClickType clickType) {
    NavigationController.pushReplacement(
      context,
      PatientRegisterScreen(ClickType.PATIENT, widget._snapshot),
    );
  }

  @override
  void onOutlineButtonClicked(ClickType clickType) {
    // ignore: missing_enum_constant_in_switch
    switch (clickType) {
      case ClickType.LOGOUT:
        AppDialogues.showConfirmationDialogue(
          context: context,
          title: 'Sign Out!',
          label: 'Are you sure you want to sign out?',
          negativeButtonLabel: 'Cancel',
          positiveButtonLabel: 'Sign Out',
          iDialogueButtonClicked: this,
        );
        break;
    }
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
    Navigator.pop(context);
    await Others.signOut();
    NavigationController.pushReplacement(
      context,
      LoginScreen(ClickType.PATIENT),
    );
  }
}
