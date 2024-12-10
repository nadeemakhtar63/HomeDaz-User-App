import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedProjectModel{
 late String DocumentId;
 late String  bookingid;
 late String providerId;
 late double recommended;
 late String reviews;
 late Timestamp reviewtime;
 late String serviceImage;
 late String subcatagoryid;
 late String userid;
CompletedProjectModel({required this.bookingid, required this.providerId, required  this.recommended,
 required  this.reviews, required  this.reviewtime, required  this.serviceImage, required  this.subcatagoryid,
 required  this.userid, required this.DocumentId
});
CompletedProjectModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
{
 DocumentId=documentSnapshot.id;
 providerId=documentSnapshot["providerId"];
 recommended=documentSnapshot["recommended"];
 reviews=documentSnapshot['reviews'];
 reviewtime=documentSnapshot["reviewtime"];
 serviceImage=documentSnapshot["serviceImage"];
 subcatagoryid=documentSnapshot["subcatagoryid"];
 serviceImage=documentSnapshot["serviceImage"];
 bookingid=documentSnapshot['bookingid'];
 userid=documentSnapshot['userid'];
}
}