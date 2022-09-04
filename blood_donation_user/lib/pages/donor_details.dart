import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../db/temp_db.dart';

class DonorDetails extends StatefulWidget {
  static const String routeName = '/details';
  const DonorDetails({Key? key}) : super(key: key);

  @override
  State<DonorDetails> createState() => _DonorDetailsState();
}

class _DonorDetailsState extends State<DonorDetails> {
  Size? size;
  final locationController = TextEditingController();
  final commentController = TextEditingController();
  final _formKeyLoc = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  bool isExpanded = true;
  int index = 0;
  int totalDonate = 0;

  @override
  void dispose() {
    locationController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    index = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Details'),
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
                    child: Image.asset(donor[index].image,
                        height: 200, width: 200, fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    donor[index].name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1,
                        wordSpacing: 1),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(donor[index].bgroup,
                    style: TextStyle(color: Colors.white, fontSize: 28)
                ),
              ),
              Positioned(
                top: 15,
                right: 10,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      donor[index].favorite = !donor[index].favorite;
                    });
                  },
                  child: Icon(
                    !donor[index].favorite ?
                    Icons.favorite_border : Icons.favorite,
                    color: Colors.white,size: 35,
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: ListTile(
              title: Text(donor[index].number,style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500,),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () async {
                    final uri = Uri.parse('tel:donor[index].number');

                    if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                    } else {
                    throw 'Cannot launch message app';
                    }
                  },
                    icon: const Icon(Icons.call,size: 30,color: Colors.greenAccent,),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(onPressed: () async {
                    final uri = Uri.parse('sms:donor[index].number');

                    if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                    } else {
                    throw 'Cannot launch call app';
                    }
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
                donor[index].email,
                style: TextStyle(
                    ),
              ),
              trailing: IconButton(onPressed: () async {
                final uri = Uri.parse('mailTo:donor[index].email');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Cannot launch mail app';
                }
              },
                icon: const Icon(Icons.email,size: 30,color: Colors.redAccent,),
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
              trailing: Text(donor[index].area,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Gender:',
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              trailing: Text(
                donor[index].gender,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          if (isExpanded )Card(
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKeyLoc,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Your Location',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      width: 200,
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blueAccent,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKeyLoc.currentState!.validate()) {
                            setState(() {
                              isExpanded = false;
                              print('isExpanded: ${isExpanded}');
                            });
                          }
                        },
                        child: const Text('Send Request',
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
          if (!isExpanded )Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Container(
              width: 200,
              height: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.redAccent,
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = true;
                    print('isExpanded: ${isExpanded}');
                  });
                },
                child: const Text('Request Cancel',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
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

          const SizedBox(height: 35,),
          const Text('Optional',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Container(height: 1,color: Colors.grey,),
          Card(
            child: ListTile(
              title: const Text('Rating',
                style: TextStyle(fontSize: 22),
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
                    const SizedBox(height: 15,),
                    Container(
                      width: 110,
                      height: 35,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          }
                        },
                        child: const Text('Submit',
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Card(
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                trailing: Text('4+',style: const TextStyle(fontSize: 18),),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('images/male.png',
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
                title: Text('Farhan Morshed', style: const TextStyle(fontSize: 18),),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('25/07/2022'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(comment,style: TextStyle(fontSize: 16),),
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
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('25/07/2022'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(comment,style: TextStyle(fontSize: 16),),
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
                trailing: Text('5.0',style: TextStyle(fontSize: 18),),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('images/female.png',
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
                title: Text('Konok', style: TextStyle(fontSize: 18),),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('25/07/2022'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(comment,style: TextStyle(fontSize: 16),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


String comment = '''Lorem ipsum dolor sit amet, Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''';