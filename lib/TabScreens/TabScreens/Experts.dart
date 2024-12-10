import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/ExpertScreens/ExpersScreens.dart';
import 'package:home_daz/ModelClass/providerModelClass.dart';

class Experts extends StatefulWidget {
  // const ({Key? key}) : super(key: key);

  @override
  State<Experts> createState() => _State();
}

class _State extends State<Experts> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("OVER EXPER\'S"),
      ),
      body:
        GetX<CatagoryController>(
            init: Get.put<CatagoryController>(CatagoryController()),
            builder: (CatagoryController todoController) {
              return Column(
                children: [
                Card(
                elevation: 5,
                child: Container(
                    height: MediaQuery.of(context).size.height*0.20,
                    color: Color(0xffD9EBF6),
                    child: CarouselSlider(
                      items: todoController.TechnishionList
                          .map((item) =>
                          Container(
                            // color: Get.theme.cardColor,
                            width: MediaQuery.of(context).size.width,
                            height:  MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(40)
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                                      image: NetworkImage(item.Image)
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(item.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 20,),
                                  Text(item.serviceprovide,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 20,),
                                  RatingBarIndicator(
                                    rating:item.rating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      )
                          .toList(),
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,

                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          //  onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    )

                ),
              ),
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: todoController.TechnishionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(todoController.Catagory[index].catgoryName);
                            final _todoModel = todoController.TechnishionList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                 Get.to(()=> ExpertsSCreen(
                                   phoneno: _todoModel.phoneno,
                                    image: _todoModel.Image,
                                    name: _todoModel.name,
                                      rating: _todoModel.rating,
                                    reviews: _todoModel.reviews,
                                    seviceprovide: _todoModel.serviceprovide,
                                  ));
                                },
                                child: Container(
                                  height: 150,
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
                                          backgroundImage: NetworkImage(_todoModel.Image),
                                        ),

                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_todoModel.name),
                                          Text(" Reviews(3)"),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating:_todoModel.rating,
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
                                    ],
                                  ),

                                ),
                              ),
                            );
                          }
                      )
                  ),
                ],
              );
            }
        ),

    );
  }
}
