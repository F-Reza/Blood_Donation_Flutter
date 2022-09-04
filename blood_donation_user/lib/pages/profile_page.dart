import 'dart:io';

import 'package:blood_donation_user/models/model_class.dart';
import 'package:blood_donation_user/pages/edit_page.dart';
import 'package:blood_donation_user/provider/need_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Size? size;

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  //Set Data
  Future setSP(NeederModel needer) async {
    final SharedPreferences sp = await _pref;
    sp.setInt('id', needer.id!);
    sp.setInt('id', needer.id!);
    sp.setString('name', needer.name);
    sp.setString('number', needer.number);
    sp.setString('email', needer.email.toString());
    sp.setString('area', needer.area);
    sp.setString('bgroup', needer.bgroup);
    sp.setString('gender', needer.gender.toString());
    sp.setString('password', needer.password);
    sp.setString('confirmpassword', needer.confirmpassword);
    sp.setString('image', needer.image.toString());
  }


  int id = 0;
  /*String name = '';
  String number = '';
  String email = '';
  String area = '';
  String bgroup = '';
  String gender = '';
  String password = '';
  String confirmpassword = '';
  String image = '';*/

  @override
  void initState() {
    getNeederData();
    super.initState();
  }

  //Get Data
  Future<void> getNeederData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      id = sp.getInt('id')!;
/*    name = sp.getString('name')!;
      number = sp.getString('number')!;
      email = sp.getString('email')!;
      area = sp.getString('area')!;
      bgroup = sp.getString('bgroup')!;
      gender = sp.getString('gender')!;
      password = sp.getString('password')!;
      confirmpassword = sp.getString('confirmpassword')!;
      image = sp.getString('image')!;*/
      print("ID: -> ${id}");
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditPage.routeName);
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: Consumer<NeedProvider>(
        builder: (context, provider, _) => FutureBuilder<NeederModel>(
          future: provider.getNeederById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final neederData = snapshot.data;
              setSP(neederData!).whenComplete((){});
              return ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(neederData.id.toString()),
                      Container(
                        width: size!.width,
                        height: 280,
                        decoration: const BoxDecoration(color: Colors.blue),
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: neederData.image == null ||  neederData.image == 'null'?
                            neederData.gender == "Male" ?
                            Image.asset('images/male.png', height: 200, width: 200, fit: BoxFit.cover) :
                            neederData.gender == 'Female' ?
                            Image.asset('images/female.png', height: 200, width: 200, fit: BoxFit.cover)
                            : Image.asset('images/person.png', height: 200, width: 200, fit: BoxFit.cover)

                            : Image.file(File(neederData.image.toString()),
                                    height: 200, width: 200, fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            neederData.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 1,
                                wordSpacing: 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Blood Group:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.bgroup,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Mobile:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.number,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Email:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.email == null ||
                                neederData.email.toString().isEmpty
                            ? 'No email added!'
                            : neederData.email.toString(),
                        style: neederData.email == null ||
                                neederData.email.toString().isEmpty
                            ? const TextStyle(color: Colors.grey)
                            : const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Area:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.area,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Gender:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.gender,
                        style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: ListTile(
                      title: const Text(
                        'ID:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        neederData.id.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Failed to fetch data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
