
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:home_daz/ModelClass/BookingInfo.dart';
import 'package:home_daz/ModelClass/CancelProjectModel.dart';
import 'package:home_daz/ModelClass/CatagoryModel.dart';
import 'package:home_daz/ModelClass/CompletedProjectModel.dart';
import 'package:home_daz/ModelClass/My_JobsPosted_ModuleClass.dart';
import 'package:home_daz/ModelClass/ProjectProgressModel.dart';
import 'package:home_daz/ModelClass/SubCatogoryModel.dart';
import 'package:home_daz/ModelClass/providerModelClass.dart';
import '../FirebaseCRUD/FirbaseDB.dart';
class CatagoryController extends GetxController {
  Rx<List<CatogoryModel>> CatagoryList = Rx<List<CatogoryModel>>([]);
  Rx<List<BookingInfo>> BookingList = Rx<List<BookingInfo>>([]);
  Rx<List<JobPostedModel>> BookingJobPostList = Rx<List<JobPostedModel>>([]);
  Rx<List<ProjectProgressModel>> progressprojestsList = Rx<List<ProjectProgressModel>>([]);
  Rx<List<ProviderModelClass>> ProviderList = Rx<List<ProviderModelClass>>([]);
  List<JobPostedModel> get  Booking_JobPost_geter=> BookingJobPostList.value;
  List<BookingInfo> get Booking_geter=> BookingList.value;
  List<CatogoryModel> get Catagory=> CatagoryList.value;
  List<ProjectProgressModel> get progerprojectgetr=> progressprojestsList.value;
  List<ProviderModelClass> get TechnishionList=> ProviderList.value;
  @override
  void onReady() {
    BookingJobPostList.bindStream(FirebaseDB.BookingJobPostStream());
    BookingList.bindStream(FirebaseDB.BookingStream());
    progressprojestsList.bindStream(FirebaseDB.ProgressProjectStream());
    CatagoryList.bindStream(FirebaseDB.CatagoryStream());
    ProviderList.bindStream(FirebaseDB.TechnishonsData());
    // subCatagoryList.bindStream(FirebaseDB.SubCatagoryStream());
  }
}