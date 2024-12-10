import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_daz/SpalshScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
 _firbaseMessagingBackgroundHandler(RemoteMessage message)async{


}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await   Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(
  //     _firbaseMessagingBackgroundHandler);
  runApp
    (
      new GetMaterialApp(home: SplashScreen(),)
    );
}
