
import 'package:blood_donation_user/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'auth/auth_prefr.dart';
import 'auth/login_page.dart';
import 'auth/registration_page.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher_page';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }

  @override
  void initState() {
    getLoginStatus().then((value) {
      if (value){
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
  }
}
