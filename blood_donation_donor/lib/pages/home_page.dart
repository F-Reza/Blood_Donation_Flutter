import 'package:blood_donation_donor/auth/auth_prefr.dart';
import 'package:blood_donation_donor/auth/login_page.dart';
import 'package:blood_donation_donor/db/temp_db.dart';
import 'package:blood_donation_donor/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'history_page.dart';
import 'needer_details.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isExpanded = true;

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
                            Navigator.pushNamed(
                                context, ProfilePage.routeName));
                      },
                      child: Text("Profile"),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setLoginStatus(false).then((value) =>
                            Navigator.pushReplacementNamed(
                                context, LoginPage.routeName));
                      },
                      child: Text("Logout"),
                    ),
                  ]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.pink,
        backgroundColor: Colors.white12, //Theme.of(context).primaryColor
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          if (selectedIndex == 0) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else if (selectedIndex == 1) {
            Navigator.pushReplacementNamed(context, HistoryPage.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: 'All Request'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (isExpanded )InkWell(
              onTap: () => Navigator.pushNamed(
                context, NeederDetails.routeName,
              ),
              child: Card(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        title: Text('Arko',style: TextStyle(fontSize: 25),),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('images/male.png',
                              height: 50, width: 50, fit: BoxFit.cover),
                        ),
                        trailing: Icon(Icons.bloodtype,color: Colors.red,size: 35,),
                      ),

                      ListTile(
                        title: Text(
                          'Mirpur, Dhaka',
                          style: TextStyle(
                              fontSize: 16, letterSpacing: 1),
                        ),
                        trailing: IconButton(onPressed: (){
                          //provider.locateContact(model.address!);
                        },
                          icon: const Icon(Icons.location_on,size: 35,color: Colors.redAccent,),
                        ),
                      ),
                      ListTile(
                          title:  Text(
                            'Request Date',
                            style: TextStyle(
                                fontSize: 16, letterSpacing: 1),
                          ),
                          trailing: Text('28/07/2022',style: TextStyle(
                              fontSize: 16, letterSpacing: 1),)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                Fluttertoast.showToast(
                                  msg: "Request Accepted!",
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.greenAccent,
                                  textColor: Colors.white,
                                  //fontSize: 16.0
                                );
                                isExpanded = false;
                                print('Valid: ${isExpanded}');
                              });
                            },
                            child: Container(
                              width: 110,
                              height: 40,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.green,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Accept', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Fluttertoast.showToast(
                                  msg: "Request Rejected!",
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  //fontSize: 16.0
                                );
                                isExpanded = false;
                                print('Valid: ${isExpanded}');
                              });
                            },
                            child: Container(
                              width: 110,
                              height: 40,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.redAccent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Reject', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: needer.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            NeederDetails.routeName,
                          ),
                          child: Card(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ListTile(
                                    title: Text(
                                      needer[index].name,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(needer[index].image,
                                          height: 50, width: 50, fit: BoxFit.cover),
                                    ),
                                    trailing: Icon(
                                      Icons.bloodtype,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      needer[index].location,
                                      style:
                                      TextStyle(fontSize: 16, letterSpacing: 1),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        //provider.locateContact(model.address!);
                                      },
                                      icon: const Icon(
                                        Icons.location_on,
                                        size: 35,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                      title: Text(
                                        'Request Date',
                                        style:
                                        TextStyle(fontSize: 16, letterSpacing: 1),
                                      ),
                                      trailing: Text(
                                        needer[index].request,
                                        style:
                                        TextStyle(fontSize: 16, letterSpacing: 1),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            Fluttertoast.showToast(
                                              msg: "Request Accepted!",
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.greenAccent,
                                              textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                            isExpanded = false;
                                            print('Valid: ${isExpanded}');
                                          });
                                        },
                                        child: Container(
                                          width: 110,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            color: Colors.green,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Accept',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            Fluttertoast.showToast(
                                              msg: "Request Rejected!",
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.redAccent,
                                              textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                            isExpanded = false;
                                            print('Valid: ${isExpanded}');
                                          });
                                        },
                                        child: Container(
                                          width: 110,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            color: Colors.redAccent,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Reject',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        )
      ),

      /*ListView(
        children: [
          if (isExpanded )InkWell(
            onTap: () => Navigator.pushNamed(
              context, NeederDetails.routeName,
            ),
            child: Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text('Arko',style: TextStyle(fontSize: 25),),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('images/person.png',
                            height: 50, width: 50, fit: BoxFit.cover),
                      ),
                      trailing: Icon(Icons.bloodtype,color: Colors.red,size: 35,),
                    ),

                    ListTile(
                      title: Text(
                        'Mirpur, Dhaka',
                        style: TextStyle(
                            fontSize: 16, letterSpacing: 1),
                      ),
                      trailing: IconButton(onPressed: (){
                        //provider.locateContact(model.address!);
                      },
                        icon: const Icon(Icons.location_on,size: 35,color: Colors.redAccent,),
                      ),
                    ),
                    ListTile(
                      title:  Text(
                        'Request Date',
                        style: TextStyle(
                            fontSize: 16, letterSpacing: 1),
                      ),
                      trailing: Text('28/07/2022',style: TextStyle(
                          fontSize: 16, letterSpacing: 1),)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Fluttertoast.showToast(
                                msg: "Request Accepted!",
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.greenAccent,
                                textColor: Colors.white,
                                //fontSize: 16.0
                              );
                              isExpanded = false;
                              print('Valid: ${isExpanded}');
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.green,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Accept', textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Fluttertoast.showToast(
                                msg: "Request Rejected!",
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                //fontSize: 16.0
                              );
                              isExpanded = false;
                              print('Valid: ${isExpanded}');
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.redAccent,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Reject', textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}
