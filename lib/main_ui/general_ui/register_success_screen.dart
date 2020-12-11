import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

class RegisterSuccessScreen extends StatefulWidget {
  ClickType _clickType;

  RegisterSuccessScreen(this._clickType);

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen>
    implements IRoundedButtonClicked {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/done.png'),
            Text(
              'Registration Successful!',
              style: TextStyle(
                fontSize: 21,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Others.getSizedBox(boxHeight: 32, boxWidth: 0),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'GO HOME',
              clickType: widget._clickType,
            ),
          ],
        ),
      ),
    );
  }

  @override
  onClick(ClickType clickType) {
    Object targetScreen;
    switch (clickType) {
      case ClickType.PATIENT:
        targetScreen = PatientHome();
        break;
      case ClickType.PRACTITIONER:
        targetScreen = PractitionersHome();
        break;
      case ClickType.LOGIN:
        break;
      case ClickType.DUMMY:
        break;
    }
    NavigationController.pushReplacement(context, targetScreen);
  }
}
