import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Cancelprojectmodel{
  late String DocumentId;
  late  String providerId;
  late String reviews;
  late Timestamp reviewtime;
  late String subcatagoryid;
  late String userid;
  // late String userId;
  // late String statues;
  // late String serviceName;
  // late String serviceImage;
  Cancelprojectmodel({ required this.DocumentId,required this.providerId,required this.reviews,required
  this.reviewtime,required this.subcatagoryid,required this.userid});
  Cancelprojectmodel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
  {
    DocumentId=documentSnapshot.id;
    providerId=documentSnapshot["providerId"];
    reviews=documentSnapshot["reviews"];
    subcatagoryid=documentSnapshot["subcatagoryid"];
    reviewtime=documentSnapshot['reviewtime'];
    userid=documentSnapshot["userid"];
  }
}