import 'dart:ui';
import 'package:path/path.dart' as Path;
import 'package:blood_donation_user/models/model_class.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _createTableNeeder = '''
  create table $tableNeeder(
  $tableNeederColId integer primary key,
  $tableNeederColName text,
  $tableNeederColNumber text,
  $tableNeederColEmail text,
  $tableNeederColArea text,
  $tableNeederColBGroup text,
  $tableNeederColGender text,
  $tableNeederColPass text,
  $tableNeederColConPAss text, 
  $tableNeederColImage text
  )
  ''';

  static Future<Database> open() async {
    final root = await getDatabasesPath();

    final dbPath = Path.join(root, 'needer.db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableNeeder);
    });
  }

  static Future<int> insertNeeder(NeederModel neederModel) async {
    final db = await open();
    return db.insert(tableNeeder, neederModel.toMap());
  }


  //Get all data
  static Future<List<NeederModel>> getAllNeeder() async {
    final db = await open();
    final mapList =
        await db.query(tableNeeder, orderBy: '$tableNeederColName asc');
    return List.generate(
        mapList.length, (index) => NeederModel.fromMap(mapList[index]));
  }

  //Needer login
  static Future<NeederModel> getLoginNeeder(String number, String password) async {
    final db = await open();
    final mapList = await db.query
      (tableNeeder,where: "$tableNeederColNumber = '$number' AND $tableNeederColPass = '$password'",);
    return NeederModel.fromMap(mapList.first);
  }

  //Needer login
  static Future<NeederModel> checkNeeder(String number) async {
    final db = await open();
    final mapList = await db.query
      (tableNeeder,where: "$tableNeederColNumber = '$number'",);
    return NeederModel.fromMap(mapList.first);
  }


  static Future<NeederModel> getNeederById(int id) async {
    final db = await open();
    final mapList = await db.query
      (tableNeeder,where: '$tableNeederColId = ?', whereArgs: [id]);
    return NeederModel.fromMap(mapList.first);
  }


  static Future<int> updateNeeder(NeederModel neederModel) async {
    final db = await open();
    return db.update(tableNeeder, neederModel.toMap(),
        where: '$tableNeederColId =  ?', whereArgs: [neederModel.id]);

  }
  static Future<int>updateInfo(int id,String name,String email,String bgroup,String area,String gender, String image)async{
    final db= await open();
    return db.update(tableNeeder,
        {tableNeederColName:name,
          tableNeederColEmail:email,
          tableNeederColBGroup:bgroup,
          tableNeederColArea:area,
          tableNeederColGender:gender,
          tableNeederColImage:image
        }, where: '$tableNeederColId = ?',whereArgs: [id]
    );
  }



}
