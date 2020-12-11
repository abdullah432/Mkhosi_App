import 'package:flutter/material.dart';

class NavigationController {
  static pushReplacement(BuildContext context, Object targetClass) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return targetClass;
    }));
  }

  static push(BuildContext context, Object targetClass) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return targetClass;
    }));
  }
}
