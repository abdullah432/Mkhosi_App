import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_trailing_clicked.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';

class AppToolbars {
  static Widget toolbar({
    @required BuildContext context,
    @required String title,
    @required bool isLeading,
    @required dynamic targetScreen,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      // title: Text(title),
      leading: isLeading
          ? IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: AppColors.REVERSE_ARROW,
              ),
              onPressed: () {
                NavigationController.pushReplacement(context, targetScreen);
              },
            )
          : IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: AppColors.REVERSE_ARROW,
              ),
              // onPressed: () {
              //   NavigationController.pushReplacement(context, targetScreen);
              // },
            ),
    );
  }

  static Widget toolbarForResultScreen({
    @required String title,
    @required BuildContext context,
    @required ITrailingClicked listener,
  }) {
    return AppBar(
      backgroundColor: AppColors.COLOR_WHITE,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.done,
          ),
          onPressed: listener != null
              ? () {
                  listener.onTrailingClick();
                }
              : null,
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context, null);
        },
      ),
    );
  }
}
