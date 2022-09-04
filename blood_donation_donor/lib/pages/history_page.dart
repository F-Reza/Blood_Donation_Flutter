
import 'package:blood_donation_donor/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../auth/auth_prefr.dart';
import '../auth/login_page.dart';
import 'home_page.dart';
import 'needer_details.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/request';
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedIndex = 1;
  String? bGroup;
  String? area;
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History page'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    setLoginStatus(false).then((value) =>
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
                context, HistoryPage.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: 'All Request'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Card(
            color: Colors.grey[100],
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context, NeederDetails.routeName,
              ),
              title: Text('Arko',style: TextStyle(fontSize: 25),),
              subtitle: Text('20/07/2022',style: TextStyle(fontSize: 16),),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('images/male.png',
                    height: 50, width: 50, fit: BoxFit.cover),
              ),
              trailing: Container(
                width: 110,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Accepted', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Card(
            color: Colors.grey[100],
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context, NeederDetails.routeName,
              ),
              title: Text('Konok',style: TextStyle(fontSize: 25),),
              subtitle: Text('20/07/2022',style: TextStyle(fontSize: 16),),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('images/female.png',
                    height: 50, width: 50, fit: BoxFit.cover),
              ),
              trailing: Container(
                width: 110,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Accepted', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Card(
            color: Colors.grey[100],
            child: ListTile(
              title: Text('Rafi',style: TextStyle(fontSize: 25),),
              subtitle: Text('20/07/2022',style: TextStyle(fontSize: 16),),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('images/person.png',
                    height: 50, width: 50, fit: BoxFit.cover),
              ),
              trailing: Container(
                width: 110,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Rejected', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),

    );
  }
}


