import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class JobPostedModel{
  late String DocumentId;
  late  String Address;
  late String ServiceDetails;
  late Timestamp TimeFrame;
  late String aceptreject;
  late String userId;
  late bool contractor;
  late String serviceName;
  late int bids;
  late String horlycharge;
  late bool horlypaycheck;
  late String serviceImage;
  late int views;

  JobPostedModel(
      this.DocumentId,
      this.Address,
      this.ServiceDetails,
      this.TimeFrame,
      this.aceptreject,
      this.userId,
      this.contractor,
      this.serviceName,
      this.bids,
      this.horlycharge,
      this.horlypaycheck,
      this.serviceImage,
      this.views);

  JobPostedModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
  {

    DocumentId=documentSnapshot.id;
    Address=documentSnapshot["Address"];
    ServiceDetails=documentSnapshot['ServiceDetails'];
    TimeFrame=documentSnapshot["TimingDes"];
    aceptreject=documentSnapshot['aceptreject'];
    bids=documentSnapshot['bids'];
    contractor=documentSnapshot['contractor'];
    horlycharge=documentSnapshot['horlycharge'];
    views=documentSnapshot['views'];
    horlypaycheck=documentSnapshot['horlypaycheck'];
    userId=documentSnapshot["userId"];
    serviceName=documentSnapshot['ServiceDetails'];
  }
}