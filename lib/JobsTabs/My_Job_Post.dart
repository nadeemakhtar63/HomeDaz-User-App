import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_daz/Booking/BookingScreen.dart';
import 'package:home_daz/Booking/Booking_details.dart';
import 'package:home_daz/Widgets/CustomButton.dart';
import 'package:home_daz/constant.dart';
import 'package:http/http.dart'as http;

import '../AuthenticationScreens/LogIn.dart';
import '../Controller/CatgoryController.dart';
import '../PostJob/Post_New_Job.dart';
class Job_Posetd extends StatefulWidget {
  const Job_Posetd({super.key});

  @override
  State<Job_Posetd> createState() => _Job_PosetdState();
}

class _Job_PosetdState extends State<Job_Posetd> {
  String service='';
  List _foundUsers=[];
  List allResults=[];
  List ListOfAdminToken=[];
  getAdminId()async{
    await firebaseFirestore.collection("adminuser").get().then((value)  {
      value.docs.forEach((element) {
        setState(() {
          ListOfAdminToken.add(element.data()['token']);
        });

      });
      print('all tokens: ${ListOfAdminToken}');
    });
  }
  late String _adminkey;
  getadminkeynapshot()async{
    firebaseFirestore.collection('serverId').get().then((value){
      value.docs.forEach((element) {
        // tokenvalue=element.data()['token'];
        _adminkey=element.data()['key'];
        // print("pppppppppppppppp${allTokenList}");
      });
    });
  }
  List offersends=[];
  serviceprovidefun(uid)async{
    firebaseFirestore.collection('serviceprovider').where("serviceProviderId",isEqualTo:uid).get().then((value)  {
      value.docs.forEach((element) {
        setState(() {
          _foundUsers= value.docs;
          allResults=_foundUsers;
        });
        print('Your Service name is $allResults');
        // getuserpaststeamsnapshot(service);

        // _foundUsers = allResults;
      });
      // print(value.docs[0]["heading"]);
    });
  }
  getuserpaststeamsnapshot()async{
    firebaseFirestore.collection('offersendbycontractor').where('serviceProviderId',isEqualTo:auth.currentUser!.uid).get().then((value)  {
      setState(() {
        _foundUsers= value.docs;
        offersends=_foundUsers;
        print("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
        // _foundUsers = allResults;
      });
      print(allResults);
      // print(value.docs[0]["serviceImage"]);
    });
  }
  initState(){
    initInfo();
    getadminkeynapshot();
    getuserpaststeamsnapshot();
    super.initState();
  }
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  initInfo()
  {
    var androidinitilize=const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInitialze=const IOSInitializationSettings();
    // var initilizationSetting=InitializationSettings(android: androidinitilize,iOS: iosInitialze);
    // flutterLocalNotificationsPlugin.initialize(initilizationSetting,onSelectNotification:(String? payload)async{
    //   try{}
    //   catch(e){
    //     if(payload!=null &&payload.isNotEmpty)
    //     {
    //
    //     }
    //     else
    //     {
    //
    //     }
    //   }
    //   return;
    // });
    FirebaseMessaging.onMessage.listen((event) {(RemoteMessage message)async{
      print("'''''''''''''''''print.................");
      print("onNessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation=BigTextStyleInformation(
          message.notification!.body.toString(),htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),htmlFormatContent: true
      );
      AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
          'notification',
          'notification details',importance: Importance.high,
          styleInformation: bigTextStyleInformation,priority: Priority.max,playSound: false
      );
      NotificationDetails plateformchanelspecification=NotificationDetails(android: androidNotificationDetails,
        // iOS: const IOSNotificationDetails()
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,message.notification?.body,
          plateformchanelspecification,payload: message.data['body']);
    };
    });
  }
  void sendPushNotification(String? token,String body,String title)async
  {
    print("Your Givin Token is");
    try {

      final response=   await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-type': 'application/json',
          'Authorization': _adminkey
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body:
      // allResults.length==null||allResults.length==0?Container():allResults[0]['statues']=='Pendding'?Container(
      //   child: Center(
      //     child: Text("YouR Request Not is In ${allResults[0]['statues']}"),
      //   ),
      // ):
      GetX<CatagoryController>(
          init: Get.put<CatagoryController>(CatagoryController()),
          builder: (CatagoryController todoController) {
            return ListView.builder(
              // scrollDirection: Axis.horizontal,
                itemCount: todoController.Booking_JobPost_geter.length,
                itemBuilder: (BuildContext context, int index) {
                  // print(todoController.Booking_JobPost_geter[index].Datepic);
                  final _todoModel =todoController.Booking_JobPost_geter[index];
                  // serviceprovidefun(_todoModel.userId);
                  firebaseFirestore.collection('serviceprovider').where("serviceProviderId",isEqualTo:_todoModel.userId).get().then((value)  {
                    value.docs.forEach((element) {
                      setState(() {
                        _foundUsers= value.docs;
                        allResults=_foundUsers;
                      });
                      print('Your Service name is $allResults');
                      // getuserpaststeamsnapshot(service);

                      // _foundUsers = allResults;
                    });
                    // print(value.docs[0]["heading"]);
                  });
                  return Card(
                      elevation: 5,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        // height: MediaQuery.of(context).size.width*0.50,
                        // width: MediaQuery.of(context).size.width*0.60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              allResults.isEmpty?Container():allResults[0]["image"]==null?Container():CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(allResults[0]["image"]),
                              ),
                              Container(
                                width: 1,
                                height: 120,
                                color: Colors.black,
                              ),
                              // Image.network(_todoModel.Datepic,height: 100,width: 100,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Service Offered:",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                        // SizedBox(width: 5,),
                                        Container(
                                          height: 20,
                                          width: 140,
                                          child: Flexible(
                                              child:  RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle: StrutStyle(fontSize: 12.0,),
                                                text:TextSpan(
                                                  style: TextStyle(color: Colors.black),
                                                  text: _todoModel.serviceName,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Provide at :",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                        // SizedBox(width: 20,),
                                        Container(
                                          height: 20,
                                          width: 140,
                                          child: Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 12.0),
                                              text:TextSpan(
                                                style: TextStyle(color: Colors.black),
                                               text: _todoModel.Address,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    _todoModel.contractor? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('JobType :',style: TextStyle(fontSize: 12,fontStyle: FontStyle.normal,fontWeight: FontWeight.w700),),
                                        Text('Contract ${_todoModel.horlypaycheck?" || hourly":""}',style: TextStyle(fontSize: 11,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),)
                                      ],
                                    ):Container(),
                                    SizedBox(height: 5,),
                                    _todoModel.horlypaycheck? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Hourly :',style: TextStyle(fontSize: 12,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                                        Text(_todoModel.horlycharge,style: TextStyle(fontSize: 12,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                                      ],
                                    ):Container(),
                                    SizedBox(height: 10,),
                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     Text("Address ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                    //     // SizedBox(width: 10,),
                                    //     Text(_todoModel.Address,maxLines: 2,overflow: TextOverflow.fade,
                                    //       style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                    //
                                    //   ],
                                    // ),
                                    // _todoModel.TimeFrame==""?Text(""):
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed:(){

                                                },
                                                icon: Icon(Icons.person,size: 18,)),
                                            Text(_todoModel.views.toString(),style: TextStyle(fontSize: 11),)
                                          ],
                                        ),
                                        Container(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed:(){},
                                                  icon: Icon(Icons.ads_click,size: 18,)),
                                              Text(_todoModel.bids.toString(),style: TextStyle(fontSize: 11),)
                                            ],
                                          ),
                                        ),
                                GestureDetector(
                                  // The onTap Field is used here.
                                  onTap: (){
                                    Get.to(Booking_Details(
                                      contractorId: _todoModel.userId,
                                        servicename: _todoModel.serviceName,
                                        seviceCharges:int.parse(_todoModel.horlycharge),
                                        serviceDuration:"" ,
                                        ServiceText:1,
                                        serviceImage: "")
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      //shape: BoxShape.circle,
                                      color: Color(0xffFF7D00),
                                    ),
                                    child: Center(
                                      child: Text(
                                        // The Symbol is used here
                                        "Send Request",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                      ],
                                    ),
                                  ],

                                ),
                              ),

                            ],
                          )
                      )
                  );
                }
            );
          }
      ),
    );
  }
}
