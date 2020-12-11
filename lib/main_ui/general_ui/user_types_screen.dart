import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

class UserTypeScreen extends StatefulWidget {
  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen>
    implements IRoundedButtonClicked {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'CUSTOMER',
              clickType: ClickType.PATIENT,
            ),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'SERVICE PROVIDER',
              clickType: ClickType.PRACTITIONER,
            ),
          ],
        ),
      ),
    );
  }

  @override
  onClick(ClickType userType) {
    NavigationController.pushReplacement(context, LoginScreen(userType));
  }
}
