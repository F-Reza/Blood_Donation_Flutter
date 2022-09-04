import 'package:blood_donation_donor/auth/registration_page.dart';
import 'package:blood_donation_donor/models/model_class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db_helper_user.dart';
import '../pages/home_page.dart';
import 'auth_prefr.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  final formKey = GlobalKey<FormState>();

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Future setSP(DonorModel donor) async {
    final SharedPreferences sp = await _pref;
    //sp.setInt('id', needer.id!);
    sp.setString('id', donor.id.toString());
    sp.setString('name', donor.name);
    sp.setString('number', donor.number);
    sp.setString('email', donor.email.toString());
    sp.setString('area', donor.area);
    sp.setString('bgroup', donor.bgroup);
    sp.setString('gender', donor.gender.toString());
    sp.setString('password', donor.password);
    sp.setString('confirmpassword', donor.confirmpassword);
    sp.setString('image', donor.image.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/blood-icon.png',
                          width: 200,
                          height: 200,
                        ),
                        const Text(
                          'DONOR',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: numberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Mobile Number',
                              prefixIcon: const Icon(Icons.call)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field must not be empty!';
                            } else {
                              if (value.length == 11) {
                                return null;
                              } else if (value.length > 11) {
                                return 'The number is greater than 11';
                              } else if (value.length < 11) {
                                return 'The number is less than 11';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password must not be empty!';
                            }
                            if (value.length < 6) {
                              return 'Password min 6 character';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: double.maxFinite,
                          //height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextButton(
                            onPressed: _loginInfo,
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, SignUpPage.routeName);
                              },
                              child: const Text(
                                'Registration',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.pink),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }

  void _loginInfo() async {
    if (formKey.currentState!.validate()) {
      String donorNumber = numberController.text;
      String donorPassword = passwordController.text;

      await DBHelper.getLoginDonor(donorNumber, donorPassword)
          .then((donorData) {
        print('Login Successfully!');
        // print('Mobile:${neederNumber}');
        // print('Password:${neederPassword}');

        if (donorData != null) {
          setLoginStatus(true).then((value) =>
              Navigator.pushReplacementNamed(context, HomePage.routeName));

          setSP(donorData).whenComplete(() {
            Fluttertoast.showToast(
              msg: "Login Successfully!",
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          });
        } else {
          Fluttertoast.showToast(
            msg: "User Not Found!",
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
        }
      }).catchError((error) {
        //print(error);
        Fluttertoast.showToast(
          msg: "Number or Password Incorrect!",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
        );
      });
    }
  }
}
