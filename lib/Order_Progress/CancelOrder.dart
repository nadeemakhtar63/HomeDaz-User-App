import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/Controller/SubCatgoryController.dart';

import 'OrderProgreeComplere.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({Key? key}) : super(key: key);

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.95,
              width: double.infinity,
              child: GetX<SubCatagoryController>(
                  init: Get.put<SubCatagoryController>(SubCatagoryController()),
                  builder: (SubCatagoryController todoController) {
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                        itemCount: todoController.Cancel_geter.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(todoController.Cancel_geter[index].subcatagoryid);
                          final _todoModel = todoController.Cancel_geter[index];
                          final t=_todoModel.reviewtime;
                          DateTime d = t.toDate();
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
                                        Column(
                                          children: [
                                            Container(
                                              height:MediaQuery.of(context).size.width*0.30,
                                              width: MediaQuery.of(context).size.width*0.25,
                                              decoration: BoxDecoration(
                                                  // image: DecorationImage(
                                                  //     image: NetworkImage(_todoModel.serviceImage),
                                                  //     fit: BoxFit.cover
                                                  // ),
                                                  //color: Color(int.parse(_todoModel.colorr)),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.phone_android,color: Color(0xffFF7D00),),
                                                        SizedBox(width: 20,),
                                                        Icon(Icons.call,color: Color(0xffFF7D00),),
                                                        SizedBox(width: 20,),
                                                        Icon(Icons.mail_rounded,color: Color(0xffFF7D00),)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                                Text(_todoModel.subcatagoryid,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("Cancel Date",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text(d.toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                              ],
                                            ),

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
                                                  child: Center(child: Text(_todoModel.subcatagoryid,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,)),),
                                                ),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Statues",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text("Cancel",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue),),
                                                SizedBox(width: 20,),
                                                // Card(
                                                //   elevation: 5,
                                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                //   child: InkWell(
                                                //     onTap: ()
                                                //     {
                                                //       Get.to(
                                                //           OrderStatues(
                                                //             // servicename: _todoModel.serviceName,
                                                //             // seviceCharges: _todoModel.statues,
                                                //             // serviceDuration:_todoModel.TimeFrame,
                                                //             // ServiceText: _todoModel.serviceName,
                                                //             // serviceImage: _todoModel.serviceImage
                                                //           )
                                                //       );
                                                //     },
                                                //     child: Container(
                                                //       height: 30,
                                                //       width: 90,
                                                //       decoration: BoxDecoration(
                                                //           color: Colors.blueAccent,
                                                //           // image: DecorationImage(
                                                //           //     image: NetworkImage(_todoModel.serviceImage),
                                                //           //     fit: BoxFit.cover
                                                //           // ),
                                                //           //color: Color(int.parse(_todoModel.colorr)),
                                                //           borderRadius: BorderRadius.circular(10)
                                                //       ),
                                                //       child: Center(
                                                //         child: Text("Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),

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
