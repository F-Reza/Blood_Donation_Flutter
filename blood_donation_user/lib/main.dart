
import 'package:blood_donation_user/pages/donor_details.dart';
import 'package:blood_donation_user/pages/edit_page.dart';
import 'package:blood_donation_user/pages/favorite_page.dart';
import 'package:blood_donation_user/pages/home_page.dart';
import 'package:blood_donation_user/pages/history_page.dart';
import 'package:blood_donation_user/pages/profile_page.dart';
import 'package:blood_donation_user/provider/need_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login_page.dart';
import 'auth/registration_page.dart';
import 'launcher_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => NeedProvider()..getAllNeeder()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        HomePage.routeName: (context) => HomePage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        EditPage.routeName: (context) => EditPage(),
        FavoritePage.routeName: (context) => FavoritePage(),
        HistoryPage.routeName: (context) => HistoryPage(),
        DonorDetails.routeName: (context) => DonorDetails(),
        LauncherPage.routeName: (context) => LauncherPage(),
      },
    );
  }
}
