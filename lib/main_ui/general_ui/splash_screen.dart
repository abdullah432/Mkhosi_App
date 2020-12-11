import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/user_types_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription _subscription;
  PreferencesHelper _preferencesHelper = PreferencesHelper();

  @override
  void initState() {
    Others.clearImageCache();
    _subscription = _counter().listen((count) async {
      if (count == 4) {
        _navigate();
      }
    });
    super.initState();
  }

  _navigate() async {
    String userType = await _preferencesHelper.getUserType();
    var user = FirebaseAuth.instance.currentUser;
    Object targetScreen;
    if (user != null) {
      switch (userType) {
        case AppKeys.PATIENT:
          {
            targetScreen = PatientHome();
            break;
          }
        case AppKeys.PRACTITIONER:
          {
            targetScreen = PractitionersHome();
            break;
          }
        case 'null':
          {
            targetScreen = UserTypeScreen();
            break;
          }
      }
    } else {
      targetScreen = UserTypeScreen();
    }
    NavigationController.pushReplacement(context, targetScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenDimensions.getScreenWidth(context),
        height: ScreenDimensions.getScreenHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.arrow_right_alt_rounded,
              color: Colors.grey,
            ),
            onPressed: () {
              _subscription.cancel();
              _navigate();
            },
          ),
        ),
      ),
    );
  }

  Stream<int> _counter() async* {
    int count = 0;
    while (true) {
      yield count;
      await Future.delayed(
        Duration(seconds: 1),
      );
      count++;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
