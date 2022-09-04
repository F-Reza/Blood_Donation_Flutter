





 List<Needer> needer = [
  Needer(
    id: 1,
    name: 'Farhan Morshed',
    number: '01751456879',
    email: 'farhan@gmail.com',
    location: 'Rangpur',
    request: '28/07/2022',
    gender: 'Male',
    favorite: true,
    image: 'images/male.png',
  ),
  Needer(
    id: 2,
    name: 'Abid Azmain',
    number: '01704370139',
    email: 'abidazmain@gmail.com',
    location: 'Khulna',
    request: '23/07/2022',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),
  Needer(
    id: 3,
    name: 'Konok',
    number: '01766891107',
    email: 'rana123@gmail.com',
    location: 'Dhaka',
    request: '22/07/2022',
    gender: 'Female',
    favorite: true,
    image: 'images/female.png',
  ),
  Needer(
    id: 4,
    name: 'Al Amin',
    number: '01997793603',
    email: 'alamin33@gmail.com',
    location: 'Barishal',
    request: '21/07/2022',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),


];



class Needer {
  int id;
  String name;
  String number;
  String email;
  String location;
  String request;
  String gender;
  bool favorite;
  String image;

  Needer(
      {required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.location,
        required this.request,
        required this.gender,
        this.favorite = false,
        required this.image}
      );
}
