import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_daz/FirebaseCRUD/FirbaseDB.dart';
import 'package:image_picker/image_picker.dart';

import '../../AuthenticationScreens/LogIn.dart';
import '../../Widgets/CustomButton.dart';
import '../../Widgets/TextFields.dart';
import '../../Widgets/textfileds.dart';
import '../../constant.dart';
class Profile extends StatefulWidget {
  // const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  // /// Get from camera
  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  File? imageFile;
  showAlertDialog(BuildContext context) {
    Widget okButton = MaterialButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Media"),
      actions: [
        IconButton(onPressed: (){
          // _getFromCamera();
          Navigator.pop(context);
        }, icon: Icon(Icons.camera_alt)),
        IconButton(onPressed: (){
          // _getFromGallery();
          Navigator.pop(context);
        }, icon: Icon(Icons.description))

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  TextEditingController AdressInputController=new TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController statusCotroller=TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
                children: [
                  Expanded(
                    child: auth.currentUser!.isAnonymous?
                    InkWell(
                      onTap: (){
                        Get.to(()=>LogIn());
                      },
                      child: Center(child:Container(
                        width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.withOpacity(0.5)
                        ),
                        child: Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),),
                      ) ,),
                    ):
                    StreamBuilder<QuerySnapshot>(
                        stream: firebaseFirestore.collection('user').where('uid',isEqualTo: auth.currentUser!.uid).snapshots() ,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return new Text("No record found");
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new ListView
                              (
                              //controller: _controller,
                              children: getExpenseItems(snapshot),
                            ),
                          );
                        }),
                  ),

                ]
            )
        )
    );
  }
  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return  snapshot.data!.docs.map((doc) =>
        Container(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                height: MediaQuery.of(context).size.height*0.2,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    imageFile==null?
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.teal,
                            image: DecorationImage(image: NetworkImage(doc['url']),fit: BoxFit.cover)
                        )):
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.teal,
                          image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover)
                      ),
                      //child:  Image.file(imageFile!,fit: BoxFit.cover,),
                    ),
                    //        :Container(
                    //   height: 120,
                    //   width: 120,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(90),
                    //     color: Colors.teal,
                    //     image: DecorationImage(image: NetworkImage(doc['url']),fit: BoxFit.cover)
                    //   ),
                    //  //child:  Image.file(imageFile!,fit: BoxFit.cover,),
                    // ),
                    new Positioned(
                        bottom: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3.0, // soften the shadow
                                  spreadRadius: 3.0, //extend the shadow
                                  // offset: Offset(
                                  //   15.0, // Move to right 10  horizontally
                                  //   15.0, // Move to bottom 10 Vertically
                                  // ),
                                )// Move to bottom 10 Vertically
                              ],
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: IconButton(
                              onPressed: (){
                                showAlertDialog(context);
                              },
                              icon: Icon(Icons.add)),
                        ))
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height*0.45,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                        CustomTextFields(
                            namecontroller,
                            false,
                            doc['username']==null?"username":doc['username'],
                            TextInputType.text,
                            false,
                            Icon(Icons.person,color: Colors.blue,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextFields(
                            namecontroller,
                            false,
                            doc['phoneno']==null?"phone number":doc['phoneno'],
                            TextInputType.text,
                            false,
                            Icon(Icons.phone,color: Colors.blue,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height*0.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffFF7D00)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: AdressInputController,
                            keyboardType: TextInputType.multiline,

                            textInputAction: TextInputAction.newline,
                            minLines: 1,
                            maxLines: 4,
                            decoration: InputDecoration(
                             // errorText: adresvalidate?"*Required Working Address":null,
                              hintText:doc['address']==""||doc['address']==null?"e.g. city address,streat address,house no":doc['address']
                              ,
                              // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                              hintStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(onTap: (){
                      if(namecontroller.text.isNotEmpty && statusCotroller.text.isNotEmpty && imageFile!=null)
                      {
                        FirebaseDB.updateProfile(imageFile,namecontroller.text.toString(),statusCotroller.text.toString());

                        // Get.snackbar("Response", res);
                        Get.snackbar("Response", "Profile Update Sucessfully");
                      }
                      else if(imageFile==null)
                      {
                        String name= namecontroller.text.toString()==''?doc['username']:namecontroller.text.toString();
                        String str=statusCotroller.text.toString()==''?doc['statues']:statusCotroller.text.toString();
                        // File? file=imageFile==null?doc['url']:imageFile;
                        FirebaseDB.updateProfilepreviouseimage(
                            doc['url'],
                            name,
                            str);
                        Get.snackbar("Response", "Profile Update Sucessfully");
                      }
                      else{
                        String name= namecontroller.text.toString()==''?doc['username']:namecontroller.text.toString();
                        String str=statusCotroller.text.toString()==''?doc['statues']:statusCotroller.text.toString();
                        FirebaseDB.updateProfile(
                            imageFile==null?File(doc['url']):imageFile,
                            name,
                            str);
                        Get.snackbar("Response", "Profile Update Sucessfully");
                      }
                    }, text: 'Update',),
                  )
              )
            ],
          ),
        ),
    ).toList();;
  }
}
