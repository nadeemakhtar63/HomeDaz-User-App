import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProjectProgressModel{
  late String DocumentId;
  late  String Address;
  late String Datepic;
  late String ServiceDetails;
  late String TimeFrame;
  late String TimingDes;
  late String userId;
  late String statues;
  late String serviceName;
  late String serviceImage;
  ProjectProgressModel({ required this.DocumentId,required this.Address,required this.Datepic,required
  this.ServiceDetails,required this.TimeFrame,required this.TimingDes,
    required this.userId,required this.serviceImage,required this.serviceName,required this.statues
  });
  ProjectProgressModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
  {
    DocumentId=documentSnapshot.id;
    Address=documentSnapshot["Address"];
    Datepic=documentSnapshot["Datepic"];
    ServiceDetails=documentSnapshot['ServiceDetails'];
    TimeFrame=documentSnapshot["TimeFrame"];
    TimingDes=documentSnapshot["TimingDes"];
    userId=documentSnapshot["userId"];
    serviceImage=documentSnapshot["serviceImage"];
    serviceName=documentSnapshot['serviceName'];
    statues=documentSnapshot['aceptreject'];
  }
}