import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CatogoryModel{
 late String DocumentId;
 late  String catgoryName;
 late String price;
 late String Description;
 late String Rews;
 late String Comment;
 late String Image;
 late String Duration;
 late String colorr;
  CatogoryModel({required this.DocumentId,required this.catgoryName,required this.price,required this.Description,
    required this.Rews,required this.Comment,required this.Image,required this.Duration,required this.colorr});

  CatogoryModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    DocumentId=documentSnapshot.id;
    catgoryName=documentSnapshot["servicename"];
    price=documentSnapshot["priceService"];
    Description=documentSnapshot['description'];
    Rews=documentSnapshot["rate"];
    Comment=documentSnapshot["reviews"];
    Image=documentSnapshot["image"];
    Duration=documentSnapshot["duration"];
    colorr=documentSnapshot["color"];
  }
}