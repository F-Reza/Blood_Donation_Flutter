





 List<Donor> donor = [
  Donor(
    id: 1,
    name: 'Farhan Morshed',
    number: '01751456879',
    email: 'farhan@gmail.com',
    area: 'Rangpur',
    bgroup: 'A+',
    gender: 'Male',
    favorite: true,
    image: 'images/male.png',
  ),
  Donor(
    id: 2,
    name: 'Abid Azmain',
    number: '01704370139',
    email: 'abidazmain@gmail.com',
    area: 'Khulna',
    bgroup: 'B-',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),
  Donor(
    id: 3,
    name: 'Konok',
    number: '01766891107',
    email: 'konok123@gmail.com',
    area: 'Dhaka',
    bgroup: 'AB-',
    gender: 'Female',
    favorite: true,
    image: 'images/female.png',
  ),
  Donor(
    id: 4,
    name: 'Al Amin',
    number: '01997793603',
    email: 'alamin33@gmail.com',
    area: 'Barishal',
    bgroup: 'B+',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),
  Donor(
    id: 5,
    name: 'Tazul Islam',
    number: '01671969687',
    email: 'tazul09@gmail.com',
    area: 'Rajshahi',
    bgroup: 'AB+',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),
  Donor(
    id: 6,
    name: 'Sabina',
    number: '01754943828',
    email: 'sabina5675@gmail.com',
    area: 'Barishal',
    bgroup: 'O-',
    gender: 'Female',
    favorite: false,
    image: 'images/female.png',
  ),
  Donor(
    id: 7,
    name: 'Maria Misty',
    number: '01755198925',
    email: 'mariamisty88@gmail.com',
    area: 'Chattogram',
    bgroup: 'A-',
    gender: 'Female',
    favorite: false,
    image: 'images/female.png',
  ),
  Donor(
    id: 8,
    name: 'Kamrul Islam',
    number: '01834261425',
    email: 'tazul09@gmail.com',
    area: 'Sylhet',
    bgroup: 'B+',
    gender: 'Male',
    favorite: false,
    image: 'images/male.png',
  ),
  Donor(
    id: 9,
    name: 'Rasel Mahmud',
    number: '01310618325',
    email: 'rasel6845@gmail.com',
    area: 'Mymensingh',
    bgroup: 'O+',
    gender: 'Male',
    favorite: true,
    image: 'images/male.png',
  ),
  Donor(
    id: 10,
    name: 'Samima Nasrin',
    number: '01775936168',
    email: 'rasel6845@gmail.com',
    area: 'Dhaka',
    bgroup: 'B+',
    gender: 'Female',
    favorite: false,
    image: 'images/female.png',
  ),
   Donor(
     id: 11,
     name: 'Redwan Rafi',
     number: '017514568867',
     email: 'rafi65456@gmail.com',
     area: 'Rangpur',
     bgroup: 'A-',
     gender: 'Male',
     favorite: false,
     image: 'images/male.png',
   ),
   Donor(
     id: 12,
     name: 'Liza Rahman',
     number: '017514458865',
     email: 'rafi65456@gmail.com',
     area: 'Dhaka',
     bgroup: 'O+',
     gender: 'Female',
     favorite: true,
     image: 'images/female.png',
   ),


];



class Donor {
  int id;
  String name;
  String number;
  String email;
  String area;
  String bgroup;
  String gender;
  bool favorite;
  String image;

  Donor(
      {required this.id,
        required this.name,
        required this.number,
        required this.email,
        required this.area,
        required this.bgroup,
        required this.gender,
        this.favorite = false,
        required this.image});





}
