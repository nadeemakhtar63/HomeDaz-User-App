import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_daz/Order_Progress/AcceptedOrders.dart';
import 'package:home_daz/Order_Progress/CancelOrder.dart';
import 'package:home_daz/Order_Progress/CompletedOrder.dart';
import 'package:home_daz/Order_Progress/OrderInProgress.dart';
import 'package:home_daz/TabScreens/Orders_Details.dart';

import '../AuthenticationScreens/LogIn.dart';
import '../constant.dart';
import 'OrderProgreeComplere.dart';

class OrderTabs extends StatefulWidget {
  const OrderTabs({Key? key}) : super(key: key);

  @override
  State<OrderTabs> createState() => _OrderTabksState();
}

class _OrderTabksState extends State<OrderTabs> with SingleTickerProviderStateMixin{
  late final _tabController = TabController(length: 4, vsync:this);

  @override
  Widget build(BuildContext context) =>DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
  backgroundColor: Colors.orange,
      title:Text("Order Screen")  ,
       centerTitle: true,
       bottom: TabBar(
         controller: _tabController,
             tabs: [
            Tab(icon:Icon(Icons.work_outline_sharp),text: 'Requests',),
            Tab(icon:Icon(Icons.workspaces_outlined),text: 'Progress',),
            Tab(icon:Icon(Icons.workspace_premium_outlined),text: 'Completed',),
            Tab(icon:Icon(Icons.workspace_premium_outlined),text: 'Cancel',),
          ],
        ),

      ),
        body:auth.currentUser!.isAnonymous?
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
        ): TabBarView(
          controller: _tabController,
      children: [
        OrderDetails(),
        OrderInProggress(),
        CompletedOrder(),
        CancelOrder(),
          ],
        ),
      )
  );
}
