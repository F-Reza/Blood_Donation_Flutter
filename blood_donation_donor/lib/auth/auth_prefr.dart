
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLoginStatus(bool status) async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.setBool('isLoggedIn', status);
}

Future<bool> getLoginStatus() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}