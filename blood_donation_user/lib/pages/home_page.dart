import 'package:blood_donation_user/auth/auth_prefr.dart';
import 'package:blood_donation_user/auth/login_page.dart';
import 'package:blood_donation_user/pages/history_page.dart';
import 'package:blood_donation_user/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../db/temp_db.dart';
import '../models/model_class.dart';
import 'donor_details.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String? bgroup;
  String? area;
  bool favorite = false;

  String shortVal1 = '';
  String shortVal2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
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
        bottom: bgroup == null ? PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          isExpanded: true,
                          value: bgroup,
                          hint: const Text('Select Your Blood Group'),
                          items: bgList.map((e) =>
                              DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  )),
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              bgroup = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) :
        PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          isExpanded: true,
                          value: bgroup,
                          hint: const Text('Select Your Blood Group'),
                          items: bgList.map((e) =>
                              DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  )),
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              bgroup = value;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: area,
                          hint: const Text('Select Your Area'),
                          items: areaList.map((e) =>
                              DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  )),
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              area = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: donor.length,
                itemBuilder: (context, index) {
                  String tempData1 = donor[index].bgroup;
                  String tempData2 = donor[index].area;
                  if(bgroup==null || area==null){
                    return Card(
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
                    );
                  }
                  else if(tempData1.contains(bgroup!) && tempData2.contains(area!)){
                    return Card(
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
                    );
                  }
                  return Container();
                }

              ),
            ),
          ],
        ),
      ),

    );
  }



}


