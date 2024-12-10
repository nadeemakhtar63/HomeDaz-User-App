import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:home_daz/FirebaseCRUD/FirbaseDB.dart';
import 'package:home_daz/Order_Progress/OrdersTabLayout.dart';
import 'package:home_daz/TabScreens/TabLayout.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../constant.dart';
class ConfirmBooking extends StatefulWidget {
  final servicepi,adres,datepic,morning,evening,afternon,timing_about_des,
      which_service_want,serviceName,servicesnum,images,scharges,stax,sduration,contractorId;
  const ConfirmBooking({Key? key,required this.servicepi, required this.adres,required this.afternon,
    required this.datepic,required this.evening,required this.morning,required this.contractorId,
    required this.timing_about_des,required this.which_service_want,this.serviceName,
    required this.servicesnum,required this.images,@required this.scharges,@required this.sduration,
    @required this.stax
  }) : super(key: key);
  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}
class _ConfirmBookingState extends State<ConfirmBooking> {
  List <File> fileImageArray = [];
  List  allTokenList = [];
  List _adminTokenList=[];
  List offersends=[];
  // List offersends=[];
// convertimagetofile()async {
//
//   widget.images.forEach((imageAsset) async {
//     if(imageAsset!="")
//       {
//         fileImageArray.forEach((imageAsset) async {
//           final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
//
//           File tempFile = File(filePath);
//         fileImageArray.add(file);
//       }
//   });
//   print(fileImageArray);
// }
//   Future<File?> getFile() async {
//     List<Asset> images = await MultiImagePicker.pickImages(maxImages: 100);
//
//     if (images.isNotEmpty) {
//       ByteData bytesData = await images.first.getByteData();
//       List<int> bytes = bytesData.buffer
//           .asUint8List(bytesData.offsetInBytes, bytesData.lengthInBytes)
//           .cast<int>();
//
//       //get the extension jpeg, png, jpg
//       String extension = (images.first.name ?? '').split('.').last;
//
//       //get path to the temporaryDirector
//       final Directory directory = await getTemporaryDirectory();
//
//       //get the path to the chosen directory
//       String directoryPath = directory.path;
//
//       //create a temporary file to the specified path
//       //you can use the path to this file for the API
//       File file = File('$directoryPath/myImage.$extension');
//
//       //write the bytes to the image
//       file.writeAsBytesSync(bytes, mode: FileMode.write);
//
//       //just for path: file.path -> will return a String with the path
//       return file;
//     }
//     return null;
//   }
 late String Tokenvalue;
  getuserpaststeamsnapshot()async{
    String tokenvalue;
    firebaseFirestore.collection('serviceprovider').get().then((value){
    value.docs.forEach((element) {
     if(element.data()['token']!=" "){
       // tokenvalue=element.data()['token'];
       allTokenList.add(element.data()['token']);
       print("pppppppppppppppp${allTokenList}");
     }
    });
    });
  }
  getAdminId()async{
    await firebaseFirestore.collection("adminuser").get().then((value)  {
    value.docs.forEach((element) {
      setState(() {
        _adminTokenList.add(element.data()['token']);
      });

    });
    print('all tokens: ${Tokenvalue}');
    });
  }
initState()
{
  getAdminId();
  getuserpaststeamsnapshot();
  // convertimagetofile();
  super.initState();
}
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
             padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    widget.images.isEmpty?Container():Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      child: ListView(
                        // crossAxisCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(widget.images.length, (index) {
                          File asset = widget.images[index];
                          return Image.file(asset,height: 80);
                          //   AssetThumb(
                          //   asset: asset,
                          //   width: 300,
                          //   height: 300,
                          // );
                        }),
                      ),
                    ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Booking At :",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                          widget.datepic==""?Text("As Soon as Possible",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.orange),): Row(
                            children: [
                              Text('${widget.morning} ${widget.afternon} ${widget.evening}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),

                              Text('  ${widget.datepic}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Address",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                              SizedBox(height: 10,),
                              Text(widget.adres),
                            ],
                          ),
                        ),
                      ),
                    ),
                Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Timing about description",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                              SizedBox(height: 10,),
                              Text(widget.timing_about_des),
                            ],
                          ),
                        ),
                      ),
                    ),
                Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("About Work Description",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                              SizedBox(height: 10,),
                              Text(widget.which_service_want),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
       Expanded(
            flex: 4,
            child:   _isLoading?Container(
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 6,
                  ),
                ),
              ),
            ): Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20) )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(""),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service Charges",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                              Text('${widget.servicesnum*widget.scharges}.0\$'),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tex Charges",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                              Text('${widget.stax}.0\$'),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Services Quantity",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                              Text('${widget.servicesnum}.0\$'),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                              Text('${widget.servicesnum*widget.scharges+widget.stax}.0\$'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: ()async{
                        setState(() {
                          _isLoading=true;
                        });
                        allTokenList.forEach((element) {
                          home_dazhNotification(element, 'New Project Requested', " New Order Placed");
                        });
                        _adminTokenList.forEach((token) {
                          sendPushNotification(token, 'New Project Requested', "Order Placed");
                        });

                        FirebaseDB b=new FirebaseDB();
                        // if(widget.images!=null)
                        //   {
                         b.Bookservice(
                           contractorId: widget.contractorId,
                              adres:widget.adres,
                              datepic: widget.datepic,
                              morning: widget.morning,
                              evening: widget.evening,
                              afternon: widget.afternon,
                              timing_about_des: widget.timing_about_des,
                              which_service_want: widget.which_service_want,
                              serviceName: widget.serviceName,
                              servicesnum: widget.servicesnum,
                              images: widget.images,
                              scharges: widget.scharges,
                              stax: widget.stax,
                              sduration: widget.sduration,
                              seviceimage: widget.servicepi
                            ).then((value) => {
                         print('print is $value'),
                             if(value=="sucess"){
                               _displayDialog(context),
                          setState(() {
                            _isLoading=false;
                          }),
                          // print('images file send${fileImageArray}');
                        }
                         });

                      },
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            color: Colors.orange,
                          ),
                          width: MediaQuery.of(context).size.width*0.8,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Confirm & Booking Now",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w900),),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  _displayDialog(BuildContext context) async {
    return showDialog(

      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Order Submitted',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Order Submitted Sucessfully,admin can responce to your order soon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'please check details of order in order modules home page',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )

                ],
              ),
            ),
            actions: <Widget>[
              new MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blueAccent,
                child: new Text('Back to OrderPage',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                onPressed: () async{
                  try
                  {
                    // Get.to(()=>OrderTabs());
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder:(context)=>OrderTabs()));
                    // Navigator.of(context).pop();
                  }
                  catch(firebaseAuthException)
                  {
                    Get.snackbar("Alert".tr, "$firebaseAuthException");
                  }
                },
              ),
              new MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blueAccent,
                child: new Text('Back to HomePage',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                onPressed: () async{
                  try
                  {
                    // Get.to(()=>TabLayouts());
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder:(context)=>TabLayouts()));
                  }
                  catch(firebaseAuthException)
                  {
                    Get.snackbar("Alert".tr, "$firebaseAuthException");
                  }
                },
              ),
            ],
          );
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
          'Authorization': 'key=AAAACy03Od8:APA91bGi65Db_-qhWnFVAIC1mXFwHe3QKDQPjz5L3_Ee3F5QQ0jYQlNk83E340CMn0tcaNH-UOO6YzZcRpa2jd8QT-Z2bMyipw9thj_Ii43RZeCdRgq9KLVfylmgJKzHMsaAkAchRun3'
        },
        body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title
              },
              "notification":<String,dynamic>{
                "title":title,
                "body":body,
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
