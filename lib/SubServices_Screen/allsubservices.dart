import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Booking/BookingScreen.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/Controller/SubCatgoryController.dart';
import 'package:home_daz/ModelClass/SubCatogoryModel.dart';
import 'package:home_daz/SubServices_Screen/SubServices.dart';

class AllSubServices extends StatefulWidget {
  const AllSubServices({Key? key}) : super(key: key);

  @override
  State<AllSubServices> createState() => _AllSubServicesState();
}

class _AllSubServicesState extends State<AllSubServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GetX<SubCatagoryController>(
            init: Get.put<SubCatagoryController>(SubCatagoryController()),
            builder: (SubCatagoryController todoController) {
              print(todoController.subCatagory.length);
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: todoController.subCatagory.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(todoController.subCatagory[index].name);
                        final _todoModel = todoController.subCatagory[index];
                        return InkWell(
                          onTap: (){
                            Get.to(
                                Booking(
                                  image: _todoModel.Image,
                                  servicename:_todoModel.name,
                                  shortDes:_todoModel.shortDes,
                                  reviwes:_todoModel.reviews,
                                  mainservicename:_todoModel.mainservice,
                                  howitwork:_todoModel.Howitworks,
                                  serviceCharges:_todoModel.service_charges,
                                  serviceRequirDuration:_todoModel.repiringTimeRequired,
                                  extraTex:_todoModel.tax,
                                ));
                            // Get.to(SubServices(idkey: _todoModel.DocumentId,));
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      image: DecorationImage(image: NetworkImage(_todoModel.Image,),fit: BoxFit.cover)
                                  ),

                                ),
                                Container(
                                  height: 60,
                                  width:  MediaQuery.of(context).size.width*0.45,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(_todoModel.name,style: TextStyle(fontWeight: FontWeight.w900),),
                                      // SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: RatingBarIndicator(
                                          rating: _todoModel.reviews,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                      // SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(" Start From",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700),),
                                          Text('${_todoModel.service_charges.toString()}\$')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  )
              );
            }
        ),
      ),
    );
  }
}
