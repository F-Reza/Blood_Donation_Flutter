import 'package:blood_donation_donor/pages/history_page.dart';
import 'package:blood_donation_donor/pages/needer_details.dart';
import 'package:blood_donation_donor/pages/edit_page.dart';
import 'package:blood_donation_donor/pages/home_page.dart';
import 'package:blood_donation_donor/pages/profile_page.dart';
import 'package:blood_donation_donor/provider/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login_page.dart';
import 'auth/registration_page.dart';
import 'launcher_page.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => DonorProvider()..getAllDonor()),
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
        LoginPage.routeName : (context) => LoginPage(),
        SignUpPage.routeName : (context) => SignUpPage(),
        HomePage.routeName : (context) => HomePage(),
        HistoryPage.routeName: (context) => HistoryPage(),
        NeederDetails.routeName : (context) => NeederDetails(),
        ProfilePage.routeName : (context) => ProfilePage(),
        EditPage.routeName : (context) => EditPage(),
        LauncherPage.routeName : (context) => LauncherPage(),
      },
    );
  }
}
