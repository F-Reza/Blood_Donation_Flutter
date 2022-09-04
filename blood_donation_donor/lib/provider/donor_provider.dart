import 'package:flutter/cupertino.dart';

import '../db/db_helper_user.dart';
import '../models/model_class.dart';

class DonorProvider extends ChangeNotifier {
  List<DonorModel> donorList = [];

  getAllDonor() async {
    donorList = await DBHelper.getAllDonor();
    notifyListeners();
  }

  Future<DonorModel> getDonorById(int id) => DBHelper.getDonorById(id);

  Future<bool> insertDonor(DonorModel donorModel) async {
    final rowId = await DBHelper.insertDonor(donorModel);
    if(rowId > 0) {
      donorModel.id = rowId;
      donorList.add(donorModel);
      donorList.sort((c1, c2) => c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }

}