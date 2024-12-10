import 'dart:io';
import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_daz/Booking/ConfirmBooking.dart';
import 'package:home_daz/GoogleMap/googleMap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Booking_Details extends StatefulWidget {
  final servicename,seviceCharges,ServiceText,serviceDuration,serviceImage,contractorId;
  const Booking_Details({Key? key,@required this.servicename,@required this.seviceCharges,@required this.contractorId,
    @required this.serviceDuration,@required this.ServiceText,@required this.serviceImage}) : super(key: key);

  @override
  State<Booking_Details> createState() => _Booking_DetailsState();
}

class _Booking_DetailsState extends State<Booking_Details> {
  TextEditingController AdressInputController = TextEditingController();
  TextEditingController timingConstraintInputController = TextEditingController();
  TextEditingController TimePickercontroller = TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController whatneedInputController=TextEditingController();
  bool adresvalidate=false,datvalidate=false,timevalidate=false,timdesvalide=false,whyneedvalidate=false;
  int _counter=1;
  bool selecttimeframe=false;
  String chooseMorning="";
  String chooseAfterNoon="";
  String choosEvening="";
  bool bolmoringchoose=false,bolafternoonchose=false,bolevengchose=false;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _DecrementCounter() {
      if(_counter>0)
          {
          setState(() {
            _counter--;
          });
    }
  }
  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
  // Future<bool> checkAndRequestCameraPermissions() async {
  //   PermissionStatus permission =
  //   await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
  //   if (permission != PermissionStatus.granted) {
  //     Map<PermissionGroup, PermissionStatus> permissions =
  //     await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  //     return permissions[PermissionGroup.camera] == PermissionStatus.granted;
  //   } else {
  //     return true;
  //   }
  // }
   List<File> imaging=[] ;
  List<File> fileimages=[] ;
  // Future<void> pickImages() async {
  //   List<Asset> resultList = [];
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       materialOptions: MaterialOptions(
  //         actionBarTitle: "HOMEDAZ",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  //   setState(() {
  //     images = resultList;
  //   });

  // }
  Future<File?> getFile() async {
    imaging.clear();
    List<Asset> images = await MultiImagePicker.pickImages(maxImages: 100);
    if (images.isNotEmpty) {
      images.forEach((element)async {
        ByteData bytesData = await element.getByteData();
        List<int> bytes = bytesData.buffer.asUint8List(
            bytesData.offsetInBytes, bytesData.lengthInBytes).cast<int>();
        //get the extension jpeg, png, jpg
        String extension = (element.name ?? '');
        //get path to the temporaryDirector
        final Directory directory = await getTemporaryDirectory();

        //get the path to the chosen directory
        String directoryPath = directory.path;

        //create a temporary file to the specified path
        //you can use the path to this file for the API
        File file = File('$directoryPath/myImage.$extension');

        //write the bytes to the image
        file.writeAsBytesSync(bytes, mode: FileMode.write);
       setState(() {
         fileimages.add(file);
       });


        print('images print: $imaging');
      });
      setState(() {
        imaging = fileimages;
      });//just for path: file.path -> will return a String with the path
      // return file;
    }
    // return null;
  }
  File? file;
  bool datechoseornot=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title:Center(child: Text(widget.servicename,style: TextStyle(color: Colors.black38,fontSize: 20,fontWeight: FontWeight.w700),)),
      leading: IconButton(
          icon:Icon(Icons.arrow_back_ios_new,color: Colors.black38),
          onPressed: () {
            Navigator.pop(context);
          },)
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  IconButton(onPressed: getFile,
                      icon: Icon(Icons.linked_camera_rounded,size: 30,color: Colors.orange,)),
                      Text("Upload Photos (Optional)",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),)
                    ],
                  ),
                 Container(
                   height: 100,
                   child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                     itemCount: imaging.length,
                       itemBuilder: (context,item) {
                     return Image.file(imaging[item],height: 100,width:120,);
                   }
                   ),
                 ),
                  // Text(widget.servicename,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: AdressInputController,
                          keyboardType: TextInputType.multiline,

                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            errorText: adresvalidate?"*Required Working Address":null,
                            hintText: 'e.g. city address,streat address,house no',
                            // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                            hintStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(()=>MapSample());
                    },
                    child: Card(
                      elevation: 0,
                      child: Container(
                        width: 140,
                        // padding: EdgeInsets.all(15),

                       child: Row(
                         children: [
                           Icon(Icons.add_location,size: 20,color: Colors.orange,),
                           Text("Select Location"),
                         ],
                       )
                      ),
                    ),
                  ),
                  CheckboxListTile(
                      title: Text("I need Work on Selected date or Company Prefered?? "),
                      value:datechoseornot ,
                      onChanged:(vale){
                        setState(() {
                          datechoseornot=vale!;
                        });

                  }),
              datechoseornot?  Card(
                    elevation: 5,
                    child: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              child: TextField(
                                controller: dateController,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  errorText: datvalidate?"select Date":null,
                                    icon: Icon(Icons.calendar_today), //icon of text field
                                    labelText: "Enter Date" //label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('yMMMMd').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    bolmoringchoose=!bolmoringchoose;
                                    // bolevengchose=false;
                                    // bolafternoonchose=false;

                                  });
                                  if(bolmoringchoose==true) {
                                    setState(() {
                                      chooseMorning = "Morning";
                                    });
                                  }
                                  else if(bolmoringchoose==false) {
                                    setState(() {
                                      chooseMorning="";
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*.20,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: bolmoringchoose?Colors.orange:Colors.white),
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  child: Center(child: Text("Morning",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,)),),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    bolafternoonchose=!bolafternoonchose;
                                    // bolmoringchoose=false;
                                    // bolevengchose=false;
                                  });
                                  if(bolafternoonchose==true) {
                                    setState(() {
                                      chooseAfterNoon = "Afternoon";
                                    });
                                  }
                                  else if(bolafternoonchose==false) {
                                    setState(() {
                                      chooseAfterNoon="";
                                    });
                                  }

                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*.20,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: bolafternoonchose?Colors.orange:Colors.white),
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  child: Center(child: Text("Afternoon",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,)),),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    bolevengchose=!bolevengchose;
                                    // bolmoringchoose=false;
                                    // bolafternoonchose=false;
                                  });
                                  if(bolevengchose==true) {
                                    setState(() {
                                      choosEvening = "Evening";
                                    });
                                  }
                                  else if(bolevengchose==false) {
                                    setState(() {
                                      choosEvening="";
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width*.20,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: bolevengchose?Colors.orange:Colors.white),
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  child: Center(child: Text("Evening",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,)),),
                                ),
                              )
                            ],
                          )
                          ],
                        ))
                  ):Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("As Soon as Possible",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.blue),),
                  ),

                  Text("  Timing constraints",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.17,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: timingConstraintInputController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            errorText: timdesvalide?"please write down busy time":null,
                            hintText: 'e.g Baby is napping from 3-4pm .Please do not arrive during those times.',
                            // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                            hintStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text("  What do you need done?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.17,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: whatneedInputController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 4,
                          decoration:InputDecoration(
                            errorText: whyneedvalidate?"please describe what service you gain":null,
                            hintText: 'e.g. something that needs to be fixed ,install,clean',
                            // prefixIcon: Icon(Icons.message_outlined, color: Colors.blue,),
                            hintStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          // Expanded(
          //     flex: 1,
          //     child: Container(
          //       color: Colors.white,
          //     ))
          Card(
            elevation: 5,
            child: Container(
              height: 70,
              width: double.infinity,
              color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: 50,
                    color: Colors.deepOrange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              _DecrementCounter();
                            });
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: Colors.orange,
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Center(child: Text("-",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white),)),
                            ),
                          ),
                        ),
                        Text("$_counter",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.white),),
                        Card(
                          elevation: 5,
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                _incrementCounter();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Center(child: const Text("+",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                   elevation: 5,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      onTap: (){
                        if(datechoseornot==false)
                          {
                            if(AdressInputController.text.isEmpty||timingConstraintInputController.text.isEmpty
                               ||whatneedInputController.text.isEmpty)
                              {
                                setState(() {
                                  AdressInputController.text.isEmpty?adresvalidate=true:adresvalidate=false;
                                  timingConstraintInputController.text.isEmpty?timdesvalide=true:timevalidate=false;
                                  whatneedInputController.text.isEmpty?whyneedvalidate=true:whyneedvalidate=false;
                                });
                              }
                            else
                              {
                                Get.to(()=>ConfirmBooking(
                                  servicepi: widget.serviceImage,
                                  contractorId: widget.contractorId,
                                  adres: AdressInputController.text,
                                  afternon:"",
                                  datepic:"",
                                  evening:"", morning:"",timing_about_des: timingConstraintInputController.text,
                                  which_service_want: whatneedInputController.text,serviceName: widget.servicename,
                                  servicesnum: _counter,images: imaging, scharges:widget.seviceCharges,
                                  stax: widget.ServiceText,
                                  sduration: widget.serviceDuration,));
                              }
                          }
                        else{
                              if(AdressInputController.text.isEmpty||timingConstraintInputController.text.isEmpty||
                                  whatneedInputController.text.isEmpty||dateController.text.isEmpty)
                              {
                                setState(() {
                                  AdressInputController.text.isEmpty?adresvalidate=true:adresvalidate=false;
                                  timingConstraintInputController.text.isEmpty?timdesvalide=true:timevalidate=false;
                                  whatneedInputController.text.isEmpty?whyneedvalidate=true:whyneedvalidate=false;
                                  dateController.text.isEmpty?datechoseornot=true:datechoseornot=false;
                                });
                               }
                              // else if(chooseMorning=="" || choosEvening=="" || chooseAfterNoon=="")
                              // {
                              // Get.snackbar("Pick Frame", "Pick Frame one or More");
                              // }
                              else
                              {
                              Get.to(()=>ConfirmBooking(
                                contractorId: widget.contractorId,
                                servicepi:widget.serviceImage,adres: AdressInputController.text, afternon: chooseAfterNoon,
                                  datepic: dateController.text, evening: choosEvening, morning: chooseMorning
                                  ,timing_about_des: timingConstraintInputController.text,
                                  which_service_want: whatneedInputController.text,
                              serviceName: widget.servicename,servicesnum: _counter,
                                images: imaging,
                                scharges:widget.seviceCharges,
                                stax: widget.ServiceText,
                                sduration: widget.serviceDuration,
                              ));
                              }
                              }
                          },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.4,
                          height: 50,
                        child: Center(
                          child: Text("Book This Service",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
          )
        ],
      ),
    );
  }
}
