import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_trailing_clicked.dart';
import 'package:makhosi_app/models/ClosedDaysModel.dart';
import 'package:makhosi_app/models/DayTimeModel.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/others.dart';

class EditHoursScreen extends StatefulWidget {
  EditHoursScreen({Key key}) : super(key: key);

  @override
  _EditHoursScreenState createState() => _EditHoursScreenState();
}

class _EditHoursScreenState extends State<EditHoursScreen>
    implements ITrailingClicked {
  var _list = <DayTimeModel>[];
  var _closedDaysList = <ClosedDaysModel>[];
  var _sundayStartTimingController = TextEditingController();
  var _mondayStartTimingController = TextEditingController();
  var _tuesdayStartTimingController = TextEditingController();
  var _wednesdayStartTimingController = TextEditingController();
  var _thursdayStartTimingController = TextEditingController();
  var _fridayStartTimingController = TextEditingController();
  var _saturdayStartTimingController = TextEditingController();
  var _sundayEndTimingController = TextEditingController();
  var _mondayEndTimingController = TextEditingController();
  var _tuesdayEndTimingController = TextEditingController();
  var _wednesdayEndTimingController = TextEditingController();
  var _thursdayEndTimingController = TextEditingController();
  var _fridayEndTimingController = TextEditingController();
  var _saturdayEndTimingController = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < 7; i++) {
      var closingDay = ClosedDaysModel();
      closingDay.isOpen = true;
      closingDay.dayOfWeek = i;
      _closedDaysList.add(closingDay);
    }
    _sundayStartTimingController.text = '00';
    _mondayStartTimingController.text = '08';
    _tuesdayStartTimingController.text = '08';
    _wednesdayStartTimingController.text = '08';
    _thursdayStartTimingController.text = '08';
    _fridayStartTimingController.text = '08';
    _saturdayStartTimingController.text = '08';
    _sundayEndTimingController.text = '00';
    _mondayEndTimingController.text = '17';
    _tuesdayEndTimingController.text = '17';
    _wednesdayEndTimingController.text = '17';
    _thursdayEndTimingController.text = '17';
    _fridayEndTimingController.text = '17';
    _saturdayEndTimingController.text = '13';
    for (var i = 0; i < 7; i++) {
      var dayTimeModel = DayTimeModel();
      dayTimeModel.startHours = 0;
      dayTimeModel.endHours = 0;
      dayTimeModel.startMinutes = 0;
      dayTimeModel.endMinutes = 0;
      _list.add(dayTimeModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppToolbars.toolbarForResultScreen(
          title: 'Edit Hours',
          context: context,
          listener: this,
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Navigator.pop(context, null);
      },
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Set your business hours below\nPress - icon to mark as closed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            _getRow(
              0,
              'Sunday',
              _sundayStartTimingController,
              _sundayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              1,
              'Monday',
              _mondayStartTimingController,
              _mondayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              2,
              'Tuesday',
              _tuesdayStartTimingController,
              _tuesdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              3,
              'Wednesday',
              _wednesdayStartTimingController,
              _wednesdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              4,
              'Thursday',
              _thursdayStartTimingController,
              _thursdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              5,
              'Friday',
              _fridayStartTimingController,
              _fridayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              6,
              'Saturday',
              _saturdayStartTimingController,
              _saturdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRow(
    int index,
    String label,
    TextEditingController startTime,
    TextEditingController endTime,
  ) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: startTime.text == '00' || endTime.text == '00'
                  ? Colors.red
                  : Colors.black38,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            startTime.text = '00';
            endTime.text = '00';
            setState(() {});
          },
          child: Icon(Icons.remove_circle),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () async {
            TimeOfDay startTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 00, minute: 00),
            );
            _list[index].startHours = startTimeOfDay.hour;
            _list[index].startMinutes = startTimeOfDay.minute;
            var hours;
            if (startTimeOfDay.hour < 10) {
              hours = '0${startTimeOfDay.hour}';
            } else {
              hours = startTimeOfDay.hour;
            }
            if (_list[index].startHours < _list[index].endHours) {
              AppToast.showToast(
                  message: 'Start time must be earlier than end time');
            } else {
              setState(() {
                startTime.text = '$hours';
              });
            }
          },
          child: Others.timingBox(label: startTime.text),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.remove,
          color: Colors.black54,
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () async {
            TimeOfDay endTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 00, minute: 00),
            );
            _list[index].endHours = endTimeOfDay.hour;
            _list[index].endMinutes = endTimeOfDay.minute;
            var hours, minutes;
            if (endTimeOfDay.hour < 10) {
              hours = '0${endTimeOfDay.hour}';
            } else {
              hours = endTimeOfDay.hour;
            }
            if (endTimeOfDay.minute < 10) {
              minutes = '0${endTimeOfDay.minute}';
            } else {
              minutes = endTimeOfDay.minute;
            }
            if (_list[index].startHours > _list[index].endHours) {
              AppToast.showToast(
                  message: 'End time cannot be earlier than start time');
            } else {
              setState(() {
                endTime.text = '$hours:$minutes';
              });
            }
          },
          child: Others.timingBox(label: endTime.text),
        ),
      ],
    );
  }

  @override
  void onTrailingClick() {
    String sundayStartTime = _sundayStartTimingController.text;
    String mondayStartTime = _mondayStartTimingController.text;
    String tuesdayStartTime = _tuesdayStartTimingController.text;
    String wednesdayStartTime = _wednesdayStartTimingController.text;
    String thursdayStartTime = _thursdayStartTimingController.text;
    String fridayStartTime = _fridayStartTimingController.text;
    String saturdayStartTime = _saturdayStartTimingController.text;

    String sundayEndTime = _sundayEndTimingController.text;
    String mondayEndTime = _mondayEndTimingController.text;
    String tuesdayEndTime = _tuesdayEndTimingController.text;
    String wednesdayEndTime = _wednesdayEndTimingController.text;
    String thursdayEndTime = _thursdayEndTimingController.text;
    String fridayEndTime = _fridayEndTimingController.text;
    String saturdayEndTime = _saturdayEndTimingController.text;

    if (sundayStartTime == '00' &&
        mondayStartTime == '00' &&
        tuesdayStartTime == '00' &&
        wednesdayStartTime == '00' &&
        thursdayStartTime == '00' &&
        fridayStartTime == '00' &&
        saturdayStartTime == '00' &&
        sundayEndTime == '00' &&
        mondayEndTime == '00' &&
        tuesdayEndTime == '00' &&
        wednesdayEndTime == '00' &&
        thursdayEndTime == '00' &&
        fridayEndTime == '00' &&
        saturdayEndTime == '00') {
      AppToast.showToast(message: 'You can\'t stay closed for all days');
    } else {
      TimingModel timingModel = TimingModel();

      if (sundayStartTime == '00' || sundayEndTime == '00') {
        timingModel.sundayStart = '00';
        timingModel.sundayEnd = '00';
      } else {
        timingModel.sundayStart = sundayStartTime;
        timingModel.sundayEnd = sundayEndTime;
      }

      if (mondayStartTime == '00' || mondayEndTime == '00') {
        timingModel.mondayStart = '00';
        timingModel.mondayEnd = '00';
      } else {
        timingModel.mondayStart = mondayStartTime;
        timingModel.mondayEnd = mondayEndTime;
      }

      if (tuesdayStartTime == '00' || tuesdayEndTime == '00') {
        timingModel.tuesdayStart = '00';
        timingModel.tuesdayEnd = '00';
      } else {
        timingModel.tuesdayStart = tuesdayStartTime;
        timingModel.tuesdayEnd = tuesdayEndTime;
      }

      if (wednesdayStartTime == '00' || wednesdayEndTime == '00') {
        timingModel.wednesdayStart = '00';
        timingModel.wednesdayEnd = '00';
      } else {
        timingModel.wednesdayStart = wednesdayStartTime;
        timingModel.wednesdayEnd = wednesdayEndTime;
      }

      if (thursdayStartTime == '00' || thursdayEndTime == '00') {
        timingModel.thursdayStart = '00';
        timingModel.thursdayEnd = '00';
      } else {
        timingModel.thursdayStart = thursdayStartTime;
        timingModel.thursdayEnd = thursdayEndTime;
      }

      if (fridayStartTime == '00' || fridayEndTime == '00') {
        timingModel.fridayStart = '00';
        timingModel.fridayEnd = '00';
      } else {
        timingModel.fridayStart = fridayStartTime;
        timingModel.fridayEnd = fridayEndTime;
      }

      if (saturdayStartTime == '00' || saturdayEndTime == '00') {
        timingModel.saturdayStart = '00';
        timingModel.saturdayEnd = '00';
      } else {
        timingModel.saturdayStart = saturdayStartTime;
        timingModel.saturdayEnd = saturdayEndTime;
      }
      Navigator.pop(context, timingModel);
    }
  }
}
