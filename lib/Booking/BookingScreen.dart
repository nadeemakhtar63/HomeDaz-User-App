
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';
import 'package:home_daz/Booking/Booking_details.dart';
import 'package:home_daz/Widgets/BottomDragable.dart';
import 'package:home_daz/constant.dart';

import '../AuthenticationScreens/LogIn.dart';
class Booking extends StatefulWidget {
  final image,servicename,shortDes,mainservicename,howitwork,reviwes,serviceCharges,serviceRequirDuration,extraTex;
  Booking({@required this.image,@required this.servicename,@required this.shortDes,@required this.reviwes,@required this.extraTex,
      @required this.mainservicename,@required this.howitwork,@required this.serviceCharges,@required this.serviceRequirDuration}); // const Booking({Key? key}) : super(key: key);
  @override
  State<Booking> createState() => _BookingState();
}
class _BookingState extends State<Booking> {
  List allResults=[];
  List _foundUsers=[];
  List allprovider=[];
  List _providershow=[];
  double providerreviews=0.0;
  List searchkeywords=[];
  double treviews=0.0;
  double reviws=0.0;
  double provider_reviws=0.0;
  int count=0;
  int providercount=0;

   getproviders()async{
    firebaseFirestore.collection('serviceprovider').where('serviceprovide',isEqualTo: widget.servicename).get().then((value)  {
      setState(() {
        allprovider=value.docs;
        _providershow = allprovider;
      });
      for(int i=0;i<_providershow.length;i++)
      {
        print('total revie ${_providershow[i]['rating']}');
        providerreviews=providerreviews+(_providershow[i]['rating']);
        providercount++;
      }
      provider_reviws=providerreviews/providercount;
      print('total revie $reviws');
    });
  }
  @override
  void initState() {
    // getuserpaststeamsnapshot();
    getproviders();
    // TODO: implement initState
    super.initState();
  }
  int i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title:Center(child: Text(widget.servicename,style: TextStyle(color: Colors.black38,fontSize: 20,fontWeight: FontWeight.w700),)),
          leading: IconButton(
            icon:Icon(Icons.arrow_back_ios_new,color: Colors.black38),
            onPressed: () {
              Navigator.pop(context);
            },
          )

      ),
      // appBar: AppBar(title: Center(child: Text(widget.servicename)),),
      floatingActionButton:auth.currentUser!.isAnonymous?
      FloatingActionButton.extended(
        elevation: 3,
        onPressed: ()
        {
          Get.to(LogIn());
          // showDialog(context: context, builder: (BuildContext context){
          //   return AlertDialog(
          //     backgroundColor: Colors.blueGrey,
          //     title: Image(image: AssetImage("assets/bookme.png"),height: 60,width: 250,),
          //     titleTextStyle:
          //     TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,fontSize: 20),
          //     actionsOverflowButtonSpacing: 20,
          //     actions: [
          //       ElevatedButton(onPressed: (){
          //       }, child: Text("Back")),
          //       ElevatedButton(onPressed: (){
          //       }, child: Text("Next")),
          //     ],
          //     content: ListView(
          //       children: [
          //
          //       ],
          //     ),
          //   );
          // });
          // Add your onPressed code here!
        },
        backgroundColor: Colors.amber,
        icon: Icon(Icons.login,color: Colors.red,),
        label: Text("LogIn",style: TextStyle(fontWeight: FontWeight.w900,),),
      ):
      FloatingActionButton.extended(
        elevation: 3,
        onPressed: ()
        {
          Get.to(Booking_Details(servicename: widget.servicename,seviceCharges: widget.serviceCharges,
              serviceDuration: widget.serviceRequirDuration,ServiceText: widget.extraTex,serviceImage: widget.image,));
          // showDialog(context: context, builder: (BuildContext context){
          //   return AlertDialog(
          //     backgroundColor: Colors.blueGrey,
          //     title: Image(image: AssetImage("assets/bookme.png"),height: 60,width: 250,),
          //     titleTextStyle:
          //     TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,fontSize: 20),
          //     actionsOverflowButtonSpacing: 20,
          //     actions: [
          //       ElevatedButton(onPressed: (){
          //       }, child: Text("Back")),
          //       ElevatedButton(onPressed: (){
          //       }, child: Text("Next")),
          //     ],
          //     content: ListView(
          //       children: [
          //
          //       ],
          //     ),
          //   );
          // });
          // Add your onPressed code here!
          // showModalBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return Wrap(
          //         children: const [
          //           ListTile(
          //             leading: Icon(Icons.share),
          //             title: Text('Share'),
          //           ),
          //           ListTile(
          //             leading: Icon(Icons.link),
          //             title: Text('Get link'),
          //           ),
          //           ListTile(
          //             leading: Icon(Icons.edit),
          //             title: Text('Edit name'),
          //           ),
          //           ListTile(
          //             leading: Icon(Icons.delete),
          //             title: Text('Delete collection'),
          //           ),
          //         ],
          //       );
          //     });
        },
          backgroundColor: Colors.amber,
        icon: Icon(Icons.shopping_cart,color: Colors.red,),
        label: Text("BOOK ME",style: TextStyle(fontWeight: FontWeight.w900,),),
      ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height*0.64,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                   Card(
                     shadowColor: Colors.black,
                     elevation: 3,
                     child: Container(
                       width: MediaQuery.of(context).size.width*0.9,
                       // height: 140,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text("Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                                 Divider(),
                                 Text(widget.howitwork)
                           ],
                         ),
                       ),
                     ),
                   ),
                    Card(
                      elevation: 3,
                      shadowColor: Colors.black,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Duration",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                                Text("This services can take upto",style: TextStyle(color: Color(0xffADADAD),fontSize: 11,fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Text(widget.serviceRequirDuration,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.amber) ,)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      shadowColor: Colors.black,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 120,
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(" Extra Charges",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                InkWell(
                                  onTap: (){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Colors.blueGrey,
                                        title: Row(
                                          children: [
                                            Text("HOMEDAZ+",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),),
                                            Text("MEMBER",style: TextStyle(color: Colors.white),)
                                          ],
                                        ),
                                        titleTextStyle:
                                        TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,fontSize: 20),
                                        actionsOverflowButtonSpacing: 20,
                                        actions: [
                                          ElevatedButton(onPressed: (){
                                          }, child: Text("Back")),
                                          ElevatedButton(onPressed: (){
                                          }, child: Text("Next")),
                                        ],
                                        content: Text("Saved successfully"),
                                      );
                                    });
                                  },
                                  child: Text("Details about Charges ",style:
                                  TextStyle(fontSize: 11,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.blue)),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(" Extra Tax",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                                Text("\$${widget.extraTex} ",style: TextStyle(fontSize: 14,color: Colors.amber,fontWeight: FontWeight.w900),)
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(" For each additional visit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                            //     Text("\$75 ",style: TextStyle(fontSize: 14,color: Colors.amber,fontWeight: FontWeight.w900),)
                            //   ],
                            // ),
                            Divider(),
                            Text("Only \$10/month, members get \$25 off every job, and more benefits!"
                            ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w900,color: Colors.blue),)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image:NetworkImage(widget.image,)
                  )
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height*0.20,
                left: 20,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow:[ BoxShadow(color: Colors.black12)],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                  ),
                  width: MediaQuery.of(context).size.width*0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.servicename,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating:widget.reviwes,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        Text("\$${widget.serviceCharges.toString()} ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.amber),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" Reviews($count)"),
                        Container(
                          width: 60,
                          height: 18,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(child: Text("Available",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),)),
                        )
                      ],
                    )
                  ],
                ),
              ),
                ),

            ),
         DraggableScrollableSheet(
        initialChildSize: .2,
        minChildSize: .1,
        maxChildSize: .6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5
                      )
                    ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )
                ),
                child:
                //  Column(
                //    children: [
                //      Padding(
                //        padding: const EdgeInsets.all(8.0),
                //        child: Container(
                //            width: double.infinity,
                //            child: Center(child: Text("Service Privder",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),))),
                //      ),
                // ]
                //  )
                ListView.builder(
                    itemCount:_providershow.length ,
                    controller: scrollController,
                    itemBuilder:(context,item) {
                      // print(_providershow[item]["image"]);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Container(
                                height: 90,
                                width: 90,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(_providershow[item]["image"]),
                                ),

                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_providershow[item]["name"]),
                                  Text(" Reviews($providercount)"),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating:_providershow[item]["rating"],
                                        itemBuilder: (context, index) => Icon(
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
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Center(child: Text("2 Services in Que",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),)),
                                      )
                                    ],

                                  ),
                                ],
                              ),
                              // SizedBox(width: 5,),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 5,bottom: 5),
                              //   child: Container(
                              //     width: 1,
                              //     color: Colors.black38,
                              //   ),
                              // ),
                              // SizedBox(width: 5,),
                              // Container(
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     children: [
                              //       Text("Recent Review:",style: TextStyle(fontSize:14,fontWeight: FontWeight.w900 ),),
                              //       // FittedBox(
                              //       //     fit: BoxFit.fitWidth,
                              //       //     child: Text(_providershow[item]["reviews"]
                              //       // ),
                              //       // )
                              //       Text(_providershow[item]["reviews"],)
                              //     ],
                              //   ),
                              // )
                            ],
                          ),

                        ),
                      );
                    }
                )
              //   ],
              // ),
            );
        },
      ),
          ],
        ),
    );
  }
  Widget bottomDetailsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: .2,
      minChildSize: .1,
      maxChildSize: .6,
      builder: (
          BuildContext context, ScrollController scrollController) {
        return
          Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.5
                )
              ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )
          ),
          child:
         //  Column(
         //    children: [
         //      Padding(
         //        padding: const EdgeInsets.all(8.0),
         //        child: Container(
         //            width: double.infinity,
         //            child: Center(child: Text("Service Privder",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),))),
         //      ),
         // ]
         //  )
              ListView.builder(
                itemCount:_providershow.length ,
                controller: scrollController,
                itemBuilder:(context,item) {
                  // print(_providershow[item]["image"]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              height: 90,
                              width: 90,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_providershow[item]["image"]),
                              ),

                            ),
                            SizedBox(width: 15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_providershow[item]["name"]),
                                Text(" Reviews($providercount)"),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating:_providershow[item]["rating"],
                                      itemBuilder: (context, index) => Icon(
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(child: Text("2 Services in Que",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),)),
                                    )
                                  ],

                                ),
                              ],
                            ),
                            // SizedBox(width: 5,),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 5,bottom: 5),
                            //   child: Container(
                            //     width: 1,
                            //     color: Colors.black38,
                            //   ),
                            // ),
                            // SizedBox(width: 5,),
                            // Container(
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     children: [
                            //       Text("Recent Review:",style: TextStyle(fontSize:14,fontWeight: FontWeight.w900 ),),
                            //       // FittedBox(
                            //       //     fit: BoxFit.fitWidth,
                            //       //     child: Text(_providershow[item]["reviews"]
                            //       // ),
                            //       // )
                            //       Text(_providershow[item]["reviews"],)
                            //     ],
                            //   ),
                            // )
                          ],
                        ),

                    ),
                  );
                }
              )
         //   ],
         // ),
       );
      },
    );
  }
}