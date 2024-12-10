import 'dart:io';

import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:home_daz/Booking/ConfirmBooking.dart';
import 'package:home_daz/ExpertScreens/ExpersScreens.dart';
import 'package:home_daz/GoogleMap/googleMap.dart';
import 'package:home_daz/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderStatues extends StatefulWidget {
  String DocumentId, adminDescription,bookingid,dateofcompleting,serviceImage,
  serviceName,serviceid,technisionId,userId;
  OrderStatues({Key? key,required this.DocumentId,required this.adminDescription,
    required this.bookingid,required this.dateofcompleting,required this.serviceImage
  ,required this.serviceName,required this.serviceid,required this.technisionId,
    required this.userId
  }) : super(key: key);

  @override
  State<OrderStatues> createState() => _Booking_DetailsState();
}

class _Booking_DetailsState extends State<OrderStatues> {
  // List _activeOrderData=[];
  // List allResults=[];
  List provderalldata=[];
  List providerList=[];
  getActiveOrderTableData()
  {
    // firebaseFirestore.collection("ActiveOrder").where("userId",isEqualTo: auth.currentUser!.uid)
    //     .get().then((value){
    //   value.docs.forEach((element) {
    //     String providerkey=element.data()["technisionId"];
    //     print("provider key is: $providerkey");
        firebaseFirestore.collection("serviceprovider").where("serviceProviderId",isEqualTo:widget.technisionId).get().then((values) {
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
  bool _fromTop = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(widget.serviceName),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Container(
        height: MediaQuery.of(context).size.height*0.80,
          child:
                  Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: NetworkImage(widget.serviceImage)
                            )
                        ),
                      ),
                      Card(
                shadowColor: Colors.black,
                elevation: 3,
                child: Container(
                      width: MediaQuery.of(context).size.width*0.9,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 children: [
                                   Align(
                                       alignment: Alignment.centerLeft,
                                       child: Text("Admin Description",
                                         style: TextStyle(fontSize: 16,
                                             fontWeight: FontWeight.w700),)),
                                   Divider(),
                                   Text(widget.adminDescription)
                                 ],
                               ),
                             ),
                           ),
                         ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Your  Project don According to Following Date Time",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w700)),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 60,
                            child: Center(child: Text(widget.dateofcompleting),),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("  Assiging Technishan ",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w700)),
                          )),
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
                                                  SizedBox(width: 20,),
                                                  InkWell(
                                                    onTap: ()
                                                    {
                                                    Get.to(()=> ExpertsSCreen(
                                                      phoneno: providerList[items]['phoneno'],
                                                        image: providerList[items]['image'],
                                                        name: providerList[items]['name'],
                                                        rating: providerList[items]['rating'],
                                                        reviews: providerList[items]['reviews'],
                                                        seviceprovide: providerList[items]['serviceprovide'],
                                                      ));
                                                    },
                                                    child: Card(
                                                      elevation: 5,
                                                      color: Colors.orange,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
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
                                                          child: Center(child: Text("Check Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),))),
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
                  )


            ),

              Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      _displayCancelprojectDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.40,

                      decoration: BoxDecoration(
                          color: Colors.red,
                        borderRadius: BorderRadius.circular(20 )
                      ),
                      child: Center(child: Text("Canncel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.white),),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _displayDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20 )
                          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20))
                      ),
                      child: Center(child: Text("Completed",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.white),),),
                    ),
                  ),
                )
              ],
            ),
              ),
            // Container(
            //   height: MediaQuery.of(context).size.height*0.25,
            //   decoration: BoxDecoration(
            //       // image: DecorationImage(
            //       //   // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            //       //     fit: BoxFit.cover,
            //       //     image:NetworkImage(_activeOrderData[0]['serviceImage'],)
            //       // )
            //   ),
            // ),
            // Positioned(
            //   top: 160,
            //   left: 20,
            //   child: Card(
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //     child: Container(
            //       height: 60,
            //       decoration: BoxDecoration(
            //           // boxShadow:[ BoxShadow(color: Colors.black12)],
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.white
            //       ),
            //       width: MediaQuery.of(context).size.width*0.9,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             // Text(_activeOrderData[0]['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
            //             Card(
            //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //               elevation: 5,
            //               child: Container(
            //                 width: 80,
            //                 height: 18,
            //                 decoration: BoxDecoration(
            //                   border: Border.all(
            //                     color: Colors.blue,
            //                   ),
            //                   borderRadius: BorderRadius.circular(15),
            //                 ),
            //                 child: Center(child: Text("InProgress",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            //
            // ),
          ],
        ),
      ),
    );
  }
  TextEditingController _textFieldController = TextEditingController();
    double comuni=0,expirence=0,recomded=0;
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reviews To Technishion',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Communication With Seller',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 25,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      comuni=rating;
                      print(rating);
                    },
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Service as Described',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 25,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      expirence=rating;
                      print(rating);
                    },
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Buy Again or Recommend',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 25,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      recomded=rating;
                      print(rating);
                    },
                  ),
                  TextField(
                    controller: _textFieldController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 8,
                    decoration:InputDecoration(
                     // errorText: whyneedvalidate?"please describe what service you gain":null,
                      hintText: 'e.g. communication,expirence,time uses',
                      // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new MaterialButton(
                color: Colors.blueAccent,
                child: new Text('SUBMIT',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                onPressed: () async{
               try {
                 await firebaseFirestore.collection("reviews").add({
                   'communication_review': comuni,
                   'Experties': expirence,
                   'recommended': recomded,
                   "reviews": _textFieldController.text,
                   "userid": auth.currentUser!.uid,
                   'providerId': widget.technisionId,
                   'subcatagoryid': widget.serviceName,
                   'reviewtime': DateTime.now(),
                   "rating": ((comuni + expirence + recomded) / 3),

                 });

                 await firebaseFirestore.collection("CompletedProject").add({
                   'bookingid': widget.bookingid,
                   'serviceImage': widget.serviceImage,
                   'recommended': recomded,
                   "reviews": _textFieldController.text,
                   "userid": auth.currentUser!.uid,
                   'providerId': widget.technisionId,
                   'subcatagoryid': widget.serviceName,
                   'reviewtime': DateTime.now(),

                 });
                 Get.snackbar("Submit", "Thanks for Your Feedback");
                 Navigator.of(context).pop();
               }
               catch(firebaseAuthException)
               {
                 Get.snackbar("Alert".tr, "$firebaseAuthException");
               }

                },
              )
            ],
          );
        });
  }
  _displayCancelprojectDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Why you Cancel this order ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
            content: SingleChildScrollView(
              child: Column(
                children: [

                  TextField(
                    controller: _textFieldController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 8,
                    decoration:InputDecoration(
                      // errorText: whyneedvalidate?"please describe what service you gain":null,
                      hintText: 'e.g. please provide details so we can cover these issues',
                      // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new MaterialButton(
                color: Colors.blueAccent,
                child: new Text('SUBMIT',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                onPressed: () async{
                  try
                  {
                    await firebaseFirestore.collection("CancelOrders").add({
                      "reviews": _textFieldController.text,
                      "userid": auth.currentUser!.uid,
                      'providerId': widget.technisionId,
                      'subcatagoryid': widget.serviceName,
                      'reviewtime': DateTime.now(),
                    });
                    Get.snackbar("Submit", "Thanks for Your Feedback");
                    _textFieldController.clear();
                    Navigator.of(context).pop();
                  }
                  catch(firebaseAuthException)
                  {
                    Get.snackbar("Alert".tr, "$firebaseAuthException");
                  }

                },
              )
            ],
          );
        });
  }
}
class BottomDialog {
  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin:  Offset(0, 1),
            end:  Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent(context) {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Material(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildImage(),
              const SizedBox(height: 8),
              _buildContinueText(),
              const SizedBox(height: 16),
              _buildEmapleText(),
              const SizedBox(height: 16),
              _buildTextField(),
              const SizedBox(height: 16),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    const image =
        'https://user-images.githubusercontent.com/47568606/134579553-da578a80-b842-4ab9-ab0b-41f945fbc2a7.png';
    return SizedBox(
      height: 88,
      child: Image.network(image, fit: BoxFit.cover),
    );
  }

  Widget _buildContinueText() {
    return const Text(
      'Give Reviews to Technishion',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildEmapleText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Communication With Seller',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
       RatingBar.builder(
       initialRating: 3,
       minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
       itemSize: 20,
       itemCount: 5,
       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
       itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        ),
       onRatingUpdate: (rating) {
       print(rating);
       },
       ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Service as Described',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemSize: 20,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Buy Again or Recommend',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemSize: 20,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ],
        ),
      ],
    );
  }
TextEditingController whatneedInputController=new TextEditingController();
  Widget _buildTextField() {
    const iconSize = 40.0;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          // Container(
          //   width: iconSize,
          //   height: iconSize,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.grey[200],
          //   ),
          //   child: const Center(
          //     child: Text('Е'),
          //   ),
          // ),
          const SizedBox(height: 16),
          // TextField(
          //   controller: whatneedInputController,
          //   keyboardType: TextInputType.multiline,
          //   textInputAction: TextInputAction.newline,
          //   minLines: 1,
          //   maxLines: 4,
          //   decoration:InputDecoration(
          //    // errorText: whyneedvalidate?"please describe what service you gain":null,
          //     hintText: 'e.g. something that needs to be fixed ,install,clean',
          //     // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
          //     hintStyle: TextStyle(color: Colors.blue),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(context) {
    return Container(
      height: 40,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Color(0xFF3375e0),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}