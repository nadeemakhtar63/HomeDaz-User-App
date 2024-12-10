import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SubCatgoryModel{
  late String DocumentId;
  late String Howitworks;
  late String mainservice;
  late String name;
  late String repiringTimeRequired;
  late double reviews;
  late int  service_charges;
  late String shortDes;
  late int tax;
  late String Image;

  SubCatgoryModel({
    required this.DocumentId,
    required this.Howitworks,
    required this.mainservice,
    required this.name,
    required this.repiringTimeRequired,
    required this.reviews,
    required this.service_charges,
    required this.shortDes,
    required this.tax,
    required this.Image
  });

  SubCatgoryModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    DocumentId=documentSnapshot.id;
    Howitworks=documentSnapshot["Howitworks"];
    mainservice=documentSnapshot["mainservice"];
    name=documentSnapshot['name'];
    repiringTimeRequired=documentSnapshot['repair_time_requir'];
    reviews=documentSnapshot['reviews'];
    service_charges=documentSnapshot['service_charges'];
    shortDes=documentSnapshot["shortDes"];
    tax=documentSnapshot['tax'];
    Image=documentSnapshot["image"];
  }
}