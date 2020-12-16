import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class Consultations extends StatefulWidget {
  @override
  _ConsultationsState createState() => _ConsultationsState();
}

class _ConsultationsState extends State<Consultations>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _newClientSnapshot;
  var _oldClientSnapshot;
  var _onlineSnapshot;
  List<DocumentSnapshot> _newClientList = [];
  List<DocumentSnapshot> _oldClientList = [];
  List<DocumentSnapshot> _onlineList = [];
  bool isNewClient = false;
  bool isOldClient = false;
  bool isOnline = false;

  @override
  void initState() {
    super.initState();
    _getConsultationsNewClientData();
    _getConsultationsOldClientData();
    _getConsultationsOnlineData();

    _controller = AnimationController(vsync: this);
  }

  Future<void> _getConsultationsNewClientData() async {
    // _uid = FirebaseAuth.instance.currentUser.uid;
    _newClientSnapshot = await FirebaseFirestore.instance
        .collection("consultations")
        .orderBy("creation_date", descending: true)
        .get();
    _newClientSnapshot.docs.forEach((doc) {
      _newClientList.add(doc);
      print(doc.get("name"));
    });
    setState(() {});
  }

  Future<void> _getConsultationsOldClientData() async {
    // _uid = FirebaseAuth.instance.currentUser.uid;
    _oldClientSnapshot = await FirebaseFirestore.instance
        .collection("consultations")
        .orderBy("creation_date", descending: false)
        .get();
    _oldClientSnapshot.docs.forEach((doc) {
      _oldClientList.add(doc);
      print(doc.get("name"));
    });
    setState(() {});
  }

  Future<void> _getConsultationsOnlineData() async {
    // _uid = FirebaseAuth.instance.currentUser.uid;
    _onlineSnapshot = await FirebaseFirestore.instance
        .collection("consultations")
        .where("online", isEqualTo: true)
        .get();
    _onlineSnapshot.docs.forEach((doc) {
      _onlineList.add(doc);
      print(doc.get("name"));
    });
    setState(() {});
  }

  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: new IconButton(
            iconSize: 41.0,
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 41,
              color: Colors.black,
              tooltip: 'Increase volume by 10',
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Text(
                  'Today ‘s sessions',
                  style: TextStyle(
                    color: AppColors.BOLDTEXT_COLOR,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'New Clients and In-Person',
                      style: TextStyle(
                        color: AppColors.NORMAL_TEXT,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    leading: Radio(
                      value: isNewClient,
                      onChanged: (newCli) {
                        setState(() {
                          isNewClient = !newCli;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Online',
                      style: TextStyle(
                        color: AppColors.NORMAL_TEXT,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    leading: Radio(
                      value: isOldClient,
                      onChanged: (old) {
                        setState(() {
                          isOldClient = !old;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Old Clients',
                      style: TextStyle(
                        color: AppColors.NORMAL_TEXT,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    leading: Radio(
                      value: isOnline,
                      onChanged: (onli) {
                        setState(() {
                          isOnline = !onli;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    width: MediaQuery.of(context).size.width,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Keith Katyora, Pretoria',
                          style: TextStyle(
                            color: AppColors.SMALL_TEXT,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    width: MediaQuery.of(context).size.width,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sibu Mvana, Johannessburg',
                          style: TextStyle(
                            color: AppColors.SMALL_TEXT,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    width: MediaQuery.of(context).size.width,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sisanda Mbewu, Midrand',
                          style: TextStyle(
                            color: AppColors.SMALL_TEXT,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        // SizedBox(width:,)
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        // ],
        // )),
        );
  }
}
