import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NeederDetails extends StatefulWidget {
  static const String routeName = '/details';
  const NeederDetails({Key? key}) : super(key: key);

  @override
  State<NeederDetails> createState() => _NeederDetailsState();
}

class _NeederDetailsState extends State<NeederDetails> {
  Size? size;
  final locationController = TextEditingController();
  final commentController = TextEditingController();
  final _formKeyLoc = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    locationController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Needer Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size!.width,
                height: 280,
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('images/male.png',
                        height: 200, width: 200, fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Needer Name',
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
              title: Text('01830996044',style: const TextStyle(fontSize: 18),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    //provider.callContact(model.number);
                  },
                    icon: const Icon(Icons.call,size: 30,color: Colors.greenAccent,),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    //provider.messageContact(model.number);
                  },
                    icon: const Icon(Icons.sms,size: 30,color: Colors.amberAccent,),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title:  Text(
                'info@gmail.com',
                style: TextStyle(
                    fontSize: 18,),
              ),
              trailing: IconButton(onPressed: (){

              },
                icon: const Icon(Icons.email,size: 30,color: Colors.redAccent,),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Mirpur, Dhaka',
                style: TextStyle(fontSize: 18,),
              ),
              trailing: IconButton(onPressed: (){
                //provider.locateContact(model.address!);
              },
                icon: const Icon(Icons.location_on,size: 30,color: Colors.redAccent,),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text('Gender:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: Text(
                'Male',
                style: TextStyle(fontSize: 18,),
              ),
            ),
          ),
          const SizedBox(height: 15,),
          const SizedBox(height: 35,),
          Text('Optional',
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Container(height: 1,color: Colors.grey,),
          Card(
            child: ListTile(
              title: const Text('Rating',
                style: TextStyle(fontSize: 24),
              ),
              trailing: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            )
          ),
          //const SizedBox(height: 20,),
          Card(
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: commentController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type Your Comment',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                trailing: Text('4+',style: TextStyle(fontSize: 18),),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('images/person.png',
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
                title: Text('Adid Azmain', style: TextStyle(fontSize: 18),),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(comment,style: TextStyle(fontSize: 16),),
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


String comment = ''' Lorem ipsum dolor sit amet, Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''';

