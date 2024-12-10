import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_daz/JobsTabs/JobTab.dart';
import 'package:home_daz/Order_Progress/OrdersTabLayout.dart';
import 'package:home_daz/PostJob/Jobs.dart';
import 'package:home_daz/PostJob/Post_New_Job.dart';
import 'package:home_daz/TabScreens/HomeScreen.dart';
import 'package:home_daz/TabScreens/Orders_Details.dart';
import 'package:home_daz/TabScreens/TabScreens/ChatScreen.dart';
import 'package:home_daz/TabScreens/TabScreens/Experts.dart';
import 'package:home_daz/TabScreens/TabScreens/Profile.dart';
import 'package:home_daz/TabScreens/TabScreens/contect_list.dart';

import '../JobsTabs/My_Job_Post.dart';


class TabLayouts extends StatefulWidget {
  final gamename,gImage;
  const TabLayouts({Key? key,this.gamename,this.gImage}) : super(key: key);

  @override
  State<TabLayouts> createState() => _HomeNavState();
}
class _HomeNavState extends State<TabLayouts> {
  static  List<Widget> _widgetOptions = <Widget>[
    Experts(),
    OrderTabs(),
    HomeScreen(),
   // JobsPosts(),
   //  JobTab(),
    Job_Posetd(),
    Profile(),
  ];
  int _selectedIndex = 2;
  bool isAdmin = true;

  void showConfirmDialog(BuildContext context, String errorMessage) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorLight,
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text(
                'Accept',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                exit(0);
              },
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: WillPopScope(
        onWillPop: ()async{
          showConfirmDialog(context, 'Close the app?');
          return false;
        },
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar:
        ConvexAppBar(
          items: [
            TabItem(icon: Icons.settings_outlined, title: 'Expert\'s'),
            TabItem(icon: Icons.map, title: 'Bookings'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.task_alt, title: 'Jobs'),
            TabItem(icon: Icons.people, title: 'Profile',),
          ],
          backgroundColor: Color(0xffFF7D00),
          elevation: 1,
          shadowColor: Colors.white,

          initialActiveIndex:_selectedIndex,
          onTap: (int i) => {
          setState(() {
          _selectedIndex = i;
          })
          },
        )
      );
        // BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //       // backgroundColor: Color(0xffFFFFFF),
        //       icon:Icon(Icons.home_outlined,color:Color(0xffFF7D00),),
        //       label: 'HOME',
        //
        //     ),
        //     BottomNavigationBarItem(
        //       icon:Icon(Icons.article,color: Color(0xffFF7D00),),
        //       label:'Ranking',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.chat,color: Color(0xffFF7D00),),
        //       label:'Loadouts',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person,color: Color(0xffFF7D00),),
        //       label:'News',
        //     ),
        //   ],
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: _selectedIndex,
        //
        //   // backgroundColor: Colors.red,
        //   selectedItemColor: Colors.indigo,
        //   iconSize: 20,
        //   onTap: _onItemTapped,
        //   elevation: 5,
        //   unselectedItemColor: Colors.blueGrey,
        // ),
   //   );
  }
}
// class Style extends StyleHook {
//   @override
//   double get activeIconSize => 40;
//
//   @override
//   double get activeIconMargin => 10;
//
//   @override
//   double get iconSize => 20;
//   @override
//   TextStyle textStyle(Color color) {
//     return TextStyle(fontSize: 20, color: color);
//   }
// }
