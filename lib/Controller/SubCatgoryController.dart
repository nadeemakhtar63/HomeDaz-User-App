
import 'package:get/get.dart';
import 'package:home_daz/ModelClass/ActiveOrderModel.dart';
import 'package:home_daz/ModelClass/CatagoryModel.dart';
import 'package:home_daz/ModelClass/SubCatogoryModel.dart';

import '../FirebaseCRUD/FirbaseDB.dart';
import '../ModelClass/CancelProjectModel.dart';
import '../ModelClass/CompletedProjectModel.dart';

class SubCatagoryController extends GetxController {
  Rx<List<Cancelprojectmodel>> cancellist = Rx<List<Cancelprojectmodel>>([]);
  Rx<List<AciveOrderModel>> activeorderList = Rx<List<AciveOrderModel>>([]);
  Rx<List<CompletedProjectModel>> CompletedList = Rx<List<CompletedProjectModel>>([]);

  Rx<List<SubCatgoryModel>> subCatagoryList = Rx<List<SubCatgoryModel>>([],);
  List<SubCatgoryModel> get subCatagory=> subCatagoryList.value;
  List<AciveOrderModel> get activeOrdergeter=>activeorderList.value;
  List<Cancelprojectmodel> get Cancel_geter=> cancellist.value;
  List<CompletedProjectModel> get Completedgetr=> CompletedList.value;
  @override
  void onReady() {

    CompletedList.bindStream(FirebaseDB.CompletedProjectData());

    cancellist.bindStream(FirebaseDB.CancelFun());

    activeorderList.bindStream(FirebaseDB.ActiveOrderFun());

    // CatagoryList.bindStream(FirebaseDB.CatagoryStream());

    subCatagoryList.bindStream(FirebaseDB.SubCatagoryStream());
  }
}