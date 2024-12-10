import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AciveOrderModel{
  late String DocumentId;
  late  String adminDescription;
  late String bookingid;
  late String dateofcompleting;
  late String serviceImage;
  late String serviceName;
  late String serviceid;
  late String technisionId;
  late String userId;

  AciveOrderModel(
  {
   required   this.DocumentId,
   required   this.adminDescription,
   required   this.bookingid,
   required   this.dateofcompleting,
   required   this.serviceImage,
   required   this.serviceName,
   required   this.serviceid,
   required   this.technisionId,
   required   this.userId
});
  AciveOrderModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
  {
    DocumentId=documentSnapshot.id;
    adminDescription=documentSnapshot["adminDescription"];
    bookingid=documentSnapshot["bookingid"];
    dateofcompleting=documentSnapshot['dateofcompleting'];
    serviceImage=documentSnapshot["serviceImage"];
    serviceName=documentSnapshot["serviceName"];
    serviceid=documentSnapshot["serviceid"];
    technisionId=documentSnapshot["technisionId"];
    userId=documentSnapshot['userId'];
  }
}