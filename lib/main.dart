import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/general_ui/splash_screen.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/home_provider.dart';
import 'providers/details_provider.dart';
import 'ui/splash.dart';
import 'helper/constants.dart';
import 'ui_user/login.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard.dart';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(

    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.COLOR_PRIMARY,
        accentColor: AppColors.COLOR_PRIMARY,
        cursorColor: AppColors.COLOR_GREY,
        colorScheme: ColorScheme.light(primary: AppColors.COLOR_PRIMARY),
      ),

      home: BusinessCard(),
    ),
  );
}
