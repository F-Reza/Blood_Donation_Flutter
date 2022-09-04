import 'package:blood_donation_user/models/model_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:blood_donation_user/db/db_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../db/temp_db.dart';

class NeedProvider extends ChangeNotifier {
  List<NeederModel> neederList = [];

  getAllNeeder() async {
    neederList = await DBHelper.getAllNeeder();
    notifyListeners();
  }

  Future<NeederModel> getNeederById(int id) => DBHelper.getNeederById(id);

  Future<bool> insertNeeder(NeederModel neederModel) async {
    final rowId = await DBHelper.insertNeeder(neederModel);
    if (rowId > 0) {
      neederModel.id = rowId;
      neederList.add(neederModel);
      neederList.sort((c1, c2) => c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }


  Future<bool>updateInfo(int id,String name,String email,String bgroup, String area, String gender, String image)async{
    final rowId= await DBHelper.updateInfo(id, name, email, bgroup, area, gender,image);
    if(rowId>0){
      notifyListeners();
      return true;
    }
    return false;
  }



}