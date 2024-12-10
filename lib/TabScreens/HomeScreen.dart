import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:home_daz/PostJob/Post_New_Job.dart';
import 'package:http/http.dart'as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Booking/BookingScreen.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/ExpertScreens/ExpersScreens.dart';
import 'package:home_daz/MainCatagories/maincatagoriesfiles.dart';
import 'package:home_daz/Order_Progress/OrdersTabLayout.dart';
import 'package:home_daz/SubServices_Screen/SubServices.dart';
import 'package:home_daz/SubServices_Screen/allsubservices.dart';
import 'package:home_daz/TabScreens/TabScreens/Experts.dart';
import 'package:home_daz/TabScreens/TabScreens/Profile.dart';
import 'package:home_daz/TabScreens/TabScreens/contect_list.dart';
import 'package:home_daz/Widgets/TextFields.dart';
import 'package:home_daz/constant.dart';
import '../AuthenticationScreens/LogIn.dart';
import 'TabScreens/ChatScreen.dart';
class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List albums=[
    "assets/homefirstimage.png",
    "assets/homefirstimage.png"
  ];
  List Catgory=[
    "assets/door.png",
    "assets/nature.png",
    "assets/shower.png",
    "assets/snow.png",
    "assets/tiles.png",
    "assets/window.png",
    "assets/constratcion.png",
    "assets/electrician.png",
    "assets/gardening.png",
    "assets/home.png",
  ];

  List CatogoriesColor=
  [
  0xffFFD2A7,
  0xff98C4FF,
  0xffFFD2A7,
  0xff98C4F,
  0xffFFD2A,
  0xff98C4FF,
  0xffFFD2A7,
  0xff98C4F,
  0xffFFD2A7,
  0xff98C4FF,
  0xffFFD2A7,
  0xff98C4FF
  ];
 List CatogoryNameList=
 [
 "GARDENING\nSERVICES",
 "HOME\nREMODELING",
   "WINDOW\nINSTALLATION",
   "FURNITURE\nREPAIR",
   "HOME\nREMODELING",
   "ELECTRITION\nSERIVCES",
   "SHOWER\nREPAIR",
   "ROOFING\nDESIGN",
   "STAIR/RAILING\nSERVICES",
   "SNOW REMOVAL\nPLOW / SHOVEL",
   "TILE/GROUT\nSERVICES",
   "TREE SERVICES/\nARBORIST"
 ];
  List _foundUsers=[];
  List allResults=[];
  getuserpaststeamsnapshot()async{
    firebaseFirestore.collection('subservices').get().then((value)  {
      setState(() {
        allResults=value.docs;
        _foundUsers = allResults;
      });
      // print(value.docs[0]["heading"]);
    });
  }
  String? token;
  getToken()async
  {
    token=await FirebaseMessaging.instance.getToken();
    sendPushNotification(token, 'New Project Requested', "Order Request");
    print("token is $token");
  }
initState(){
  getuserpaststeamsnapshot();
    super.initState();
    getToken();
    // initInfo();
}
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
// initInfo()
// {
  // var androidinitilize=const AndroidInitializationSettings('@mipmap/ic_launcher');
  // var iosInitialze=const IOSInitializationSettings();
  // var initilizationSetting=InitializationSettings(android: androidinitilize,iOS: iosInitialze);
  // flutterLocalNotificationsPlugin.initialize(initilizationSetting,onSelectNotification:(String? payload)async{
  //   try{}
  //   catch(e){
  //   if(payload!=null &&payload.isNotEmpty)
  //     {
  //
  //     }
  //   else
  //     {
  //
  //     }
  //   }
  //   return;
  // });
//   FirebaseMessaging.onMessage.listen((event) {(RemoteMessage message)async{
//     print("'''''''''''''''''print.................");
//     print("onNessage: ${message.notification?.title}/${message.notification?.body}");
//     BigTextStyleInformation bigTextStyleInformation=BigTextStyleInformation(
//       message.notification!.body.toString(),htmlFormatBigText: true,
//       contentTitle: message.notification!.title.toString(),htmlFormatContent: true
//     );
//     AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
//         'notification',
//         'notification details',importance: Importance.high,
//         styleInformation: bigTextStyleInformation,priority: Priority.max,playSound: false
//     );
//     NotificationDetails plateformchanelspecification=NotificationDetails(android: androidNotificationDetails,
//     // iOS: const IOSNotificationDetails()
//     );
//     await flutterLocalNotificationsPlugin.show(0, message.notification?.title,message.notification?.body,
//         plateformchanelspecification,payload: message.data['body']);
//   };
//   });
// }
  int _current = 0;
  final CarouselController _controller = CarouselController();
  TextEditingController searchController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,

              child:Center(child: Image(image: AssetImage("assets/logo.png"),),) ,
            ),
            Divider(),
            InkWell(
              onTap: (){
                Get.to(()=>Profile());
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.person),
                  SizedBox(width: 20,),
                  Text("Profile")
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(()=>Experts());
              },
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.settings_outlined),
                    SizedBox(width: 20,),
                    Text("Over Experts")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(()=>SubServices());
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.cleaning_services_outlined),
                  SizedBox(width: 20,),
                  Text("Services")
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(()=>OrderTabs());
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.work_outlined),
                  SizedBox(width: 20,),
                  Text("Bookings")
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(()=>ContectList());
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.email),
                  SizedBox(width: 20,),
                  Text("Messages")
                ],
              ),
            ),
            InkWell(
              onTap: (){
                // Get.to(()=>);
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.lock),
                  SizedBox(width: 20,),
                  Text("PrivacyPolicy ")
                ],
              ),
            ),
          ],
        ) ,),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFF7D00),
        centerTitle: true,
        title: Text("Home Service"),
        actions: [
          Icon(Icons.notification_add,color: Colors.blue,),
        ],
      ),
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
        backgroundColor: Color(0xffFF7D00),
        icon: Icon(Icons.login,color: Colors.white,),
        label: Text("LogIn",style: TextStyle(fontWeight: FontWeight.w900,),),
      ):
      FloatingActionButton.extended(
        elevation: 3,
        onPressed: ()
        {
          Get.to(()=>PostNewJob());
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
        backgroundColor:Color(0xffFF7D00),
        icon: Icon(Icons.post_add,color: Colors.white,),
        label: Text("Post Job",style: TextStyle(fontWeight: FontWeight.w900,),),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.550,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("CATEGORIES",style: TextStyle(fontSize:14 ,fontWeight:FontWeight.w700 ),),
                          InkWell(
                            onTap: (){
                              Get.to(MainCatagoriesServices());
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFF7D00)
                              ),
                              child: Center(child: Text("VIEW ALL",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                   GetX<CatagoryController>(
                        init: Get.put<CatagoryController>(CatagoryController()),
                        builder: (CatagoryController todoController) {
                          return Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
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
                                                    decoration: BoxDecoration(
                                                        // color: Color(int.parse(_todoModel.colorr)),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Image.network(_todoModel.Image,height: 90,width: 120,),
                                                        Container(
                                                          // width: 90,
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(_todoModel.catgoryName,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
                                                        )
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
                    // Container(
                    //     width: double.infinity,
                    //     height: 140,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20)
                    //     ),
                    //     child: ListView.builder(
                    //         itemCount: 10,
                    //         scrollDirection: Axis.horizontal,
                    //         itemBuilder: (context,index)
                    //         {
                    //           return Card(
                    //             elevation: 0,
                    //             child: Container(
                    //               height: 85,
                    //               width: 110,
                    //               decoration: BoxDecoration(
                    //                   color: Color(CatogoriesColor[index]),
                    //                   borderRadius: BorderRadius.circular(10)
                    //               ),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                 children: [
                    //                   Image.asset(Catgory[index]),
                    //                   Text(CatogoryNameList[index],style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),)
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         }
                    //     )
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("OVER EXPERT'S",style: TextStyle(fontSize:14 ,fontWeight:FontWeight.w700 ),),
                          InkWell(
                            onTap: (){
                              Get.to(Experts());
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffFF7D00)
                              ),
                              child: Center(child: Text("VIEW ALL",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)),
                            ),
                          ),

                        ],
                      ),
                    ),
                    GetX<CatagoryController>(
                        init: Get.put<CatagoryController>(CatagoryController()),
                        builder: (CatagoryController todoController) {
                          return Container(
                              width: double.infinity,
                              height: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: todoController.TechnishionList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // print(todoController.Catagory[index].catgoryName);
                                    final _todoModel = todoController.TechnishionList[index];
                                    return InkWell(
                                      onTap: (){
                                        sendPushNotification('', 'New Project Requested', "Order Request");
                                        Get.to(()=> ExpertsSCreen(
                                          phoneno: _todoModel.phoneno,
                                          image: _todoModel.Image,
                                          name: _todoModel.name,
                                          rating: _todoModel.rating,
                                          reviews: _todoModel.reviews,
                                          seviceprovide: _todoModel.serviceprovide,
                                        ));
                                        // Get.to(SubServices(idkey: _todoModel.DocumentId,));
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
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(90),
                                                      image: DecorationImage(
                                                          image: NetworkImage(_todoModel.Image,),fit: BoxFit.cover
                                                      )
                                                  ),
                                                ),
                                                Text(_todoModel.name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                               , Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: RatingBarIndicator(
                                                    rating: _todoModel.rating,
                                                    itemBuilder: (context, index) => Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 15.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                ),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("RECOMENDED FOR YOU",style: TextStyle(fontSize:14 ,fontWeight:FontWeight.w700 ),),
                          InkWell(
                            onTap: (){
                              Get.to(()=>SubServices()
                              );
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffFF7D00)
                              ),
                              child: Center(child: Text("VIEW ALL",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 2,
                          //   crossAxisSpacing: 5.0,
                          //   mainAxisSpacing: 5.0,
                          // ),
                          scrollDirection: Axis.horizontal,
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: (){
                                  Get.to(Booking(image: _foundUsers[index]["image"],
                                    servicename:  _foundUsers[index]['name'],
                                    shortDes: _foundUsers[index]['shortDes'],
                                    reviwes: _foundUsers[index]['reviews'],
                                    mainservicename: _foundUsers[index]['mainservice'],
                                    howitwork: _foundUsers[index]['Howitworks'],
                                    serviceCharges: _foundUsers[index]["service_charges"],
                                    serviceRequirDuration:_foundUsers[index]["repair_time_requir"] ,
                                    extraTex: _foundUsers[index]["tax"],
                                  ));
                                  // Booking(_foundUsers[index]["image"], _foundUsers[index]['name'],_foundUsers[index]['shortDes'],
                                  // _foundUsers[index]['mainservice'],_foundUsers[index]['Howitworks'],_foundUsers[index]['reviews']));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,

                                            image: DecorationImage(image: NetworkImage(_foundUsers[index]["image"],),fit: BoxFit.cover)
                                        ),
                                      ),
                                      Container(
                                        // height: 60,
                                        // width: 160,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Text(_foundUsers[index]["name"],style: TextStyle(fontWeight: FontWeight.w900),),
                                            // SizedBox(height: 5,),
                                            SizedBox(height: 10,),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RatingBarIndicator(
                                                rating: _foundUsers[index]['reviews'],
                                                itemBuilder: (context, index) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            // SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(" Start From",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700),),
                                                SizedBox(width: 20,),
                                                Text('${_foundUsers[index]["service_charges"].toString()}\$')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
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
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height*0.23,
              color: Color(0xffD9EBF6),
              child: CarouselSlider(
                items: _foundUsers
                    .map((item) =>
                    Container(
                      // color: Get.theme.cardColor,
                      width: MediaQuery.of(context).size.width,
                      height:  MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(40)
                      ),
                      child: InkWell(
                        onTap: (){
                          Get.to(Booking(image: _foundUsers[_current]["image"],
                            servicename:  _foundUsers[_current]['name'],
                            shortDes: _foundUsers[_current]['shortDes'],
                            reviwes: _foundUsers[_current]['reviews'],
                            mainservicename: _foundUsers[_current]['mainservice'],
                            howitwork: _foundUsers[_current]['Howitworks'],
                            serviceCharges: _foundUsers[_current]["service_charges"],
                            serviceRequirDuration:_foundUsers[_current]["repair_time_requir"] ,
                            extraTex: _foundUsers[_current]["tax"],
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                             //     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                                  image: NetworkImage(_foundUsers[_current]["image"])
                              )
                          ),
                          // color: Color(0xff00ffcc),
                          // elevation: 0,
                          // child: Stack(
                          //   children: [
                          //     // Padding(
                          //     //   padding: EdgeInsets.only(top: 20),
                          //     //   child: Positioned(
                          //     //     left: 10,
                          //     //     child: Container(
                          //     //         child: Text("GARDENING SERVICES")
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //     // Positioned(
                          //     //   top: 40,
                          //     //   left: 10,
                          //     //   child: Container(
                          //     //
                          //     //       child: Text("Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Ut eget\n felis pharetra, bibendum eros eu")
                          //     //   ),
                          //     // ),
                          //     // Container(
                          //     //     color: Colors.blue,
                          //     //     child: Text("data is very")),
                          //     Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Image.network(_foundUsers[_current]["image"],)),
                          //   ],
                          // ),
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
          Positioned(
            top: MediaQuery.of(context).size.height*0.2,
           left: 20,
            child: Container(
              decoration: BoxDecoration(
                // boxShadow:[ BoxShadow(color: Colors.black12)],
                borderRadius: BorderRadius.circular(40),
              ),
              width: MediaQuery.of(context).size.width*0.9,
              height: 50,
              child: TextField(
                autocorrect: true,
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: searchController,
                style: TextStyle(color: Color(0xff3D4864)),
                decoration: InputDecoration(
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: new BorderSide(color: Color(0xffFF7D00))
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:  BorderSide(color: Color(0xffFF7D00), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:  BorderSide(color: Color(0xffFF7D00), width: 0.0),
                    ),
                    hintText: "Search here...",
                    prefixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(color: Color(0xff3D4864)),
                    // errorText: boolvalidate?"$hintText Required*":null
                ),

              ),
            ),

          ),
        ],
      ),
    );
  }
  void sendPushNotification(String? token,String body,String title)async
  {
    print("Your Givin Token is");
    try {

      final response=   await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'content-type': 'application/json',
            'Authorization': 'key=AAAACy03Od8:APA91bGi65Db_-qhWnFVAIC1mXFwHe3QKDQPjz5L3_Ee3F5QQ0jYQlNk83E340CMn0tcaNH-UOO6YzZcRpa2jd8QT-Z2bMyipw9thj_Ii43RZeCdRgq9KLVfylmgJKzHMsaAkAchRun3'
          },
          body: jsonEncode(
              <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': 'body',
              'title': 'title'
            },
            "notification":<String,dynamic>{
              "title":'title',
              "body":'body',
              "android_channel_id":"abcd"
            },
            "to":token
          }),
      );
      if (response.statusCode == 200) {
        print('test ok push CFM');
        // return true;
      } else {
        print(' CFM error');
        print(response.statusCode);
        // return false;
      }
    }
    catch(firebaseAuthException)
    {
      print('reasun for why notification${firebaseAuthException.toString()}');
    }
  }
}
