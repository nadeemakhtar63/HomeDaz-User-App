import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:home_daz/Booking/BookingScreen.dart';
import 'package:home_daz/constant.dart';

class SubServices extends StatefulWidget {
  final idkey;
  const SubServices({Key? key,this.idkey}) : super(key: key);
  @override
  State<SubServices> createState() => _SubServicesState();
}
class _SubServicesState extends State<SubServices> {
  bool itemselected=false;
  List imagesicons=[];
  List filteredNames =[];
  List _foundUsers=[];
  void _runChipSearch(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = allResults;
    } else {
      results = allResults
          .where((user) =>
          user['tages'].contains(enteredKeyword.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
    if(_foundUsers.isNotEmpty)
    {
      // searchkeywords.add(enteredKeyword);
      //  storeseachkeyword(enteredKeyword);
    }
  }
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = allResults;
    } else {
      results = allResults
          .where((user) =>
          user['title'].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
    if(_foundUsers.isNotEmpty)
    {
      searchkeywords.add(enteredKeyword);
      // storeseachkeyword(enteredKeyword);
    }
  }
  List allResults=[];
  List searchkeywords=[];
  getuserpaststeamsnapshot()async{
    firebaseFirestore.collection('subservices').where('mainservice',isEqualTo: widget.idkey).get().then((value)  {
      setState(() {
        allResults=value.docs;
        _foundUsers = allResults;
      });
      // print(value.docs[0]["heading"]);
    });
  }
  List albums=[
    "assets/homefirstimage.png",
    "assets/homefirstimage.png"
  ];
  List Catgory=[
    "assets/door.png",
    "assets/nature.png",
    "assets/shower.png",
    "assets/snow.png",
    "assets/tiles.png",
    "assets/window.png",
    "assets/constratcion.png",
    "assets/electrician.png",
    "assets/gardening.png",
    "assets/home.png",
  ];

  List CatogoriesColor=
  [
    0xffFFD2A7,
    0xff98C4FF,
    0xffFFD2A7,
    0xff98C4F,
    0xffFFD2A,
    0xff98C4FF,
    0xffFFD2A7,
    0xff98C4F,
    0xffFFD2A7,
    0xff98C4FF,
    0xffFFD2A7,
    0xff98C4FF
  ];
  List CatogoryNameList=
  [
    "GARDENING\nSERVICES",
    "HOME\nREMODELING",
    "WINDOW\nINSTALLATION",
    "FURNITURE\nREPAIR",
    "HOME\nREMODELING",
    "ELECTRITION\nSERIVCES",
    "SHOWER\nREPAIR",
    "ROOFING\nDESIGN",
    "STAIR/RAILING\nSERVICES",
    "SNOW REMOVAL\nPLOW / SHOVEL",
    "TILE/GROUT\nSERVICES",
    "TREE SERVICES/\nARBORIST"
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  TextEditingController searchController=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserpaststeamsnapshot();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffD9EBF6),
        title: Text("Home Service"),
        actions: [
          Icon(Icons.notification_add,color: Colors.blue,)
        ],
      ),
    body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  color: Color(0xffD9EBF6),
                  child: CarouselSlider(
                    items: _foundUsers
                        .map((item) =>
                        Container(
                          // color: Get.theme.cardColor,
                          width: MediaQuery.of(context).size.width,
                          height:  MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(40)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                              fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                                image: NetworkImage(_foundUsers[_current]["image"])
                              )
                            ),
                            // color: Color(0xff00ffcc),
                            // elevation: 0,
                            // child: Stack(
                            //   children: [
                            //     // Padding(
                            //     //   padding: EdgeInsets.only(top: 20),
                            //     //   child: Positioned(
                            //     //     left: 10,
                            //     //     child: Container(
                            //     //         child: Text("GARDENING SERVICES")
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //     // Positioned(
                            //     //   top: 40,
                            //     //   left: 10,
                            //     //   child: Container(
                            //     //
                            //     //       child: Text("Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Ut eget\n felis pharetra, bibendum eros eu")
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //     color: Colors.blue,
                            //     //     child: Text("data is very")),
                            //     Align(
                            //         alignment: Alignment.centerRight,
                            //         child: Image.network(_foundUsers[_current]["image"],)),
                            //   ],
                            // ),
                          ),
                        ),
                    )
                        .toList(),
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,

                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        //  onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  )

              ),
            ),

            Container(
              child: _foundUsers.isNotEmpty
              ?
              GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              ),
              itemCount: _foundUsers.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: (){
                    Get.to(
                        Booking(image: _foundUsers[index]["image"],
                        servicename:  _foundUsers[index]['name'],
                        shortDes: _foundUsers[index]['shortDes'],
                        reviwes: _foundUsers[index]['reviews'],
                        mainservicename: _foundUsers[index]['mainservice'],
                        howitwork: _foundUsers[index]['Howitworks'],
                        serviceCharges: _foundUsers[index]["service_charges"],
                        serviceRequirDuration:_foundUsers[index]["repair_time_requir"] ,
                      extraTex: _foundUsers[index]["tax"],
                    ));
                        // Booking(_foundUsers[index]["image"], _foundUsers[index]['name'],_foundUsers[index]['shortDes'],
                        // _foundUsers[index]['mainservice'],_foundUsers[index]['Howitworks'],_foundUsers[index]['reviews']));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(image: NetworkImage(_foundUsers[index]["image"],),fit: BoxFit.cover)
                          ),

                        ),
                        Container(
                          // height: 95,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_foundUsers[index]["name"],style: TextStyle(fontWeight: FontWeight.w900),),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: RatingBarIndicator(
                                  rating: _foundUsers[index]['reviews'],
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(" Start From",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700),),
                                  Text(_foundUsers[index]["service_charges"].toString())
                                ],
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );

              }

              ):Text(""),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
