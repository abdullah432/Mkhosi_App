import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  Future<void> setUserType(ClickType userType) async {
    String userStringType;
    switch (userType) {
      case ClickType.PATIENT:
        userStringType = AppKeys.PATIENT;
        break;
      case ClickType.PRACTITIONER:
        userStringType = AppKeys.PRACTITIONER;
        break;
    }
    var pref = await SharedPreferences.getInstance();
    await pref.setString(AppKeys.USER_TYPE, userStringType);
    await pref.commit();
  }

  Future<String> getUserType() async {
    return (await SharedPreferences.getInstance())
            .getString(AppKeys.USER_TYPE) ??
        'null';
  }
}
