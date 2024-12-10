
import 'package:flutter/material.dart';

import '../PostJob/OrderRequest.dart';
import 'My_Job_Post.dart';

class JobTab extends StatefulWidget {
  const JobTab({super.key});

  @override
  State<JobTab> createState() => _JobTabState();
}

class _JobTabState extends State<JobTab> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Jobs Post\'s'),
            bottom: TabBar(

              tabs: [
                Tab(icon: Icon(Icons.work), text:"Jobs Offered" ),
                Tab(icon: Icon(Icons.post_add), text: "My Post\'s")
              ],
            ),
          ),
          body: TabBarView(
            children: [
             Job_Posetd(),
             OrderRequest(),

            ],
          ),
        ),
      ),
    );
  }
}
