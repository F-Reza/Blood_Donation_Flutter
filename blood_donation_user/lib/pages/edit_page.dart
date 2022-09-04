import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood_donation_user/models/model_class.dart';
import 'package:blood_donation_user/provider/need_provider.dart';

import '../models/model_class.dart';
import '../provider/need_provider.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/edit';

  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();


  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int id = 0;
  String number = '';
  String area = '';
  String bgroup = '';
  String gender = '';
  String password = '';
  String confirmpassword = '';
  String image = '';

  @override
  void initState() {
      getNeederData();
    super.initState();
  }
  Future<void> getNeederData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      id = sp.getInt('id')!;
      nameController.text = sp.getString('name')!;
      number = sp.getString('number')!;
      if(sp.getString('email') == 'null'){
        emailController.text = '';
      }
      else{
        emailController.text = sp.getString('email')!;
      }
      area = sp.getString('area')!;
      bgroup = sp.getString('bgroup')!;
      gender = sp.getString('gender')!;
      password = sp.getString('password')!;
      confirmpassword = sp.getString('confirmpassword')!;
      image = sp.getString('image')!;
      print("ID: -> ${id}");
    });

  }

  /*Future updateSP(NeederModel neederModel) async {
  }
  updateNeeder() async{

    NeederModel neederModel = NeederModel(
        id: id,
        name: nameController.text,
        email: emailController.text,
        number: number,
        bgroup: bgroup,
        area: area,
        gender: gender,
        password: password,
        confirmpassword: confirmpassword
      //image: _imagePath
    );

    if (formKey.currentState!.validate()) {
       await DBHelper.updateNeeder(neederModel).then((value) => {
        if(value == 1) {
           updateSP(neederModel).whenComplete((){
             Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,);
        }),

        } else{
          Fluttertoast.showToast(
            msg: "Update Failed!",
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,)
        }
      }).catchError((error){
        print('Error: ${error}');
        Fluttertoast.showToast(
          msg: "Error!",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,);
      });

    }

  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
        actions: [
          Consumer<NeedProvider>(
            builder:(context,provider,_) =>IconButton(
                  onPressed: (){
                    provider.updateInfo(id, nameController.text, emailController.text, bgroup, area, gender,image).then((value) {
                      setState(() {

                      });
                    });
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save)
            ),
          ),
        ],
      ),
      body: Consumer<NeedProvider>(
        builder: (context, provider, _) => FutureBuilder<NeederModel>(
          future: provider.getNeederById(id),
          builder: (context, snapshot) {
            if (_imagePath == null) {
              image = image;
            }else{
              image = _imagePath.toString();
            }
            if (snapshot.hasData) {
              final neederData = snapshot.data;
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              elevation: 10,
                              child: image == 'null' ||  image == null ?
                              Image.asset('images/person.png',height: 160, width: 150,fit: BoxFit.cover,) :
                              _imagePath == null ?
                              Image.file(File(image),height: 160, width: 150,fit: BoxFit.cover,):
                              Image.file(File(_imagePath!),height: 160, width: 150,fit: BoxFit.cover,),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      _imageSource = ImageSource.camera;
                                      _getImage();
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera')),
                                TextButton.icon(
                                    onPressed: () {
                                      _imageSource = ImageSource.gallery;
                                      _getImage();
                                    },
                                    icon: const Icon(Icons.photo),
                                    label: const Text('Gallery')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
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
                            value: bgroup,
                            hint: const Text('Select Your Blood Group'),
                            items: bgList
                                .map(
                                  (e) => DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(e),
                                  )),
                            )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => bgroup = value!),
                            validator: (value) => value == null ? 'field required' : null,
                          ),
                        ),
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
                                  (e) => DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(e),
                                  )),
                            )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => area = value!),
                            validator: (value) => value == null ? 'field required' : null,
                          ),
                        ),
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
                                  (e) => DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(e),
                                  )),
                            )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => gender = value!),
                            validator: (value) => value == null ? 'field required' : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Failed to fetch data!'),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }



  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
      });
    }
  }


}

