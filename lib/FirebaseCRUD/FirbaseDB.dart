import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_daz/Controller/SubCatgoryController.dart';
import 'package:home_daz/ModelClass/ActiveOrderModel.dart';
import 'package:home_daz/ModelClass/BookingInfo.dart';
import 'package:home_daz/ModelClass/CancelProjectModel.dart';
import 'package:home_daz/ModelClass/CompletedProjectModel.dart';
import 'package:home_daz/ModelClass/My_JobsPosted_ModuleClass.dart';
import 'package:home_daz/ModelClass/ProjectProgressModel.dart';
import 'package:home_daz/ModelClass/SubCatogoryModel.dart';
import 'package:home_daz/ModelClass/providerModelClass.dart';
import 'package:home_daz/TabScreens/Orders_Details.dart';
import 'package:home_daz/TabScreens/TabLayout.dart';
import 'package:home_daz/constant.dart';
import 'package:http/http.dart';

import '../ModelClass/CatagoryModel.dart';
import '../ModelClass/mesg_module.dart';

class FirebaseDB{
  // static addTodo(CatogoryModel catogoryModel) async {
  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('todos')
  //       .add({
  //     'servicename': catogoryModel.catgoryName,
  //     // 'createdon': Timestamp.now(),
  //     'priceService':catogoryModel.price,
  //     'description':catogoryModel.Description,
  //     'rate':catogoryModel.Rews,
  //
  //     'isDone': false,
  //   });
  // }
  static updatelasttextmesage(String mesg,uid,key)async
  {
    try {
      // var rng = new Random();
      // String randomName = "";
      // for (var i = 0; i < 20; i++) {
      //   print(rng.nextInt(100));
      //   randomName += rng.nextInt(100).toString();
      // }
      // final ref = FirebaseStorage.instance.ref(randomName);
      //
      // await ref.putFile(imageshare!);
      // String url = await ref.getDownloadURL();
      final response=  firebaseFirestore
          .collection('user')
          .doc(uid)
          .update(
          {
            if(key=="audio")
              'lastmesg': mesg
            else if(key=="img")
              'lastmesg': mesg
            else if(key=="videocall")
                'lastmesg': mesg
              else if(key=="pdf")
                  'lastmesg': mesg
                else
                  'lastmesg': mesg
          });
      final response2=  firebaseFirestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .update(
        {
          if(key=="audio")
            'lastmesg': mesg
          else if(key=="img")
            'lastmesg': mesg
          else if(key=="videocall")
              'lastmesg': mesg
            else if(key=="pdf")
                'lastmesg': mesg
              else
                'lastmesg': mesg
        },
      );
      return response;
    }
    catch(error)
    {
      print("error$error");
      return error;
    }


  }
  static addImageData(TodoModel c,File? imageshare,String uid) async {
    //save messaage on send account
    var rng = new Random();
    String randomName="";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    final ref = FirebaseStorage.instance.ref(randomName);

    await ref.putFile(imageshare!);
    String url = await ref.getDownloadURL();
    await firebaseFirestore.collection('Messages').
    doc(auth.currentUser!.uid).
    collection((auth.currentUser!.uid+uid))
        .add({
      'content': c.content,
      'createdon': Timestamp.now(),
      'isDone': false,
      'file':null,
      'msgstatus':"send",
      'imageshare':url,
      'audioMessage':null,
      'audiotime':null
    });
    //save message on reciver account
    await firebaseFirestore
        .collection('Messages')
        .doc(uid)
        .collection((uid+auth.currentUser!.uid))
        .add({
      'content':c.content,
      'createdon': Timestamp.now(),
      'isDone': false,
      'file':null,
      'msgstatus':"recive",
      'imageshare':url,
      'audioMessage':null,
      'audiotime':null
    });
  }
  static addTodo(TodoModel todomodel,String uid) async {

    //save messaage on send account
    await firebaseFirestore.collection('Messages').
    doc(auth.currentUser!.uid).
    collection((auth.currentUser!.uid+uid))
        .add({
      'content': todomodel.content,
      'createdon': Timestamp.now(),
      'isDone': false,
      'file':null,
      'msgstatus':"send",
      'imageshare':null,
      'audioMessage':null,
      'audiotime':null
    });
    //save message on reciver account
    await firebaseFirestore
        .collection('Messages')
        .doc(uid)
        .collection((uid+auth.currentUser!.uid))
        .add({
      'content': todomodel.content,
      'createdon': Timestamp.now(),
      'isDone': false,
      'file':null,
      'msgstatus':"recive",
      'imageshare':null,
      'audioMessage':null,
      'audiotime':null
    });
  }

  static Stream<List<CompletedProjectModel>> CompletedProjectData()
  {
    return firebaseFirestore
        .collection('CompletedProject')
        .where("userid",isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CompletedProjectModel> CompletedList= [];
      for (var todo in query.docs) {
        final Completedmodel = CompletedProjectModel.fromDocumentSnapshot(documentSnapshot: todo);
        CompletedList.add(Completedmodel);
      }
      return CompletedList;
    });
  }
  static Stream<List<Cancelprojectmodel>> CancelFun() {
    return firebaseFirestore
        .collection('CancelOrders')
        .where("userid",isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Cancelprojectmodel> canceList = [];
      for (var todo in query.docs) {
        final cancelmodel = Cancelprojectmodel.fromDocumentSnapshot(documentSnapshot: todo);
        canceList.add(cancelmodel);
      }
      return canceList;
    });
  }
  static Stream<List<ProviderModelClass>> TechnishonsData() {
    return firebaseFirestore
        .collection('serviceprovider')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProviderModelClass> tachnishions = [];
      for (var todo in query.docs) {
        final providermodel = ProviderModelClass.fromDocumentSnapshot(documentSnapshot: todo);
        tachnishions.add(providermodel);
      }
      return tachnishions;
    });
  }
  static Stream<List<CatogoryModel>> CatagoryStream() {
    return firebaseFirestore
        .collection('services')
        .snapshots()
        .map((QuerySnapshot query) {
        List<CatogoryModel> catagory = [];
       for (var todo in query.docs) {
         final catogorymodel = CatogoryModel.fromDocumentSnapshot(documentSnapshot: todo);
         catagory.add(catogorymodel);
        }
        return catagory;
     });
  }
  static Stream<List<ProjectProgressModel>> ProgressProjectStream() {
    return firebaseFirestore
        .collection('ServiceBook')
        .where("userId",isEqualTo: auth.currentUser!.uid)
        .where("aceptreject",isEqualTo: "Accepted")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProjectProgressModel> progressprojectsloist = [];
      for (var todo in query.docs) {
        final progressproject = ProjectProgressModel.fromDocumentSnapshot(documentSnapshot: todo);
        progressprojectsloist.add(progressproject);
      }
      return progressprojectsloist;
    });
  }

  static Stream<List<JobPostedModel>> BookingJobPostStream() {
    return firebaseFirestore
        .collection('post_job')
    // .where("technisionId",isEqualTo: auth.currentUser!.uid)
  //      .where("userId",isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<JobPostedModel> BookingList = [];
      for (var todo in query.docs) {
        final catogorymodel = JobPostedModel.fromDocumentSnapshot(documentSnapshot: todo);
        BookingList.add(catogorymodel);
      }
      return BookingList;
    });
  }
  static Stream<List<BookingInfo>> BookingStream() {
    return firebaseFirestore
        .collection('ServiceBook')
        .where("userId",isEqualTo: auth.currentUser!.uid)
        .where("aceptreject",isEqualTo: "pendding")
        .snapshots()
        .map((QuerySnapshot query) {
      List<BookingInfo> BookingList = [];
      for (var todo in query.docs) {
        final catogorymodel = BookingInfo.fromDocumentSnapshot(documentSnapshot: todo);
        BookingList.add(catogorymodel);
      }
      return BookingList;
    });
  }
  static Stream<List<AciveOrderModel>> ActiveOrderFun() {
    return firebaseFirestore
        .collection('ActiveOrder')
        .where("userId",isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AciveOrderModel> catagory = [];
      for (var todo in query.docs) {
        final catogorymodel = AciveOrderModel.fromDocumentSnapshot(documentSnapshot: todo);
        catagory.add(catogorymodel);
      }
      return catagory;
    });
  }

  static Stream<List<SubCatgoryModel>> SubCatagoryStream() {
    return firebaseFirestore.collection('subservices').snapshots().map((QuerySnapshot query) {
      List<SubCatgoryModel> catagory = [];
      for (var todo in query.docs) {
        final catogorymodel = SubCatgoryModel.fromDocumentSnapshot(documentSnapshot: todo);
        catagory.add(catogorymodel);
      }
      return catagory;
    });
  }
  static updateProfilepreviouseimage(imageshare,String usernaem,String statues)async {
    try {

      final response=  firebaseFirestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .update(
        {
          'statues': statues,
          'username': usernaem,
          'url': imageshare,
        },

      );
      return response;
    }
    catch(error)
    {
      print("error$error");
      return error;
    }

  }

  static updateProfile(imageshare,String usernaem,String statues)async {
    try {
      var rng = new Random();
      String randomName = "";
      for (var i = 0; i < 20; i++) {
        print(rng.nextInt(100));
        randomName += rng.nextInt(100).toString();
      }
      final ref = FirebaseStorage.instance.ref(randomName);

      await ref.putFile(imageshare!);
      String url = await ref.getDownloadURL();
      final response=  firebaseFirestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .update(
        {
          'statues': statues,
          'username': usernaem,
          'url': url,
        },
      );
      return response;
    }

    catch(error)
    {
      print("error$error");
      return error;
    }
  }
  Future <String> JobPost(
      {
        String? adres,
        String?  datepic,
        String?  morning,
        String? evening,
        String?  afternon,
        String? timing_about_des,
        String? which_service_want,
        String?  serviceName,
        int? servicesnum,
        List? images,
        int? scharges,
        int? stax,
        String? sduration,
        String? seviceimage

      }) async
  {
    String  response="";
    try {
      List imagesurl=[];
      for(int j=0;j<images!.length;j++) {
        try {
          var rng = new Random();
          String randomName = "";
          for (int i = 0; i < 20; i++) {
            print(rng.nextInt(100));
            randomName += rng.nextInt(100).toString();
          }
          final ref = FirebaseStorage.instance.ref(randomName);
          await ref.putFile(images[j]!);
          String url = await ref.getDownloadURL();
          imagesurl.add(url);

        }
        catch(firebaseAuthException)
        {
          Get.snackbar("Alert".tr, "$firebaseAuthException");
        }
      }

      if(imagesurl!=null) {
        await firebaseFirestore.collection("postjob").add({
          'userId': '${auth.currentUser!.uid}',
          'Address': adres,
          'Datepic': datepic == "" ? "as soon as posible" : datepic,
          'TimeFrame': '${morning} ${evening} ${afternon!}',
          'TimingDes': timing_about_des,
          'ServiceDetails': which_service_want,
          'SampleImages': imagesurl,
          'aceptreject':"pendding",
          'serviceName':serviceName,
          'serviceImage':seviceimage,
          "NumberOfServices":servicesnum
        }

        )
            .then((value) => {

          print('response return $value'),
          response="sucess",
          Get.snackbar("Booking Confirm","Successfully book this job "),
          // Get.to(()=>TabLayouts())
        }).catchError((error){
          response="error";
        });


        // if(res.contains("sucesss"))
        // return "sucesss";
      }
      else
      {
        Get.snackbar("Images issue","Images Not save");
      }
      print(images);
      // Get.snackbar("Booking Confirm","Successfully book this job ");

      // Get.to(()=>);
    }
    catch(firebaseAuthException)
    {
      Get.snackbar("Alert".tr, "$firebaseAuthException");
    }
    return response;
  }
  Future <String> Bookservice(
      {
        String? contractorId,
       String? adres,
        String?  datepic,
        String?  morning,
        String? evening,
        String?  afternon,
        String? timing_about_des,
        String? which_service_want,
        String?  serviceName,
         int? servicesnum,
       List? images,
       int? scharges,
       int? stax,
       String? sduration,
        String? seviceimage

      }) async
  {
 String  response="";
    try {
      List imagesurl=[];
      for(int j=0;j<images!.length;j++) {
        try {
          var rng = new Random();
          String randomName = "";
          for (int i = 0; i < 20; i++) {
            print(rng.nextInt(100));
            randomName += rng.nextInt(100).toString();
          }
          final ref = FirebaseStorage.instance.ref(randomName);
          await ref.putFile(images[j]!);
          String url = await ref.getDownloadURL();
          imagesurl.add(url);

        }
        catch(firebaseAuthException) 
        {
          Get.snackbar("Alert".tr, "$firebaseAuthException");
        }
      }

      if(imagesurl!=null) {
      await firebaseFirestore.collection("ServiceBook").add({
          'userId': '${auth.currentUser!.uid}',
          'Address': adres,
          'Datepic': datepic == "" ? "as soon as posible" : datepic,
          'TimeFrame': '${morning} ${evening} ${afternon!}',
          'TimingDes': timing_about_des,
          'ServiceDetails': which_service_want,
          'SampleImages': imagesurl,
          'aceptreject':"pendding",
          'serviceName':serviceName,
          'serviceImage':seviceimage,
        'contractor_assign':contractorId,
          "NumberOfServices":servicesnum
        }

        )
         .then((value) => {

          print('response return $value'),
       response="sucess",
          Get.snackbar("Booking Confirm","Successfully book this job "),
        // Get.to(()=>TabLayouts())
        }).catchError((error){
          response="error";
     });


     // if(res.contains("sucesss"))
     // return "sucesss";
      }
      else
        {
          Get.snackbar("Images issue","Images Not save");
        }
      print(images);
      // Get.snackbar("Booking Confirm","Successfully book this job ");

      // Get.to(()=>);
    }
    catch(firebaseAuthException)
    {
      Get.snackbar("Alert".tr, "$firebaseAuthException");
    }
    return response;
  }
}