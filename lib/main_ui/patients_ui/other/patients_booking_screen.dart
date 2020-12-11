import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_info_dialog_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class PatientsBookingScreen extends StatefulWidget {
  DocumentSnapshot _snapshot;

  PatientsBookingScreen(this._snapshot);

  @override
  _PatientsBookingScreenState createState() => _PatientsBookingScreenState();
}

class _PatientsBookingScreenState extends State<PatientsBookingScreen>
    implements IInfoDialogClicked, IRoundedButtonClicked {
  Map<String, dynamic> _timingMap;
  String _selectedDate, _day, _selectionDescriptionLabel = '';
  int _selectedHour;
  List<DocumentSnapshot> _bookingList = [];
  bool _isLoading = true;
  List<DocumentSnapshot> _dayBookingsList = [];

  @override
  void initState() {
    _timingMap = widget._snapshot.get(AppKeys.TIMINGS);
    _getBookings();
    super.initState();
  }

  Future<void> _getBookings() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('appointment_to', isEqualTo: widget._snapshot.id)
          .get();
      snapshot.docs.forEach((booking) {
        _bookingList.add(booking);
      });
      setState(() {
        _isLoading = false;
      });
    } catch (exc) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 32,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getPractitionerDetailsSection(),
                    _getDatePickerButton(),
                    Others.getSizedBox(boxHeight: 12, boxWidth: 0),
                    _getTimeSelectionSection(),
                    Others.getSizedBox(boxHeight: 32, boxWidth: 0),
                    _getLabelText('Email Address'),
                    _getLabelBody(widget._snapshot.get(AppKeys.EMAIL)),
                    Others.getSizedBox(boxHeight: 24, boxWidth: 0),
                    _getLabelText('Appointment Date & Time'),
                    _getResultLabel(),
                    Others.getSizedBox(boxHeight: 24, boxWidth: 0),
                    AppButtons.getRoundedButton(
                      context: context,
                      iRoundedButtonClicked: this,
                      label: 'Confirm Booking',
                      clickType: ClickType.DUMMY,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _getLabelBody(label) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      color: Colors.black12,
      width: ScreenDimensions.getScreenWidth(context),
      padding: EdgeInsets.all(8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _getLabelText(label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getResultLabel() {
    return _selectionDescriptionLabel.isNotEmpty
        ? Row(
            children: [
              Expanded(
                child: Text(
                  _selectionDescriptionLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.COLOR_PRIMARY,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _getTimeSelectionSection() {
    List<int> timingList = _getTimingHoursList();
    List<int> bookedHours = [];
    if (timingList.isNotEmpty) {
      timingList.removeAt(timingList.length - 1);
      timingList.removeAt(timingList.length - 1);

      //availability check
      if (_dayBookingsList.isNotEmpty) {
        for (var booking in _dayBookingsList) {
          bookedHours.add(booking.get('appointment_start_hour'));
          bookedHours.add(booking.get('appointment_start_hour') + 1);
          bookedHours.add(booking.get('appointment_start_hour') - 1);
        }
      }
    }
    return timingList.isNotEmpty
        ? Wrap(
            children: timingList.map(
              (hour) {
                bool isAvailable = true;
                if (bookedHours.isNotEmpty) {
                  for (var i in bookedHours) {
                    if (i == hour) {
                      isAvailable = false;
                      break;
                    }
                  }
                }
                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                          if (_selectedHour != hour) {
                            _selectedHour = hour;
                            _selectionDescriptionLabel =
                                '$_selectedDate at ${_selectedHour <= 12 ? '$_selectedHour AM' : '${_selectedHour - 12} PM'} ';
                          } else {
                            _selectedHour = null;
                            _selectionDescriptionLabel = '';
                          }
                          setState(() {});
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 12),
                    width: ScreenDimensions.getScreenWidth(context) / 5.1,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? _selectedHour == hour
                              ? AppColors.COLOR_PRIMARY
                              : Colors.transparent
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isAvailable
                            ? _selectedHour == hour
                                ? Colors.transparent
                                : AppColors.COLOR_PRIMARY
                            : Colors.black54,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      hour <= 12 ? '$hour AM' : '${hour - 12} PM',
                      style: TextStyle(
                        fontSize: 13,
                        color: isAvailable
                            ? _selectedHour == hour
                                ? Colors.white
                                : AppColors.COLOR_PRIMARY
                            : Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          )
        : Container(
            height: 150,
            width: ScreenDimensions.getScreenWidth(context),
            child: AppStatusComponents.errorBody(message: 'Not available'),
          );
  }

  List<int> _getTimingHoursList() {
    try {
      List<int> hoursList = [];
      int openHour = int.parse(_timingMap['${_day.toLowerCase()}_open']);
      int closeHour = int.parse(_timingMap['${_day.toLowerCase()}_close']);
      if (openHour == 0 && closeHour == 0) {
        return [];
      } else {
        for (int i = openHour; i <= closeHour; i++) {
          hoursList.add(i);
        }
        return hoursList;
      }
    } catch (exc) {
      return [];
    }
  }

  Widget _getDatePickerButton() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Available Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(days: 30),
              ),
            );
            if (selectedDate != null) {
              _getDayName(selectedDate.weekday);
              _selectedDate =
                  '${selectedDate.day < 10 ? '0${selectedDate.day}' : selectedDate.day}/${selectedDate.month < 10 ? '0${selectedDate.month}' : selectedDate.month}/${selectedDate.year}';
              _dayBookingsList.clear();
              _bookingList.forEach((booking) {
                if (booking.get('appointment_date') == _selectedDate) {
                  _dayBookingsList.add(booking);
                }
              });
              setState(() {
                _selectedHour = null;
                _selectionDescriptionLabel = '';
              });
            }
          },
          child: Container(
            height: 40,
            color: AppColors.COLOR_PRIMARY,
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
                Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                Text(
                  _selectedDate == null ? 'Select Date' : '$_selectedDate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _getDayName(int day) {
    switch (day) {
      case 1:
        {
          _day = 'Monday';
          break;
        }
      case 2:
        {
          _day = 'Tuesday';
          break;
        }
      case 3:
        {
          _day = 'Wednesday';
          break;
        }
      case 4:
        {
          _day = 'Thursday';
          break;
        }
      case 5:
        {
          _day = 'Friday';
          break;
        }
      case 6:
        {
          _day = 'Saturday';
          break;
        }
      case 7:
        {
          _day = 'Sunday';
          break;
        }
    }
  }

  Widget _getPractitionerDetailsSection() {
    bool isOnline = widget._snapshot.get(AppKeys.ONLINE);
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      width: ScreenDimensions.getScreenWidth(context),
      child: Row(
        children: [
          widget._snapshot.get(AppKeys.PROFILE_IMAGE) != null
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    widget._snapshot.get(AppKeys.PROFILE_IMAGE),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 45,
                    ),
                  ),
                ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget._snapshot.get(AppKeys.FIRST_NAME)} ${widget._snapshot.get(AppKeys.SECOND_NAME)}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.brightness_1,
                      color: isOnline ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                    Text(isOnline ? 'Online' : 'Offline'),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.subdirectory_arrow_left_rounded,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
    Navigator.pop(context);
    try {
      var data = {
        'appointment_start_hour': _selectedHour,
        'appointment_date': _selectedDate,
        'appointment_by': FirebaseAuth.instance.currentUser.uid,
        'appointment_to': widget._snapshot.id,
      };
      await FirebaseFirestore.instance.collection('bookings').add(data);
      Navigator.pop(context);
      Navigator.pop(context);
      AppToast.showToast(message: 'Appointment successfully made');
    } catch (exc) {
      AppToast.showToast(message: 'Error booking practitioner');
    }
  }

  @override
  onClick(ClickType clickType) {
    if (_selectedHour != null) {
      Others.showInfoDialog(
        context: context,
        title: 'Booking Confirmation!',
        message:
            'Are you sure you want to make appointment on $_selectionDescriptionLabel?',
        positiveButtonLabel: 'Confirm',
        negativeButtonLabel: 'Cancel',
        iInfoDialogClicked: this,
        isInfo: false,
      );
    } else {
      Others.showInfoDialog(
        context: context,
        title: 'Error!',
        message: 'Please select booking date and time first',
        positiveButtonLabel: null,
        negativeButtonLabel: 'Close',
        iInfoDialogClicked: this,
        isInfo: true,
      );
    }
  }
}
