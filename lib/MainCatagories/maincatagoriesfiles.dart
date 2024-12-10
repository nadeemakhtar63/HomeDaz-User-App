import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Controller/CatgoryController.dart';

import '../SubServices_Screen/SubServices.dart';

class MainCatagoriesServices extends StatefulWidget {
  const MainCatagoriesServices({Key? key}) : super(key: key);

  @override
  State<MainCatagoriesServices> createState() => _MainCatagoriesServicesState();
}

class _MainCatagoriesServicesState extends State<MainCatagoriesServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<CatagoryController>(
          init: Get.put<CatagoryController>(CatagoryController()),
          builder: (CatagoryController todoController) {
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
                    itemCount: todoController.Catagory.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(todoController.Catagory[index].catgoryName);
                      final _todoModel = todoController.Catagory[index];
                      return InkWell(
                        onTap: (){
                          Get.to(SubServices(idkey: _todoModel.DocumentId,));
                        },
                        child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                // color: Color(int.parse(_todoModel.colorr)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(_todoModel.Image,height: 90,width: 90,),
                                  Text(_todoModel.catgoryName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            )
                        ),
                      );
                    }
                )
            );
          }
      ),
    );
  }
}
