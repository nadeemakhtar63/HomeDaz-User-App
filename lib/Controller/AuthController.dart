import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_daz/AuthenticationScreens/LogIn.dart';
import 'package:home_daz/TabScreens/TabLayout.dart';
import 'package:home_daz/constant.dart';
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
class AuthController extends GetxController
{
  late GetStorage _box;
  AuthService() {
    _box = new GetStorage();
  }
  RxBool sharebox = false.obs;
  static AuthController instance=Get.find();
  late Rx<User?> firebaseUser;
  void onReady(){
    super.onReady();
    firebaseUser=Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    // ever(firebaseUser,_setInitialScreen);
  }
  void login(String email,String password,)async
  {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        String? token=await FirebaseMessaging.instance.getToken();
        firebaseFirestore.collection("user").doc(auth.currentUser!.uid).update({
          'token':token
        },
            //SetOptions(merge: true)
            );
        print('my token$token');
        Get.to(TabLayouts());
        Get.snackbar("WELCOME", "WELCOME TO BEST SERVICE PROVIDER SYSTEM");
      }
    }
    catch(e)
    {
      Get.snackbar("Error", e.toString());
    }
  }
  Future resetPassword(emails) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emails);
      Get.snackbar('Response','Password reset link sent to your email address');
      Get.offAll(LogIn());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("response","${e.message.toString()}");
      return;
    }
  }
  guestuser() async
  {
    try {
      final userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      Get.offAll(TabLayouts());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print(e.code.toString());
      }
    }
  }
  void register(@required String email,@required String password,@required String uname,@required String number)async{
    try
    {
      final user= await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if(user!=null)
      {
        String? token=await FirebaseMessaging.instance.getToken();
        await firebaseFirestore.collection("user").doc(auth.currentUser!.uid).set({
          'username':uname,
          'email':email,
          'token':token,
          'url':'',
          'phoneno':number,
          'statues':'',
          'address':"",
          'lastmesg':"",
          'uid':auth.currentUser!.uid

        }).then((value) {
          Get.offAll(TabLayouts());
          Get.snackbar("WELCOME", "WELCOME TO BEST SERVICE PROVIDER SYSTEM");
        });
      }
    }
    catch (e) {
      authProblems? errorType;
      if (Platform.isAndroid) {
        switch (e) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error ( such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
        // ...
          default:
            print('Case ${e} is not yet implemented');
        }
      }
      print('The error is $errorType');
    }
  }
  void signout()async{
    await auth.signOut();
    Get.to(LogIn());
  }
}