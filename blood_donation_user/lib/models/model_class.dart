

const String tableNeeder = 'tbl_needer';
const String tableNeederColId = 'id';
const String tableNeederColName = 'name';
const String tableNeederColNumber = 'number';
const String tableNeederColEmail = 'email';
const String tableNeederColBGroup = 'bgroup';
const String tableNeederColArea = 'area';
const String tableNeederColPass = 'password';
const String tableNeederColConPAss = 'confirmpassword';
const String tableNeederColGender = 'gender';
const String tableNeederColImage = 'image';

class NeederModel {
  int? id;
  String name;
  String number;
  String? email;
  String bgroup;
  String area;
  String password;
  String confirmpassword;
  String gender;
  String? image;

  NeederModel({
    this.id,
    required this.name,
    required this.number,
    this.email,
    required this.bgroup,
    required this.area,
    required this.password,
    required this.confirmpassword,
    required this.gender,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableNeederColName: name,
      tableNeederColNumber: number,
      tableNeederColEmail: email,
      tableNeederColBGroup: bgroup,
      tableNeederColArea: area,
      tableNeederColPass: password,
      tableNeederColConPAss: confirmpassword,
      tableNeederColGender: gender,
      tableNeederColImage: image,
    };
    if (id != null) {
      map[tableNeederColId] = id;
    }
    return map;
  }

  factory NeederModel.fromMap(Map<String, dynamic> map) => NeederModel(
        id: map[tableNeederColId],
        name: map[tableNeederColName],
        number: map[tableNeederColNumber],
        email: map[tableNeederColEmail],
        area: map[tableNeederColArea],
        bgroup: map[tableNeederColBGroup],
        gender: map[tableNeederColGender],
        password: map[tableNeederColPass],
        confirmpassword: map[tableNeederColConPAss],
        image: map[tableNeederColImage],
      );

  @override
  String toString() {
    return 'NeederModel{id: $id, name: $name, number: $number, email: $email, bgroup: $bgroup, area: $area, password: $password, confirmpassword: $confirmpassword, gender: $gender, image: $image}';
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
