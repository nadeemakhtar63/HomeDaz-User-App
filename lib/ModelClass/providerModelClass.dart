import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class ProviderModelClass{
  late String DocumentId;
  late  String serviceprovide;
  // late  String serviceproviderId;
  late String reviews;
  late String identity;
  late String address;
  late String email;
  late String jobType;
  late String name;
  late String statues;
  late String phoneno;
  late double rating;
  late String Image;
  late String sname;
  late String fruntendImagcard;
  late String backendImagecard;
  ProviderModelClass({required this.sname,required this.fruntendImagcard,required this.backendImagecard ,required this.phoneno,required this.statues,required this.address,required this.identity,required this.email,required this.jobType,required this.DocumentId,required this.Image,required this.name,required this.serviceprovide,required this.reviews,required this.rating});
  ProviderModelClass.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    DocumentId=documentSnapshot.id;
    serviceprovide=documentSnapshot["serviceprovide"];
    // serviceproviderId=documentSnapshot["serviceproviderId"];
    sname=documentSnapshot["username"];
    reviews=documentSnapshot["reviews"];
    phoneno=documentSnapshot["phoneno"];
    fruntendImagcard=documentSnapshot["idBackside"];
    backendImagecard=documentSnapshot["idfruntside"];
    name=documentSnapshot['name'];
    statues=documentSnapshot['statues'];
    rating=documentSnapshot["rating"];
    Image=documentSnapshot["image"];
    email=documentSnapshot['email'];
    jobType=documentSnapshot["jobType"];
    address=documentSnapshot['Adress'];
    identity=documentSnapshot["nationalId"];
  }
}