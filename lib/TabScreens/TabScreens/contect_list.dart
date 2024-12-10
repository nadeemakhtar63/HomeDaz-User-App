
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constant.dart';
import 'ChatScreen.dart';
class ContectList extends StatefulWidget {
  // final String? token;
  const ContectList({Key? key}) : super(key: key);

  @override
  State<ContectList> createState() => _ContectListState();
}

class _ContectListState extends State<ContectList> {
List alldata=[];
  uerid(){
    firebaseFirestore.collection('Messages').where(auth.currentUser!.uid).get().then((value){
       alldata=value.docs;
        print('values of messages id: ${ alldata}');
    });
  }
  initState(){
    super.initState();
    uerid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w900,fontSize: 20,),),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("user").where("").snapshots(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if (!snapshot.hasData)
              return new Text("There is No User");
            return new ListView(
                children: getExpenseItems(snapshot)
            );
          }
      )
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) =>
    doc["uid"]!=auth.currentUser!.uid? InkWell(
      onTap: (){
        Get.to(
            ChatScreen(
            // token:token,
            uname: doc["username"],
            statues: doc["statues"],
            url: doc["url"],
            uid:doc["uid"])
        );
      },
      child: Container(
        child: new ListTile(
            contentPadding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: CircleAvatar(radius: 18, backgroundImage: NetworkImage(doc["url"],),),
            title: new Text(doc["username"]),
            subtitle: new Text(doc["lastmesg"].toString())),
      ),
    ):Text("")
    ).toList();
  }
}
