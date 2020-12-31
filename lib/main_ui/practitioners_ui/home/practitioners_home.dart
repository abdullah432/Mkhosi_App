import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';

class PractitionersHome extends StatefulWidget {
  @override
  _PractitionersHomeState createState() => _PractitionersHomeState();
}

class _PractitionersHomeState extends State<PractitionersHome> {
  dynamic _snapshot;
  bool _isLoading = true;
  String _error;

  @override
  void initState() {
    print('ggv');
    FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        print(value.data());
        _snapshot = value.data();
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _error = error.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
        : _error != null
            ? AppStatusComponents.errorBody(message: _error)
            : PractitionersProfileScreen(false, _snapshot);
  }
}
