import 'package:blood_donation_user/provider/need_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db_helper_user.dart';
import '../models/model_class.dart';
import '../pages/home_page.dart';
import 'auth_prefr.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();
  bool isObscure1 = true;
  bool isObscure2 = true;
  String? bgroup;
  String? area;
  String? gender;

  final formKey = GlobalKey<FormState>();

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

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

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/blood-icon.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'NEED',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Name',
                          prefixIcon: const Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty!';
                        }
                        if (value.length > 26) {
                          return 'name must be in 26 character';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Mobile',
                          prefixIcon: const Icon(Icons.phone)),
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
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: bgroup,
                          hint: const Text('Select Your Blood Group'),
                          items: bgList
                              .map(
                                (e) =>
                                DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(e),
                                    )),
                          )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => bgroup = value),
                          validator: (value) =>
                          value == null
                              ? 'field required'
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: area,
                          hint: const Text('Select Your Area'),
                          items: areaList
                              .map(
                                (e) =>
                                DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(e),
                                    )),
                          )
                              .toList(),
                          onChanged: (salutation) =>
                              setState(() => area = salutation),
                          validator: (value) =>
                          value == null
                              ? 'field required'
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: gender,
                          hint: const Text('Select Your Gender'),
                          items: genderList
                              .map(
                                (e) =>
                                DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(e),
                                    )),
                          )
                              .toList(),
                          onChanged: (salutation) =>
                              setState(() => gender = salutation),
                          validator: (value) =>
                          value == null
                              ? 'field required'
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: isObscure1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(isObscure1
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isObscure1 = !isObscure1;
                              });
                            },
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password must not be empty!';
                        }
                        else if (value.length < 6) {
                          return 'Password min 6 character';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: conformPasswordController,
                      obscureText: isObscure2,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Conform password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isObscure2 = !isObscure2;
                              });
                            },
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password must not be empty!';
                        }
                        else if (passwordController.text !=
                            conformPasswordController.text) {
                          return 'Confirm Password not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.maxFinite,
                      //height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextButton(
                        onPressed: _registrationInfo,
                        child: const Text(
                          'Registration',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account? ",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginPage.routeName);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.pink),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _registrationInfo() async {
    if (formKey.currentState!.validate()) {
      final needer = NeederModel(
        name: nameController.text,
        number: numberController.text,
        bgroup: bgroup.toString(),
        area: area.toString(),
        gender: gender.toString(),
        password: passwordController.text,
        confirmpassword: conformPasswordController.text,
      );
      String neederNumber = numberController.text;
      String neederPassword = passwordController.text;

      final status = await Provider.of<NeedProvider>(context, listen: false)
          .insertNeeder(needer);
      if (status) {
        setLoginStatus(true).then((value) =>
            Navigator.pushReplacementNamed(context, HomePage.routeName));

        await DBHelper.getLoginNeeder(neederNumber, neederPassword).then((
            neederData) {
          setSP(neederData).whenComplete(() async {
            Fluttertoast.showToast(
              msg: "Registration Successfully!",
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,);
          });
        }).catchError((error) {
          Fluttertoast.showToast(
            msg: "Registration failed!",
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
        });
      } else {}
    }
  }




}