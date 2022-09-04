import 'package:blood_donation_user/auth/auth_prefr.dart';
import 'package:blood_donation_user/auth/login_page.dart';
import 'package:blood_donation_user/pages/history_page.dart';
import 'package:blood_donation_user/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../db/temp_db.dart';
import 'donor_details.dart';
import 'home_page.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int selectedIndex = 1;
  String? bGroup;
  String? area;
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite page'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    setLoginStatus(true).then((value) =>
                        Navigator.pushNamed(context, ProfilePage.routeName));
                  },
                  child: Text("Profile"),
                ),
                PopupMenuItem(
                  onTap: () {
                    setLoginStatus(false).then((value) =>
                        Navigator.pushReplacementNamed(context, LoginPage.routeName));
                  },
                  child: Text("Logout"),
                ),
              ]
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.pink,
        backgroundColor: Colors.white12,//Theme.of(context).primaryColor
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          if (selectedIndex == 0) {
            Navigator.pushReplacementNamed(
                context, HomePage.routeName);
          } else if (selectedIndex == 1) {
            Navigator.pushReplacementNamed(
                context, FavoritePage.routeName);
          } else if (selectedIndex == 2) {
            Navigator.pushReplacementNamed(
                context, HistoryPage.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: 'All Donor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorites'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.request_page), label: 'Requests'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: ListView.builder(
        itemCount: donor.length,
        itemBuilder: (context, index) =>
            donor[index].favorite ?
            Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, DonorDetails.routeName,
                    arguments: index
                ),
                title: Text(donor[index].name),
                subtitle: Text(donor[index].number),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(donor[index].image,
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(donor[index].bgroup,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.bloodtype,color: Colors.redAccent,size: 40,),
                  ],
                ),
              ),
            ) :
            SizedBox(),
      ),

    );
  }
}


