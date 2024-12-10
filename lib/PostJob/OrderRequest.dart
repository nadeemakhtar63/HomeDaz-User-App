import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:home_daz/Controller/CatgoryController.dart';
import 'package:home_daz/constant.dart';
import 'package:http/http.dart'as http;
class OrderRequest extends StatefulWidget {
  const OrderRequest({Key? key}) : super(key: key);
  @override
  State<OrderRequest> createState() => _OrderRequestState();
}
class _OrderRequestState extends State<OrderRequest> {
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
  initState(){
    initInfo();
    serviceprovidefun();
    getadminkeynapshot();
    getuserpaststeamsnapshot();
    super.initState();
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
  serviceprovidefun()async{
    firebaseFirestore.collection('serviceprovider').where("serviceProviderId",isEqualTo:auth.currentUser!.uid).get().then((value)  {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // appBar: AppBar(
    //   title: Text("Create Job Post"),
    //   actions: [IconButton(onPressed: (){
    //
    //   }, icon: Icon(Icons.add,size: 35,)),
    // ]
    // ),
      body:allResults.length==null||allResults.length==0?Container():allResults[0]['statues']=='Pendding'?Container(
        child: Center(
          child: Text("YouR Request Not is In ${allResults[0]['statues']}"),
        ),
      ):
      GetX<CatagoryController>(
          init: Get.put<CatagoryController>(CatagoryController()),
          builder: (CatagoryController todoController) {
            return ListView.builder(
              // scrollDirection: Axis.horizontal,
                itemCount: todoController.Booking_geter.length,
                itemBuilder: (BuildContext context, int index) {
                  print(todoController.Booking_geter[index].Datepic);
                  final _todoModel =todoController.Booking_geter[index];
                  return Card(
                      elevation: 5,
                      child: Flexible(
                          // height: MediaQuery.of(context).size.width*0.50,
                          // width: MediaQuery.of(context).size.width*0.60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
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
                                  // Container(
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Container(
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             Icon(Icons.phone_android,color: Color(0xffFF7D00),),
                                  //             SizedBox(width: 20,),
                                  //             Icon(Icons.call,color: Color(0xffFF7D00),),
                                  //             SizedBox(width: 20,),
                                  //             Icon(Icons.mail_rounded,color: Color(0xffFF7D00),)
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              // Image.network(_todoModel.Datepic,height: 100,width: 100,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Service Book:",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                        SizedBox(width: 20,),
                                        Text(_todoModel.serviceName,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
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
                                  // _todoModel.serviceName==offersends[index]['']?Conta
                                  InkWell(
                                    onTap: (){
                                      firebaseFirestore.collection("offersendbycontractor").add({
                                        'username':allResults[0]['username'],
                                        'email':allResults[0]['email'],
                                        'image':allResults[0]['image'],
                                        "reviews":allResults[0]['reviews'],
                                        "rating":allResults[0]['rating'],
                                        'serviceProviderId':allResults[0]['serviceProviderId'],
                                        'phoneno':allResults[0]['phoneno'],
                                        'statues':allResults[0]['statues'],
                                        "name":allResults[0]['name'],
                                        'serviceprovide':_todoModel.serviceName,
                                        "Adress":allResults[0]['Adress'],
                                        "jobType":allResults[0]['jobType'],
                                        'serviceProviderId':allResults[0]['serviceProviderId'],
                                        "nationalId":allResults[0]['nationalId'],
                                      }).then((value)async {
                                        firebaseFirestore.collection("contractorprofile").
                                        doc(auth.currentUser!.uid).collection("Aceptofferr").add({
                                          'username':allResults[0]['username'],
                                          'email':allResults[0]['email'],
                                          'image':allResults[0]['image'],
                                          "reviews":allResults[0]['reviews'],
                                          "rating":allResults[0]['rating'],
                                          'serviceProviderId':allResults[0]['serviceProviderId'],
                                          'phoneno':allResults[0]['phoneno'],
                                          'statues':allResults[0]['statues'],
                                          "name":allResults[0]['name'],
                                          'serviceprovide':_todoModel.serviceName,
                                          "Adress":allResults[0]['Adress'],
                                          "jobType":allResults[0]['jobType'],
                                          'serviceProviderId':allResults[0]['serviceProviderId'],
                                          "nationalId":allResults[0]['nationalId'],
                                        }).then((value)async {
                                          ListOfAdminToken.forEach((element) {
                                            sendPushNotification(element,"${allResults[0]['name']} Offer Accepted", "${allResults[0]['name']} send offer on ${_todoModel.serviceName} ");
                                          });
                                          // Get.offAll(TabLayouts());
                                          Get.snackbar("Send", "Your Offer Send to Admin");
                                        });

                                      });

                                    },
                                    child: Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width*0.3,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          // image: DecorationImage(
                                          //     image: NetworkImage(_todoModel.serviceImage),
                                          //     fit: BoxFit.cover
                                          // ),
                                          //color: Color(int.parse(_todoModel.colorr)),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text("Accept",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                                      ),
                                    ),
                                  )
                                  //     :Container(
                                  //   child: Center(child: Text("Your Request is pending"),),
                                  // ),
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
}
