import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/contracts/i_string_drop_down_item_selected.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/traditional_healers_screentwo.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_dropdowns.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';

// ignore: must_be_immutable
class TraditionalHealersScreenFirst extends StatefulWidget {
  // ClickType _userType;

  // TraditionalHealersScreenFirst(this._userType);

  @override
  _TraditionalHealersScreenFirstState createState() =>
      _TraditionalHealersScreenFirstState();
}

class _TraditionalHealersScreenFirstState
    extends State<TraditionalHealersScreenFirst>
    implements IRoundedButtonClicked {
  var _medicineSourceController = TextEditingController();
  var _traditionalHealerRulesController = TextEditingController();
  var _healerTypeController = TextEditingController();
  var _particularSpecialityController = TextEditingController();
  //dropdown
  var _consultancyTypeList = ['Physically', 'Virtually', 'Both'];
  String _selectedConsultancyType;
  //form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // NavigationController.pushReplacement(
        //   context,
        //   LoginScreen(ClickType.PRACTITIONER),
        // );
      },
      child: Scaffold(
        body: _getForm(),
      ),
    );
  }

  Widget _getForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Text(
            'The information in this section is to provide information to potential patients about the type of practitioner that one is and also to provide information for those patients who know the type of problem they have including which rules to abide by. ',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.COLOR_GREY,
            ),
            textAlign: TextAlign.justify,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _healerTypeController,
            label: 'What type of healer are you?',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _particularSpecialityController,
            label: 'Do you have particular specialities?',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _medicineSourceController,
            label:
                'If you are a herbalist, where do you source your medicine (imithi)?',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _traditionalHealerRulesController,
            label:
                'What rules do patients have to abide by when consulting with you?',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //consultancytyp dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Which type of consultancy you provide?'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedConsultancyType,
              items: _consultancyTypeList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedConsultancyType = item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppButtons.getRoundedButton2(
            context: context,
            iRoundedButtonClicked: this,
            label: 'NEXT',
            clickType: ClickType.DUMMY,
          ),
        ],
      ),
    );
  }

  Widget _getBackButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // NavigationController.pushReplacement(
              //     context, LoginScreen(widget._userType));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          AppLabels.getLabel(
            labelText: 'About Your Practice',
            size: 21,
            labelColor: Colors.black,
            isBold: false,
            isUnderlined: false,
            alignment: TextAlign.left,
          ),
        ],
      ),
    );
  }

//  var _medicineSourceController = TextEditingController();
//   var _traditionalHealerRulesController = TextEditingController();
//   var _healerTypeController = TextEditingController();
//   var _particularSpecialityController = TextEditingController();
//   //dropdown
//   var _consultancyTypeList = ['Physically', 'Virtually'];
//   String _selectedConsultancyType;
  @override
  onClick(ClickType clickType) {
    if (_formKey.currentState.validate()) {
      String medicineSource = _medicineSourceController.text.trim();
      String traditionalHealerRules =
          _traditionalHealerRulesController.text.trim();
      String healerType = _healerTypeController.text.trim();
      String particularspeciality = _particularSpecialityController.text.trim();
      if (_selectedConsultancyType == null) {
        AppToast.showToast(message: 'Please select Consultancy type');
      } else {
        NavigationController.push(
          context,
          TraditionalHealersScreenTwo(
            {
              AppKeys.MEDICINE_SOURCING: medicineSource,
              AppKeys.RULES_FOR_PATIENT: traditionalHealerRules,
              AppKeys.WHAT_TYPE_OF_HEALER: healerType,
              AppKeys.PARTICULAR_SPECIALITY: particularspeciality,
            },
          ),
        );
      }
    }
    // NavigationController.push(context, TraditionalHealersScreenTwo());
  }
}
