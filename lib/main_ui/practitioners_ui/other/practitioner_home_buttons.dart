import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_info_dialog_clicked.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/blog_screens/blog_home_screen.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/practitioner_bookings_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

class PractitionerHomeButtons extends StatefulWidget {
  @override
  _PractitionerHomeButtonsState createState() =>
      _PractitionerHomeButtonsState();
}

class _PractitionerHomeButtonsState extends State<PractitionerHomeButtons>
    implements IOutlinedButtonClicked, IInfoDialogClicked {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 70, right: 70, top: 8),
          child: AppButtons.getOutlineButton(
            context: context,
            iOutlinedButtonClicked: this,
            label: 'BOOKINGS',
            clickType: ClickType.DUMMY,
            icon: Icons.book,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 70, right: 70, top: 8),
          child: AppButtons.getOutlineButton(
            context: context,
            iOutlinedButtonClicked: this,
            label: 'BLOG',
            clickType: ClickType.BLOG,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 70, right: 70, top: 8),
          child: AppButtons.getOutlineButton(
            context: context,
            iOutlinedButtonClicked: this,
            label: 'LOG OUT',
            clickType: ClickType.LOGOUT,
          ),
        ),
      ],
    );
  }

  @override
  void onOutlineButtonClicked(ClickType clickType) {
    if (clickType == ClickType.DUMMY) {
      NavigationController.push(
        context,
        PractitionerBookingsScreen(),
      );
    } else if (clickType == ClickType.LOGOUT) {
      Others.showInfoDialog(
        context: context,
        title: 'Log Out?',
        message: 'Are youn sure you want to log out of the app?',
        positiveButtonLabel: 'LOG OUT',
        negativeButtonLabel: 'CANCEL',
        iInfoDialogClicked: this,
        isInfo: false,
      );
    } else {
      NavigationController.push(
        context,
        BLogHomeScreen(
          FirebaseAuth.instance.currentUser.uid,
          false,
        ),
      );
    }
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
    Navigator.pop(context);
    await FirebaseFirestore.instance
        .collection('practitioners')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'online': false,
    }, SetOptions(merge: true));
    await Others.signOut();
    NavigationController.pushReplacement(
      context,
      LoginScreen(ClickType.PRACTITIONER),
    );
  }
}
