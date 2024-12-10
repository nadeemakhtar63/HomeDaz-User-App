import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../TabScreens/TabScreens/ChatScreen.dart';
class ExpertsSCreen extends StatefulWidget {
  final image,name,rating,reviews,seviceprovide,phoneno;
  const ExpertsSCreen({Key? key,required this.phoneno,required this.name,required this.rating,required this.image
  ,required this.reviews,required this.seviceprovide
  }) : super(key: key);

  @override
  State<ExpertsSCreen> createState() => _ExpertsSCreenState();
}

class _ExpertsSCreenState extends State<ExpertsSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.name) ,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.image),fit: BoxFit.cover)
            ),
          ),
          Positioned(
            top: 160,
            left: 10,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  boxShadow:[ BoxShadow(color: Colors.black12)],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              width: MediaQuery.of(context).size.width*0.95,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.seviceprovide,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                        Container(
                          // width: 60,
                          // height: 18,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(child: Text("Available",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),)),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating:widget.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(" Reviews(${widget.rating})"))
                        // Text("\$${widget.serviceCharges.toString()} ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.amber),)
                      ],
                    ),

                  ],
                ),
              ),
            ),

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.58,
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width*0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contact us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                                Text("if Your have any question!")
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color:Colors.orange.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child:Icon(Icons.phone_android,color: Color(0xffFF7D00),) ,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    launch('tel://${widget.phoneno}');
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color:Colors.orange.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child:Icon(Icons.call,color: Color(0xffFF7D00),) ,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(()=>ChatScreen(uname: widget.name, statues: "", url:widget.image, uid: widget.phoneno));

                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color:Colors.orange.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child:Icon(Icons.mail_rounded,color: Color(0xffFF7D00),) ,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                  Card(
                    // shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      // height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("About MySelf",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),)),
                            Divider(),
                            Text(widget.reviews)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    // shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      // height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Align(
                                alignment: Alignment.center,
                                child: Text("Rating",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                            SizedBox(height: 20,),
                            Text(widget.reviews)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
