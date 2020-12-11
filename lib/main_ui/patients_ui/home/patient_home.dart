import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/general_ui/setting_page.dart';
import 'package:makhosi_app/main_ui/patients_ui/profile_screens/patient_profile_screen.dart';
import 'package:makhosi_app/tabs/all_tab.dart';
import 'package:makhosi_app/tabs/bookings_tab.dart';
import 'package:makhosi_app/tabs/favorites_tab.dart';
import 'package:makhosi_app/tabs/nearby_practitioners_tab.dart';
import 'package:makhosi_app/tabs/patient_inbox_tab.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  DocumentSnapshot _userProfileSnapshot;
  String _uid;

  @override
  void initState() {
    Others.clearImageCache();
    _getUserProfileData();
    super.initState();
  }

  Future<void> _getUserProfileData() async {
    _uid = FirebaseAuth.instance.currentUser.uid;
    _userProfileSnapshot =
        await FirebaseFirestore.instance.collection('patients').doc(_uid).get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //setting icon
              GestureDetector(
                onTap: () {
                  NavigationController.push(
                    context,
                    SettingPage(
                      isNavigateFromServiceProvider: false,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings,
                    color: AppColors.COLOR_PRIMARY,
                  ),
                ),
              ),
              //Title in center
              Text(
                _userProfileSnapshot == null
                    ? 'Customer Dashboard'
                    : _userProfileSnapshot.get(AppKeys.FULL_NAME),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              //action button
              GestureDetector(
                onTap: () {
                  if (_userProfileSnapshot != null)
                    NavigationController.push(
                      context,
                      PatientProfileScreen(_userProfileSnapshot, false),
                    );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  margin: EdgeInsets.only(right: 16),
                  child: _userProfileSnapshot != null &&
                          _userProfileSnapshot.get(AppKeys.PROFILE_IMAGE) !=
                              null
                      ? CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            _userProfileSnapshot.get(AppKeys.PROFILE_IMAGE),
                          ),
                        )
                      : Icon(Icons.person),
                ),
              ),
            ],
          ),
          // Text(
          //   _userProfileSnapshot == null
          //       ? 'Customer Dashboard'
          //       : _userProfileSnapshot.get(AppKeys.FULL_NAME),
          //   style: TextStyle(
          //     color: Colors.black,
          //   ),
          // ),
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       if (_userProfileSnapshot != null)
          //         NavigationController.push(
          //           context,
          //           PatientProfileScreen(_userProfileSnapshot, false),
          //         );
          //     },
          //     child: Container(
          //       padding: EdgeInsets.only(top: 12, bottom: 12),
          //       margin: EdgeInsets.only(right: 16),
          //       child: _userProfileSnapshot != null &&
          //               _userProfileSnapshot.get(AppKeys.PROFILE_IMAGE) != null
          //           ? CircleAvatar(
          //               radius: 16,
          //               backgroundImage: NetworkImage(
          //                 _userProfileSnapshot.get(AppKeys.PROFILE_IMAGE),
          //               ),
          //             )
          //           : Icon(Icons.person),
          //     ),
          //   ),
          // ],
          // centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicator: BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: AppColors.COLOR_PRIMARY,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text('All'),
              ),
              Tab(
                child: Text('Nearby Practitioners'),
              ),
              Tab(
                child: Text('Favorites'),
              ),
              Tab(
                child: Text('Inbox'),
              ),
              Tab(
                child: Text('Appointments'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AllTab(),
            NearbyPractitionersTab(),
            FavoritesTab(),
            PatientInboxTab(),
            BookingsTab(),
          ],
        ),
      ),
    );
  }
}
