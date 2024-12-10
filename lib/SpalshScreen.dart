import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_daz/AuthenticationScreens/LogIn.dart';
import 'package:home_daz/TabScreens/TabLayout.dart';
import 'package:home_daz/constant.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String dotCoderLogo = 'https://raw.githubusercontent.com/OsamaQureshi796/MealMonkey/main/assets/dotcoder.png';
@override
  void initState() {
  requestPermission();

  // initInfo();
  // getToken();
    // TODO: implement initState
    super.initState();
  }

  void requestPermission()async{
  FirebaseMessaging messaging=FirebaseMessaging.instance;
  NotificationSettings settings=await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true
  );
  print("permission");
  if(settings.authorizationStatus==AuthorizationStatus.authorized){
    print("user garanted permission");
  }
  else if(settings.authorizationStatus==AuthorizationStatus.provisional)
    {
      print("user garanted provisional permission");
    }
  else
    {
      print("user denied and not grant any  permission");
    }
  }
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if(user.isNull){
      Timer(Duration(seconds: 5),()=> Get.offAll(()=>LogIn()));

    }else{
      Timer(Duration(seconds: 5),()=> Get.offAll(()=>TabLayouts()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(width: Get.width,
                  height: 220,
                  child: Image.asset('assets/logo.png')
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //   Text("FCM by DOTCODER")
//
          ],
        ),
      ),
    );
  }
}
