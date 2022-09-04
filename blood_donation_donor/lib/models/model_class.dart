const String tableDonor = 'tbl_needer';
const String tableDonorColId = 'id';
const String tableDonorColName = 'name';
const String tableDonorColNumber = 'number';
const String tableDonorColEmail = 'email';
const String tableDonorColBGroup = 'bgroup';
const String tableDonorColArea = 'area';
const String tableDonorColLastDdate = 'lastddate';
const String tableDonorColPass = 'password';
const String tableDonorColConPAss = 'confirmpassword';
const String tableDonorColGender = 'gender';
const String tableDonorColImage = 'image';

class DonorModel {
  int? id;
  String name;
  String number;
  String? email;
  String bgroup;
  String area;
  String lastddate;
  String password;
  String confirmpassword;
  String gender;
  String? image;

  DonorModel({
    this.id,
    required this.name,
    required this.number,
    this.email,
    required this.bgroup,
    required this.area,
    required this.lastddate,
    required this.password,
    required this.confirmpassword,
    required this.gender,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableDonorColName: name,
      tableDonorColNumber: number,
      tableDonorColEmail: email,
      tableDonorColBGroup: bgroup,
      tableDonorColArea: area,
      tableDonorColLastDdate: lastddate,
      tableDonorColPass: password,
      tableDonorColConPAss: confirmpassword,
      tableDonorColGender: gender,
      tableDonorColImage: image,
    };
    if (id != null) {
      map[tableDonorColId] = id;
    }
    return map;
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) =>
      DonorModel(
        id: map[tableDonorColId],
        name: map[tableDonorColName],
        number: map[tableDonorColNumber],
        email: map[tableDonorColEmail],
        area: map[tableDonorColArea],
        bgroup: map[tableDonorColBGroup],
        gender: map[tableDonorColGender],
        lastddate: map[tableDonorColLastDdate],
        password: map[tableDonorColPass],
        confirmpassword: map[tableDonorColConPAss],
        image: map[tableDonorColImage],
      );


  @override
  String toString() {
    return 'DonorModel{id: $id, name: $name, number: $number, email: $email, bgroup: $bgroup, area: $area, lastDdate: $lastddate, password: $password, confirmpassword: $confirmpassword, gender: $gender, image: $image}';
  }


}

  final bgList = <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];


  final genderList = <String>['Male', 'Female', 'Others'];

  final areaList = <String>[
    'Dhaka',
    'Rangpur',
    'Khulna',
    'Chattogram',
    'Barishal',
    'Rajshahi',
    'Sylhet',
    'Mymensingh'
  ];


