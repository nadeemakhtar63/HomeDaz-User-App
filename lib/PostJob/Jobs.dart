import 'package:flutter/material.dart';

class JobsPosts extends StatefulWidget {
  const JobsPosts({super.key});

  @override
  State<JobsPosts> createState() => _JobsPostsState();
}
bool jobselectionhor=true;
bool jobselectioncontract=false;
class _JobsPostsState extends State<JobsPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent ,
        foregroundColor: Color(0xffFF7D00),
        elevation: 0.0,
      ),
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  jobselectionhor=true;
                  jobselectioncontract=false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.48,
                height: 45,
                decoration: BoxDecoration(
                  color: jobselectionhor?Color(0xffFF7D00):Colors.grey,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text("Contractor Posts"),),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  jobselectionhor=false;
                  jobselectioncontract=true;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.48,
                height: 45,
                decoration: BoxDecoration(
                    color: jobselectioncontract?Color(0xffFF7D00):Colors.grey,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text("My Jobs"),),
              ),
            ),
          ],
        )
      ],
    ),
    );
  }
}
