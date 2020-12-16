import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makhosi_app/contracts/i_trailing_clicked.dart';
import 'package:makhosi_app/models/ClosedDaysModel.dart';
import 'package:makhosi_app/models/DayTimeModel.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
  Color circle_color = Colors.teal[300];
  final GlobalKey<SlideActionState> _key = GlobalKey();
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
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF111747),
       
        child: Column(
        
          children: [
          
           
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              height: MediaQuery.of(context).size.height*1.1,
              child: Stack(
                children: [
                
                  Positioned(
                    top: MediaQuery.of(context).size.height * .26,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF111747),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .26,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Container(
                          //   height:MediaQuery.of(context).size.height*.24,
                          // ),
                          Center(
                            child: Text(
                              "Business Operating Hours",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                         
                          Text(
                            "Configure availibility",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select Date"),
                              Text("Select Start and End Time")
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
                          Text(
                            "Additional Information",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: circle_color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: 130,
                                        child: Text(
                                          "Availiable on Public Holidays ",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      child: Center(
                                        child: Text(
                                          "Availiable for Emergency Consuitations",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      child: SvgPicture.asset(
                        "images/timingHeader.svg",
                        semanticsLabel: 'Header',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SlideAction(
                  height: 60,
                  outerColor: Colors.teal[300],
                  key: _key,
                  onSubmit: () {
                    Future.delayed(
                      Duration(seconds: 1),
                      () => _key.currentState.reset(),
                    );
                  },
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Swipe to continue',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  sliderButtonIcon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.teal[300],
                  ),
                ),
              ),
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
              color: startTime.text == '00' || endTime.text == '00'
                  ? Colors.teal[300]
                  : Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: startTime.text == '00' || endTime.text == '00'
                  ? Colors.white
                  : Colors.black38,
            ),
          ),
        ),
        Spacer(),
        VerticalDivider(
          thickness: 2,
        ),
        GestureDetector(
          onTap: () {
            startTime.text = '00';
            endTime.text = '00';
            setState(() {});
          },
          child: Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 4,
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
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              height: 25,
              width: 80,
              decoration: BoxDecoration(
                color: startTime.text == '00' || endTime.text == '00'
                    ? Colors.teal[300]
                    : Colors.white,
                // border: Border.all(
                //   width: 1,
                //   color: Colors.black,
                // ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    startTime.text,
                    style: TextStyle(
                      color: startTime.text == '00' || endTime.text == '00'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.watch_later_outlined,
                      color: startTime.text == '00' || endTime.text == '00'
                          ? Colors.white
                          : Colors.black,
                      size: 19)
                ],
              ),
            )
           
            ),
        SizedBox(
          width: 4,
        ),
        
        SizedBox(
          width: 6,
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
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              height: 25,
              width: 80,
              decoration: BoxDecoration(
                color: startTime.text == '00' || endTime.text == '00'
                    ? Colors.teal[300]
                    : Colors.white,
                // border: Border.all(
                //   width: 1,
                //   color: Colors.black,
                // ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  Text(
                    endTime.text,
                    style: TextStyle(
                      color: startTime.text == '00' || endTime.text == '00'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.watch_later_outlined,
                      color: startTime.text == '00' || endTime.text == '00'
                          ? Colors.white
                          : Colors.black,
                      size: 19)
                ],
              ),
            )
            //  Others.timingBox(label: endTime.text),
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

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
