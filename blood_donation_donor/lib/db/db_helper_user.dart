import 'dart:ui';
import 'package:blood_donation_donor/models/model_class.dart';
import 'package:path/path.dart' as Path;

import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _createTableDonor = '''
  create table $tableDonor(
  $tableDonorColId integer primary key,
  $tableDonorColName text,
  $tableDonorColNumber text,
  $tableDonorColEmail text,
  $tableDonorColArea text,
  $tableDonorColBGroup text,
  $tableDonorColGender text,
  $tableDonorColLastDdate text,
  $tableDonorColPass text,
  $tableDonorColConPAss text, 
  $tableDonorColImage text
  )
  ''';

  static Future<Database> open() async {
    final root = await getDatabasesPath();

    final dbPath = Path.join(root, 'needer.db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableDonor);
    });
  }

  static Future<int> insertDonor(DonorModel donorModel) async {
    final db = await open();
    return db.insert(tableDonor, donorModel.toMap());
  }


  //Get all data
  static Future<List<DonorModel>> getAllDonor() async {
    final db = await open();
    final mapList =
    await db.query(tableDonor, orderBy: '$tableDonorColName asc');
    return List.generate(
        mapList.length, (index) => DonorModel.fromMap(mapList[index]));
  }

  //Donor login
  static Future<DonorModel> getLoginDonor(String number, String password) async {
    final db = await open();
    final mapList = await db.query
      (tableDonor,where: "$tableDonorColNumber = '$number' AND $tableDonorColPass = '$password'",);
    return DonorModel.fromMap(mapList.first);
  }

  static Future<DonorModel> getDonorById(int id) async {
    final db = await open();
    final mapList = await db.query
      (tableDonor,where: '$tableDonorColId = ?', whereArgs: [id]);
    return DonorModel.fromMap(mapList.first);
  }

// updateFavorite(int id, bool favorite, int index) async {
//   final value = favorite ? 0 : 1;
//   final rowId = await DBHelper.updateFavorite(id, value);
//   if(rowId > 0) {
//     contactList[index].favourite = !contactList[index].favourite;
//     notifyListeners();
//   }
// }



}
