import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/Order_Progress/OrderProgreeComplere.dart';
import 'package:home_daz/constant.dart';

import '../AuthenticationScreens/LogIn.dart';

class OrderDetails extends StatefulWidget {
  // const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List albums=[
    "assets/homefirstimage.png",
    "assets/homefirstimage.png"
  ];


  int _current = 0;
  TextEditingController searchController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            auth.currentUser!.isAnonymous?
            InkWell(
              onTap: (){
                Get.to(()=>LogIn());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child:Container(
                  width: 160,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.withOpacity(0.5)
                  ),
                  child: Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),),
                ) ,
                ),
              ),
            ):

            Container(
              height: MediaQuery.of(context).size.height*0.95,
              width: double.infinity,
              child: GetX<CatagoryController>(
                  init: Get.put<CatagoryController>(CatagoryController()),
                  builder: (CatagoryController todoController) {
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                        itemCount: todoController.Booking_geter.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(todoController.Booking_geter[index].Datepic);
                          final _todoModel = todoController.Booking_geter[index];
                          return InkWell(
                            onTap: (){
                              //  Get.to(SubServices(idkey: _todoModel.DocumentId,));
                            },
                            child: Card(
                                elevation: 5,
                                child: Container(
                                    height: MediaQuery.of(context).size.width*0.50,
                                    width: MediaQuery.of(context).size.width*0.60,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Container(
                                                height:MediaQuery.of(context).size.width*0.30,
                                                width: MediaQuery.of(context).size.width*0.25,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(_todoModel.serviceImage),
                                                        fit: BoxFit.cover
                                                    ),
                                                    //color: Color(int.parse(_todoModel.colorr)),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Flexible(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.phone_android,color: Color(0xffFF7D00),),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.call,color: Color(0xffFF7D00),),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.mail_rounded,color: Color(0xffFF7D00),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Image.network(_todoModel.Datepic,height: 100,width: 100,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("Service Book:",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text(_todoModel.serviceName,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("Selected Date",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text(_todoModel.Datepic,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),

                                              ],
                                            ),
                                            _todoModel.TimeFrame==""?Text(""):
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  // width: MediaQuery.of(context).size.width*.20,
                                                  // decoration: BoxDecoration(
                                                  //   border: Border.all(width: 1,color: Colors.orange),
                                                  //   borderRadius: BorderRadius.circular(10),
                                                  //
                                                  // ),
                                                  child: Center(child: Text(_todoModel.TimeFrame,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,)),),
                                                ),

                                              ],
                                            ),
                                            _todoModel.statues=="pendding"?  Row(
                                              children: [
                                                Text("Statues",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text(_todoModel.statues,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue),),
                                                SizedBox(width: 20,),
                                                // Card(
                                                //   elevation: 5,
                                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                //   child: Container(
                                                //     height: 30,
                                                //     width: 90,
                                                //     decoration: BoxDecoration(
                                                //         color: Colors.blueAccent,
                                                //         // image: DecorationImage(
                                                //         //     image: NetworkImage(_todoModel.serviceImage),
                                                //         //     fit: BoxFit.cover
                                                //         // ),
                                                //         //color: Color(int.parse(_todoModel.colorr)),
                                                //         borderRadius: BorderRadius.circular(10)
                                                //     ),
                                                //     child: Center(
                                                //       child: Text("Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ):Container()
                                            // _todoModel.statues=="rejected"?Row(
                                            //   children: [
                                            //     Text("Statues",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                            //     SizedBox(width: 20,),
                                            //     Text(_todoModel.statues,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue),),
                                            //     SizedBox(width: 20,),
                                            //     Card(
                                            //       elevation: 5,
                                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            //       child: Container(
                                            //         height: 30,
                                            //         width: 90,
                                            //         decoration: BoxDecoration(
                                            //             color: Colors.blueAccent,
                                            //             // image: DecorationImage(
                                            //             //     image: NetworkImage(_todoModel.serviceImage),
                                            //             //     fit: BoxFit.cover
                                            //             // ),
                                            //             //color: Color(int.parse(_todoModel.colorr)),
                                            //             borderRadius: BorderRadius.circular(10)
                                            //         ),
                                            //         child: Center(
                                            //           child: Text("Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                                            //         ),
                                            //       ),
                                            //     )
                                            //   ],
                                            // ):
                                            // Row(
                                            //   children: [
                                            //     Text("Statues",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                            //     SizedBox(width: 20,),
                                            //     Text(_todoModel.statues,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue),),
                                            //     SizedBox(width: 20,),
                                            //     Card(
                                            //       elevation: 5,
                                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            //       child: InkWell(
                                            //         onTap: ()
                                            //         {
                                            //           Get.to(
                                            //               OrderStatues(
                                            //                   // servicename: _todoModel.serviceName,
                                            //                   // seviceCharges: _todoModel.statues,
                                            //                   // serviceDuration:_todoModel.TimeFrame,
                                            //                   // ServiceText: _todoModel.serviceName,
                                            //                   // serviceImage: _todoModel.serviceImage
                                            //               )
                                            //           );
                                            //         },
                                            //         child: Container(
                                            //           height: 30,
                                            //           width: 90,
                                            //           decoration: BoxDecoration(
                                            //               color: Colors.blueAccent,
                                            //               // image: DecorationImage(
                                            //               //     image: NetworkImage(_todoModel.serviceImage),
                                            //               //     fit: BoxFit.cover
                                            //               // ),
                                            //               //color: Color(int.parse(_todoModel.colorr)),
                                            //               borderRadius: BorderRadius.circular(10)
                                            //           ),
                                            //           child: Center(
                                            //             child: Text("Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                          ],

                                        ),

                                      ],
                                    )
                                )
                            ),
                          );
                        }
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
