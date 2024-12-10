import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:home_daz/constant.dart';

import '../ExpertScreens/ExpersScreens.dart';

class CompletedProjectDetails extends StatefulWidget {
  late String DocumentId;
  late String  bookingid;
  late String providerId;
  late double recommended;
  late String reviews;
  late String reviewtime;
  late String serviceImage;
  late String subcatagoryid;
  late String userid;
  CompletedProjectDetails({Key? key,required this.DocumentId,required this.bookingid,required this.providerId
    , required this.recommended,required this.reviews, required this.reviewtime,required this.serviceImage,
    required this.subcatagoryid,
  required this.userid
    ,}) : super(key: key);

  @override
  State<CompletedProjectDetails> createState() => _CompletedProjectDetailsState();
}

class _CompletedProjectDetailsState extends State<CompletedProjectDetails> {
  List provderalldata=[];
  List providerList=[];
  getActiveOrderTableData()
  {
    // firebaseFirestore.collection("ActiveOrder").where("userId",isEqualTo: auth.currentUser!.uid)
    //     .get().then((value){
    //   value.docs.forEach((element) {
    //     String providerkey=element.data()["technisionId"];
    //     print("provider key is: $providerkey");
        firebaseFirestore.collection("serviceprovider").where("serviceProviderId",isEqualTo:widget.providerId)
        .get().then((values) {
          setState(() {
            provderalldata=values.docs;
            providerList=provderalldata;
          });
          // print("provider List is: ${providerList[0]['image']}");
        });
    //   });
    //   setState(() {
    //     allResults=value.docs;
    //     _activeOrderData = allResults;
    //   });
    // }) ;
  }
  initState()
  {
    getActiveOrderTableData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.subcatagoryid,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
      ),
      body: Container(
        child: Column(
          children: [

            Container(
              height: MediaQuery.of(context).size.height*0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.dstIn),
                  image: NetworkImage(widget.serviceImage),
                  fit: BoxFit.cover
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.subcatagoryid,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                child: Container(
                  padding: EdgeInsets.all(10),
                height: 80,
                  width: MediaQuery.of(context).size.height*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Completed",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      Text(widget.reviewtime.toString())
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.height*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Reason for Cancled",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                      SizedBox(height: 20,),
                      Text(widget.reviews)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: providerList.length,
                  itemBuilder: (context,items) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),

                        child: InkWell(
                          // onTap: (){
                          //   Get.to(()=> ExpertsSCreen(
                          //     image: _todoModel.Image,
                          //     name: _todoModel.name,
                          //     rating: _todoModel.rating,
                          //     reviews: _todoModel.reviews,
                          //     seviceprovide: _todoModel.serviceprovide,
                          //   ));
                          // },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        providerList[items]['image']),
                                  ),

                                ),
                                SizedBox(width: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(providerList[items]['name']),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(" Reviews(${providerList.length})"),
                                        SizedBox(width: 10,),
                                        InkWell(
                                          onTap: ()
                                          {
                                            Get.to(()=> ExpertsSCreen(
                                              phoneno:providerList[items]['phoneno'] ,
                                              image: providerList[items]['image'],
                                              name: providerList[items]['name'],
                                              rating: providerList[items]['rating'],
                                              reviews: providerList[items]['reviews'],
                                              seviceprovide: providerList[items]['serviceprovide'],
                                            ));
                                          },
                                          child: Card(
                                            elevation: 5,
                                            color: Colors.orange.withOpacity(0.3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                                width: 100,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  // border: Border.all(
                                                  //   color: Colors.blue,
                                                  // ),
                                                ),
                                                child: Center(child: Text("Check Profile"))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: providerList[items]['rating'],
                                          itemBuilder: (context, index) =>
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 100,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                          child: Center(child: Text(
                                            "2 Services in Que", style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),)),
                                        )
                                      ],

                                    ),
                                  ],
                                ),

                              ],
                            ),

                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
