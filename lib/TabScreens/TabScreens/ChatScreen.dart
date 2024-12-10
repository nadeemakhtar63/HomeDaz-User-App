import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:home_daz/FirebaseCRUD/FirbaseDB.dart';
import 'package:home_daz/ModelClass/mesg_module.dart';
import 'package:home_daz/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../AuthenticationScreens/LogIn.dart';
import '../../PhotoFullScreen.dart';
import '../../imageshare.dart';
class ChatScreen extends StatefulWidget {
  final String uname;
  final String statues;
  final String url;
  final String uid;
  final String? token;
  var statuestime;
  final bool? devicestate;
  // final LocalFileSystem localFileSystem;
  ChatScreen({
    // localFileSystem,
    required this.uname,
    required this.statues,
    required this.url,
    required this.uid,
    this.statuestime,
    this.devicestate,
    this.token}) ;
  // ChatScreen({Key? key,required this.token,required this.uname,required this.statues,required this.url,required this.uid}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController contentTextEditorController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:Container(
          padding: EdgeInsets.all(5),
          child: widget.url.isEmpty?Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.person,)):CircleAvatar(
            backgroundImage: NetworkImage(widget.url),
          ),
        ),
        elevation: 0.0,
        title: Text(widget.uname,style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:

      Container(
        child: Column(
          children: [
            Container(
          child:  Expanded(
            child: auth.currentUser!.isAnonymous?
            InkWell(
              onTap: (){
                Get.to(()=>LogIn());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child:Container(
                  width: 160,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.withOpacity(0.5)
                  ),
                  child: Center(child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),),
                ) ,),
              ),
            ):StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore.collection('Messages').doc(auth.currentUser!.uid).
                collection(((auth.currentUser!.uid)+widget.uid)).orderBy('createdon', descending: false).snapshots() ,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData || snapshot.hasError)
                  {
                    return Text('');
                  }
                  else
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new ListView
                        (
                        //  controller: _controller,
                        children: getExpenseItems(snapshot),
                      ),
                    );
                }),
          ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:80,
                width: double.infinity,
                child:Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   border: Border.all(width: 1)
                  // ),
                  child: Center(
                    child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      controller:contentTextEditorController,
                      decoration: InputDecoration(
                          hintText: "Text here..",
                          prefixIcon:
                          IconButton(
                              onPressed:()
                              {
                                setState(() {
                                  showAlertDialog(context);
                                  // contentshare=!contentshare;
                                });
                              }
                              , icon: Icon(Icons.add_to_drive,size: 30,)),

                          suffixIcon: IconButton(
                              onPressed: ()async {
                                if (contentTextEditorController.text != '') {
                                  final todoModel = TodoModel(
                                      content: contentTextEditorController.text
                                          .trim(),
                                      isDone: false,
                                      uid: widget.uid
                                  );
                                  await FirebaseDB.addTodo(
                                      todoModel, widget.uid);
                                  await FirebaseDB.updatelasttextmesage(
                                      contentTextEditorController.text.trim(),
                                      widget.uid, "msg");
                                  contentTextEditorController.clear();
                                  // Timer(Duration(milliseconds: 500), () => _controller.jumpTo(_controller.position.maxScrollExtent));
                                  // sendNotification(
                                  //     contentTextEditorController.text.trim(),
                                  //     widget.token.toString());
                                }
                              }
                                , icon: Icon(Icons.send,size: 35)
                          ) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      // controller: contentTextEditorController,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  File? imageFile;
  DateFormat df = new DateFormat('yyyy-MM-dd HH:mm:ss');
  PickedFile? pickedFile;
  // _getFromGallery() async {
  //   pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile!.path);
  //     });
  //     if(imageFile!=null)
  //     {
  //       Get.to(ImageShare(imageFile: imageFile,uid: widget.uid,idkey: "msg",));
  //     }
  //   }
  // }
  // /// Get from camera
  // _getFromCamera() async {
  //   pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = (File(pickedFile!.path));
  //     });
  //     if(imageFile!=null)
  //     {
  //       Get.to(ImageShare(imageFile: imageFile,uid: widget.uid,idkey: "msg",));
  //     }
  //   }
  // }
  showAlertDialog(BuildContext context) {
    Widget okButton = MaterialButton(
      child: Text("OK"),
      onPressed: () { },
    );
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
  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data!.docs.map((doc) =>
    doc['msgstatus']==null?Container(): doc["msgstatus"]=="send"? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(bottomRight:Radius.circular(10),
                    topLeft:Radius.circular(10) ,
                    topRight:Radius.circular(10))
            ),
            child:doc["audioMessage"]==null? doc["imageshare"]==null?doc["file"]==null?
            InkWell(
              onTap: (){
                // setState(() {
                //   // appbaritemchoose=false;
                // });
              },
              // onLongPress: (){
              //   setState(() {
              //   //   id=doc.id;
              //   //   appbaritemchoose=true;
              //   // });
              // },
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  // Slidable(
                  //   actionPane: SlidableDrawerActionPane(),
                  //  // actionExtentRatio: 0.25,
                  //   child: Container(
                  //     //   color: Colors.white,
                  //     child:
                  //     ListTile(
                  //       // leading: CircleAvatar(
                  //       //   backgroundColor: Colors.indigoAccent,
                  //       //   child: Icon(Icons.description),
                  //       //   //  foregroundColor: Colors.white,
                  //       // ),
                  //       title:  Text(doc["content"],style: TextStyle(fontSize: 18),)
                  //       //  subtitle: Text('SlidableDrawerDelegate'),
                  //     ),
                  //   ),
                  //   secondaryActions: <Widget>[
                  //     IconSlideAction(
                  //       caption: 'More',
                  //       color: Colors.black45,
                  //       icon: Icons.more_horiz,
                  //       // onTap: () => _showSnackBar('More'),
                  //     ),
                  //     IconSlideAction(
                  //       caption: 'Delete',
                  //       color: Colors.red,
                  //       icon: Icons.delete,
                  //       // onTap: () => _showSnackBar('Delete'),
                  //     ),
                  //   ],
                  // )
                  Text(doc["content"],style: TextStyle(fontSize: 18),)
              ),
            ):
            // Slidable(
            //   actionPane: SlidableDrawerActionPane(),
            //   actionExtentRatio: 0.25,
            //   child: Container(
            //     //   color: Colors.white,
            //     child: InkWell(
            //       onTap: () {
            //         Get.to(PDFScreen(path: remotePDFpath));
            //         // Get.to(PDFFILESHOW(pdflink: doc['file'],));
            //         createFileOfPdfUrl(doc['file']).then((f) {
            //           setState(() {
            //             remotePDFpath = f.path;
            //           });
            //           Timer(Duration(seconds: 3), () =>
            //               CircularProgressIndicator()
            //           );
            //
            //         });
            //       },
            //
            //       child: ListTile(
            //
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.indigoAccent,
            //           child: Icon(Icons.description),
            //           //  foregroundColor: Colors.white,
            //         ),
            //         title:  Flexible(
            //           flex: 1,
            //           child: Text(doc['content'],
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,style: new TextStyle(
            //                 fontSize: 13.0,)),
            //         ),
            //         //  subtitle: Text('SlidableDrawerDelegate'),
            //       ),
            //     ),
            //   ),
            //   actions: <Widget>[
            //     IconSlideAction(
            //       caption: 'Archive',
            //       color: Colors.blue,
            //       icon: Icons.archive,
            //       // onTap: () => _showSnackBar('Archive'),
            //     ),
            //     IconSlideAction(
            //       caption: 'Share',
            //       color: Colors.indigo,
            //       icon: Icons.share,
            //       // onTap: () => _showSnackBar('Share'),
            //     ),
            //   ],
            //   secondaryActions: <Widget>[
            //     IconSlideAction(
            //       caption: 'More',
            //       color: Colors.black45,
            //       icon: Icons.more_horiz,
            //       // onTap: () => _showSnackBar('More'),
            //     ),
            //     IconSlideAction(
            //       caption: 'Delete',
            //       color: Colors.red,
            //       icon: Icons.delete,
            //       // onTap: () => _showSnackBar('Delete'),
            //     ),
            //   ],
            // )
            Container(
              //   color: Colors.white,
              child: InkWell(
                // onLongPress: (){
                //   setState(() {
                //     id=doc.id;
                //     appbaritemchoose=true;
                //   });
                // },
                onTap: () {
                  // Get.to(PDFScreen(path: remotePDFpath));
                  // // Get.to(PDFFILESHOW(pdflink: doc['file'],));
                  // createFileOfPdfUrl(doc['file']).then((f) {
                  //   setState(() {
                  //     remotePDFpath = f.path;
                  //   });
                  //   Timer(Duration(seconds: 3), () =>
                  //       CircularProgressIndicator()
                  //   );
                  //
                  // });
                },

                child: ListTile(

                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Icon(Icons.description),
                    //  foregroundColor: Colors.white,
                  ),
                  title:  Flexible(
                    flex: 1,
                    child: Text(doc['content'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,style: new TextStyle(
                          fontSize: 13.0,)),
                  ),
                  //  subtitle: Text('SlidableDrawerDelegate'),
                ),
              ),
            ) :
            InkWell(
              // onLongPress: (){
              //   setState(() {
              //     appbaritemchoose=true;
              //     id=doc.id;
              //   });
              // },
              onTap: (){
                Get.to(PhotoShow(imageFile: doc['imageshare'],));
              },
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:  Column(
                    children: [
                      Container(
                        height: 250,
                        width: 150,
                        decoration: BoxDecoration(
                          //   color: Colors.red,
                          //borderRadius: BorderRadius.circular(120),

                            image: DecorationImage(image: NetworkImage(doc['imageshare']),fit: BoxFit.cover)
                        ),
                      ),
                      Text(doc["content"],style: TextStyle(fontSize: 18),),
                    ],
                  )
              ),
            ):
            // InkWell(
                // onLongPress: (){
                //   setState(() {
                //     id=doc.id;
                //     appbaritemchoose=true;
                //   });
                // },
                // child: AudioPlayerMessage(source:doc["audioMessage"]))),
        //     Container(
        //                 color: Colors.black12,
        //                  width: double.infinity,
        //                  height: 60,
        //                 child:
        //                 Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                children: <Widget>[
        //                 audiogetplay?  IconButton(
        //                  icon: Icon(Icons.play_arrow),
        //                 onPressed: () {
        //                setState(() {
        //               audiogetplay=!audiogetplay;
        //               audio.play(doc['audioMessage']);
        //                // print(doc["audioMessage"]) ;
        //               });
        //
        //               }):
        //                 IconButton(
        //                  icon: Icon(Icons.pause),
        //                onPressed: () {
        //                 setState(() {
        //                 audiogetplay=!audiogetplay;
        //                 audio.pause();
        //                 });
        //
        //            }),
        //         IconButton(
        //          icon: Icon(Icons.stop),
        //          onPressed: () {
        //            setState(() {
        //              audio.stop();
        //            });
        //
        //         }),
        //      //   audio.seek(position)
        //         ],
        //      ),
        //   )
        // ),
        Text("")

        ),
        Text((timeago.format(doc['createdon'].toDate()).toString()),style: TextStyle(fontSize: 11)),
      ],
    ):Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10)
            ),
            child:doc["audioMessage"]==null?doc["imageshare"]==null?doc["file"]==null?
            InkWell(
              // onLongPress: (){
              //   setState(() {
              //     id=doc.id;
              //     appbaritemchoose=true;
              //   });
              // },
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  Text(doc["content"],style: TextStyle(fontSize: 18),)
              ),
            ):
            // Slidable(
            //   actionPane: SlidableDrawerActionPane(),
            //   actionExtentRatio: 0.25,
            //   child: Container(
            //  //   color: Colors.white,
            //     child:
            //       InkWell(
            //         onTap: () {
            //           Get.to(PDFScreen(path: remotePDFpath));
            //           // Get.to(PDFFILESHOW(pdflink: doc['file'],));
            //           createFileOfPdfUrl(doc['file']).then((f) {
            //             setState(() {
            //               remotePDFpath = f.path;
            //             });
            //             Timer(Duration(seconds: 3), () =>
            //                 CircularProgressIndicator()
            //             );
            //
            //           });
            //         },
            //
            //       child: ListTile(
            //
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.indigoAccent,
            //           child: Icon(Icons.description),
            //         //  foregroundColor: Colors.white,
            //         ),
            //         title:  Flexible(
            //           flex: 1,
            //           child: Text(doc['content'],
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,style: new TextStyle(
            //                 fontSize: 13.0,)),
            //         ),
            //       //  subtitle: Text('SlidableDrawerDelegate'),
            //       ),
            //     ),
            //   ),
            //   actions: <Widget>[
            //     IconSlideAction(
            //       caption: 'Archive',
            //       color: Colors.blue,
            //       icon: Icons.archive,
            //       // onTap: () => _showSnackBar('Archive'),
            //     ),
            //     IconSlideAction(
            //       caption: 'Share',
            //       color: Colors.indigo,
            //       icon: Icons.share,
            //       // onTap: () => _showSnackBar('Share'),
            //     ),
            //   ],
            //   secondaryActions: <Widget>[
            //     IconSlideAction(
            //       caption: 'More',
            //       color: Colors.black45,
            //       icon: Icons.more_horiz,
            //       // onTap: () => _showSnackBar('More'),
            //     ),
            //     IconSlideAction(
            //       caption: 'Delete',
            //       color: Colors.red,
            //       icon: Icons.delete,
            //       // onTap: () => _showSnackBar('Delete'),
            //     ),
            //   ],
            // )
            Container(
              //   color: Colors.white,
              child:
              InkWell(
                // onLongPress: (){
                //   setState(() {
                //     id=doc.id;
                //     appbaritemchoose=true;
                //   });
                // },
                onTap: () {
                  // Get.to(PDFScreen(path: remotePDFpath));
                  // // Get.to(PDFFILESHOW(pdflink: doc['file'],));
                  // createFileOfPdfUrl(doc['file']).then((f) {
                  //   setState(() {
                  //     remotePDFpath = f.path;
                  //   });
                  //   Timer(Duration(seconds: 3), () =>
                  //       CircularProgressIndicator()
                  //   );
                  //
                  // });
                },

                child: ListTile(

                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Icon(Icons.description),
                    //  foregroundColor: Colors.white,
                  ),
                  title:  Flexible(
                    flex: 1,
                    child: Text(doc['content'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,style: new TextStyle(
                          fontSize: 13.0,)),
                  ),
                  //  subtitle: Text('SlidableDrawerDelegate'),
                ),
              ),
            )
                :
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InkWell(
                      // onLongPress: (){
                      //   setState(() {
                      //     id=doc.id;
                      //     appbaritemchoose=true;
                      //   });
                      // },
                      onTap: (){
                        Get.to(PhotoShow(imageFile: doc['imageshare'],));
                      },
                      child: Container(
                        height: 250,
                        width: 150,
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(120),
                            image: DecorationImage(image: NetworkImage(doc["imageshare"]),fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    Text(doc["content"],style: TextStyle(fontSize: 18),)
                  ],
                )
            ):
            // InkWell(
                // onLongPress: (){
                //   setState(() {
                //     id=doc.id;
                //     appbaritemchoose=true;
                //   });
                // },
                // child: AudioPlayerMessage(source: doc["audioMessage"]))
          // Container(
          //   color: Colors.black12,
          //   width: double.infinity,
          //   height: 40,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       audiogetplay?  IconButton(
          //   icon: Icon(Icons.pause),
          //     onPressed: () {
          //       setState(() {
          //        duration=doc['audiotime'];
          //         audiogetplay=!audiogetplay;
          //         audio.pause();
          //       });
          //     }):IconButton(
          //           icon: Icon(Icons.play_arrow),
          //           onPressed: () {
          //             setState(() {
          //               audiogetplay=!audiogetplay;
          //               audio.play(doc['audioMessage']);
          //               _duration=doc['audiotime'];
          //             });
          //           }),
          //          Slider(
          //          onChanged: (double value) {
          //          setState(() {
          //          audio.seek(Duration(seconds: value.toInt()));
          //          audio.onDurationChanged.listen((Duration d) {
          //            print('Max duration: $d');
          //            setState(() => _duration = d);
          //          });
          //          });
          //          },
          //          min: 0.0,
          //          max: _duration.inSeconds.toDouble(),
          //          value:0,
          //          ),
          //       Text(doc['audiotime'])
          //     ],
          //   ),
          // )
          Text("")
        ),
        Text((timeago.format(doc['createdon'].toDate()).toString()),style: TextStyle(fontSize: 11)),
        SizedBox(height: 20,),
      ],
    )
      // new ListTile(
      //   tileColor: doc["msgstatus"]=="send"?Colors.white:Colors.indigo,
      //     leading: CircleAvatar(
      //       radius: 18,
      //       backgroundImage: NetworkImage(url),
      //     ),
      //   //  title: new Text(doc["content"]),
      //     subtitle:new Text(doc["content"].toString()))
    ).toList();

  }
}
