import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class AddCalanderEvent extends StatefulWidget {
  @override
  _AddCalanderEventState createState() => _AddCalanderEventState();
}

class _AddCalanderEventState extends State<AddCalanderEvent>
    implements IRoundedButtonClicked {
  TextEditingController _noteText = TextEditingController(text: 'Note');
  TextEditingController _invitesText = TextEditingController(text: 'Invites');

  Widget _getHeadingText(label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getCategoryTitle() {
    return Text(
      'Category',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getDate() {
    return Text(
      DateFormat('EE d, MMMMM, YYYY').format(DateTime.now()),
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getTime() {
    return Text(
      DateFormat('h:m a').format(DateTime.now()),
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _coloredButton(String label, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _textBoxNotes() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _noteText,
        decoration: InputDecoration(
          fillColor: AppColors.COLOR_LIGHTSKY,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _textBoxInvites() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _invitesText,
        decoration: InputDecoration(
          fillColor: AppColors.COLOR_LIGHTSKY,
          prefixIcon: Icon(Icons.contact_mail_outlined),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _getCategoryBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _coloredButton('Admin', Color(0xFF49B583)),
            _coloredButton('Orders', Color(0xFFFF4171)),
            _coloredButton('Inventory', Color(0xFFE85EC0))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _coloredButton('Consultation', Color(0xFFFFBD69)),
            _coloredButton('Business Meeting', Color(0xFF7F86FF))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _getHeadingText('Add a task/meeting'),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(
                bottom: 20,
                left: 35,
              ),
              child: _getCategoryTitle()),
          _getCategoryBody(),
          SizedBox(
            height: 20,
          ),
          _textBoxNotes(),
          SizedBox(
            height: 20,
          ),
          _textBoxInvites(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              _getIconBox(
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF7F86FF),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              _getDate(),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              _getIconBox(
                Icon(
                  Icons.timelapse_rounded,
                  color: Color(0xFFFFBD69),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              _getTime(),
              Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'Save Event',
              clickType: ClickType.DUMMY,
            ),
          )
        ],
      ),
    );
  }

  Widget _getIconBox(Icon icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 7,
            color: Colors.grey[100],
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
    );
  }

  @override
  onClick(ClickType clickType) {
    Navigator.pop(context);
  }
}
