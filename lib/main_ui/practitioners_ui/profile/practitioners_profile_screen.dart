import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/main_ui/blog_screens/blog_home_screen.dart';
import 'package:makhosi_app/main_ui/general_ui/setting_page.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patient_chat_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patients_booking_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/chat/practitioner_inbox_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/practitioner_home_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:rating_bar/rating_bar.dart';

class PractitionersProfileScreen extends StatefulWidget {
  bool _isViewer;
  DocumentSnapshot _snapshot;

  PractitionersProfileScreen(this._isViewer, this._snapshot);

  @override
  _PractitionersProfileScreenState createState() =>
      _PractitionersProfileScreenState();
}

class _PractitionersProfileScreenState
    extends State<PractitionersProfileScreen> {
  DocumentSnapshot _snapshot;
  bool _isLoading = false, _isFavorite = false;
  String _userId;

  @override
  void initState() {
    _snapshot = widget._snapshot;
    _checkFavorite();
    super.initState();
  }

  Future<void> _checkFavorite() async {
    try {
      _userId = FirebaseAuth.instance.currentUser.uid;
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(_userId)
          .collection('my_favorites')
          .doc(_snapshot.id)
          .get();
      if (favoriteSnapshot.exists) {
        setState(() {
          _isFavorite = true;
        });
      }
    } catch (exc) {
      setState(() {
        _isFavorite = false;
      });
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? AppStatusComponents.loadingContainer(Colors.white)
          : _snapshot == null
              ? AppStatusComponents.errorBody(message: 'No profile data')
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/profile_background.png',
                        width: ScreenDimensions.getScreenWidth(context),
                        height: ScreenDimensions.getScreenWidth(context) / 1.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 0,
                          height: ScreenDimensions.getScreenWidth(context) / 5,
                        ),
                        Expanded(
                          child: _getBody(),
                        ),
                      ],
                    ),
                    //setting icon
                    Positioned(
                      left: 10.0,
                      top: 30.0,
                      child: GestureDetector(
                        onTap: () {
                          NavigationController.push(
                            context,
                            SettingPage(
                              isNavigateFromServiceProvider: true,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _getBody() {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      height: ScreenDimensions.getScreenHeight(context),
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          _getContentSection(),
          _getImageSection(),
        ],
      ),
    );
  }

  Widget _getContentSection() {
    bool isOnline = _snapshot.get(AppKeys.ONLINE);
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    '${_snapshot.get(AppKeys.FIRST_NAME)} ${_snapshot.get(AppKeys.SECOND_NAME)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _snapshot.get(AppKeys.PRACTICE_LOCATION),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Others.getSizedBox(boxHeight: 8, boxWidth: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.brightness_1,
                        color: isOnline ? Colors.green : Colors.red,
                        size: 12,
                      ),
                      Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                      Text(isOnline ? 'Online' : 'Offline'),
                    ],
                  ),
                  Others.getSizedBox(boxHeight: 8, boxWidth: 0),
                  _getRattingBar(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total\nSessions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
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
                            '900',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total\nReviews',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  _getNamesSection(),
                  widget._isViewer ? Container() : PractitionerHomeButtons(),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Timing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  _getTimingSection(),
                  SizedBox(
                    height: 16,
                  ),
                  _getButtonsSection(),
                ],
              ),
            ),
          ),
          widget._isViewer
              ? Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      _saveFavorite();
                    },
                  ),
                )
              : Container(),
          !widget._isViewer
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: Icon(
                              Icons.mail_outline,
                              color: AppColors.COLOR_PRIMARY,
                              size: 32,
                            ),
                            onTap: () {
                              NavigationController.push(
                                context,
                                PractitionerInboxScreen(),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.brightness_1,
                            size: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _getButtonsSection() {
    return widget._isViewer
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.mail_outline,
                  color: Colors.blue,
                ),
                onPressed: () {
                  NavigationController.push(
                    context,
                    PatientChatScreen(_snapshot.id),
                  );
                },
              ),
              SizedBox(
                width: 8,
              ),
              _getBookingButton(),
              SizedBox(
                width: 8,
              ),
              widget._isViewer ? _getBlogButton() : Container(),
            ],
          )
        : Container();
  }

  Widget _getBlogButton() {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: AppColors.COLOR_PRIMARY,
        onPressed: () {
          NavigationController.push(
            context,
            BLogHomeScreen(_snapshot.id, true),
          );
        },
        child: Text(
          'Blog',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _getBookingButton() {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: AppColors.COLOR_PRIMARY,
        onPressed: () async {
          NavigationController.push(
            context,
            PatientsBookingScreen(_snapshot),
          );
        },
        child: Text(
          'BOOK NOW',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _getTimingSection() {
    return Container(
      child: Column(
        children: [
          _getTimingRow(0, 'Sunday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(1, 'Monday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(2, 'Tuesday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(3, 'Wednesday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(4, 'Thursday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(5, 'Friday'),
          SizedBox(
            height: 4,
          ),
          _getTimingRow(6, 'Saturday'),
        ],
      ),
    );
  }

  Widget _getTimingRow(int index, String day) {
    String timingString;
    switch (index) {
      case 0:
        {
          if (_snapshot.get('timings')['sunday_open'] == '00:00' &&
              _snapshot.get('timings')['sunday_close'] == '00:00') {
            timingString = 'closed';
          } else {
            timingString =
                '${_snapshot.get('timings')['sunday_open']} to ${_snapshot.get('timings')['sunday_close']}';
          }

          break;
        }
      case 1:
        {
          if (_snapshot.get('timings')['monday_open'] == '00:00' &&
              _snapshot.get('timings')['monday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['monday_open']} to ${_snapshot.get('timings')['monday_close']}';
          break;
        }
      case 2:
        {
          if (_snapshot.get('timings')['tuesday_open'] == '00:00' &&
              _snapshot.get('timings')['tuesday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['tuesday_open']} to ${_snapshot.get('timings')['tuesday_close']}';
          break;
        }
      case 3:
        {
          if (_snapshot.get('timings')['wednesday_open'] == '00:00' &&
              _snapshot.get('timings')['wednesday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['wednesday_open']} to ${_snapshot.get('timings')['wednesday_close']}';
          break;
        }
      case 4:
        {
          if (_snapshot.get('timings')['thursday_open'] == '00:00' &&
              _snapshot.get('timings')['thursday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['thursday_open']} to ${_snapshot.get('timings')['thursday_close']}';
          break;
        }
      case 5:
        {
          if (_snapshot.get('timings')['friday_open'] == '00:00' &&
              _snapshot.get('timings')['friday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['friday_open']} to ${_snapshot.get('timings')['friday_close']}';
          break;
        }
      case 6:
        {
          if (_snapshot.get('timings')['saturday_open'] == '00:00' &&
              _snapshot.get('timings')['saturday_close'] == '00:00') {
            timingString = 'closed';
          } else
            timingString =
                '${_snapshot.get('timings')['saturday_open']} to ${_snapshot.get('timings')['saturday_close']}';
          break;
        }
    }
    return Row(
      children: [
        Expanded(
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: Text(
            timingString,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getNamesSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Dlozi Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                _snapshot.get(AppKeys.DLOZI_NAME),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Ughobela Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                _snapshot.get(AppKeys.UGHOBELA_NAME),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getRattingBar() {
    return RatingBar.readOnly(
      initialRating: 4.5,
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      emptyColor: Colors.orange,
      filledColor: Colors.orange,
      halfFilledIcon: Icons.star_half,
      isHalfAllowed: true,
      halfFilledColor: Colors.orange,
      maxRating: 5,
      size: 18,
    );
  }

  Widget _getImageSection() {
    return GestureDetector(
      onTap: !widget._isViewer
          ? () async {
              PickedFile pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                imageQuality: 25,
              );
              if (pickedFile != null) {
                StorageReference ref = FirebaseStorage.instance
                    .ref()
                    .child('profile_images/${_snapshot.id}.jpg');
                StorageUploadTask task = ref.putFile(File(pickedFile.path));
                task.onComplete.then((_) async {
                  await FirebaseFirestore.instance
                      .collection('practitioners')
                      .doc(_snapshot.id)
                      .set({'profile_image': await _.ref.getDownloadURL()},
                          SetOptions(merge: true));
                  NavigationController.pushReplacement(
                      context,
                      PractitionersProfileScreen(
                          widget._isViewer,
                          await FirebaseFirestore.instance
                              .collection('practitioners')
                              .doc(_snapshot.id)
                              .get()));
                }).catchError((error) {
                  print(error);
                });
              }
            }
          : null,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white,
              width: 12,
            ),
          ),
          child: _snapshot == null
              ? Others.getProfilePlaceHOlder()
              : _snapshot.get('profile_image') == null
                  ? Others.getProfilePlaceHOlder()
                  : CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        _snapshot.get('profile_image'),
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> _saveFavorite() async {
    if (!_isFavorite) {
      FirebaseFirestore.instance
          .collection('favorites')
          .doc(_userId)
          .collection('my_favorites')
          .doc(_snapshot.id)
          .set({
        AppKeys.PRACTITIONER_UID: _snapshot.id,
      });
    } else {
      FirebaseFirestore.instance
          .collection('favorites')
          .doc(_userId)
          .collection('my_favorites')
          .doc(_snapshot.id)
          .delete();
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
}
