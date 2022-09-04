import 'dart:io';

import 'package:blood_donation_donor/models/model_class.dart';
import 'package:blood_donation_donor/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/donor_provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Size? size;
  int totalDonate = 0;
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String id = '';
  String name = '';
  String number = '';
  String email = '';
  String area = '';
  String bgroup = '';
  String gender = '';
  String password = '';
  String confirmpassword = '';
  String image = '';

  @override
  void initState() {
    getDonorData();
    super.initState();
  }

  Future<void> getDonorData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      id = sp.getString('id')!;
      name = sp.getString('name')!;
      number = sp.getString('number')!;
      email = sp.getString('email')!;
      area = sp.getString('area')!;
      bgroup = sp.getString('bgroup')!;
      gender = sp.getString('gender')!;
      password = sp.getString('password')!;
      confirmpassword = sp.getString('confirmpassword')!;
      image = sp.getString('image')!;

    });
  }

  @override
  Widget build(BuildContext context) {
    int donorId = int.parse(id);
    size = MediaQuery.of(context).size;
    print("ID: -> ${donorId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, EditPage.routeName);
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Consumer<DonorProvider>(
        builder: (context, provider, _) => FutureBuilder<DonorModel>(
          future: provider.getDonorById(donorId),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              final donorData = snapshot.data;
              return ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(donorData!.id.toString()),
                      Container(
                        width: size!.width,
                        height: 280,
                        decoration: const BoxDecoration(color: Colors.blue),
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:  donorData.image == null ?
                            donorData.gender == "Male" ?
                            Image.asset('images/male.png', height: 200, width: 200, fit: BoxFit.cover) :
                            Image.asset('images/female.png', height: 200, width: 200, fit: BoxFit.cover)

                                : Image.file(File(donorData.image!), height: 200, width: 200, fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            donorData.name,
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
                      title: const Text('Blood Group:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.bgroup,
                        style: const TextStyle(color: Colors.black,
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
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.number,
                        style: const TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'Email:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.email == null || donorData.email.toString().isEmpty ? 'No email added!'
                            : donorData.email.toString(),
                        style: donorData.email == null || donorData.email.toString().isEmpty
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
                      title: Text(
                        'Area:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.area,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Gender:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.gender == null || donorData.gender.toString().isEmpty ? 'Gender Not Selected!'
                            : donorData.gender.toString(),
                        style: donorData.gender == null || donorData.gender.toString().isEmpty
                            ? const TextStyle(color: Colors.grey)
                            : const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16, letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Last Donation Date:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        donorData.lastddate,
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('ID:',
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                      trailing: Text(
                        id,
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Total Donate', style: TextStyle(fontSize: 18, color: Colors.white),),
                        Text('$totalDonate', style: TextStyle(fontSize: 40, color: Colors.white),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              );
            }
            if(snapshot.hasError){
              return const Text('Failed to fetch data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
