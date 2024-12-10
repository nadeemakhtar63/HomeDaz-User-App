import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_daz/AuthenticationScreens/NewAccount.dart';
import 'package:home_daz/Controller/AuthController.dart';
import 'package:home_daz/Widgets/CustomButton.dart';
import 'package:home_daz/Widgets/TextFields.dart';
import 'package:home_daz/constant.dart';

class ForgetPassword extends StatefulWidget {
  // const LogIn({Key? key}) : super(key: key);
  @override
  State<ForgetPassword> createState() => _LogInState();
}
class _LogInState extends State<ForgetPassword> {
  TextEditingController emailcontroller=new TextEditingController();
  // TextEditingController passwordController=new TextEditingController();
  bool emailvalidater=false;
  @override
  void initState() {
    // TODO: implement initState
    Get.put(AuthController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0.0,),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height*0.2,
                child: Center(child: Image(image: AssetImage("assets/logo.png"),)),
              ),
              SizedBox(height: 20,),
              Text("HOME SERVICES",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xffFF7D00)),),
              SizedBox(height: 10,),
              Text("WELCOME TO BEST SERVICE PROVIDER SYSTEM",style: TextStyle(fontSize:10 ,fontWeight:FontWeight.w500 ,color: Color(0xffADADAD )),),
              SizedBox(height: 20,),
              Text("Forget Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              CustomTextFields(
                  emailcontroller,
                  emailvalidater,
                  "ENTER EMAIL ADDRESS",
                  TextInputType.emailAddress,
                  false,
                  Icon(Icons.email_outlined,color: Colors.blue,)
              ),
              SizedBox(height: 10,),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: InkWell(
              //       onTap: (){},
              //       child: Text("FORGET PASSWORD? ",style: TextStyle(color: Color(0xff003F93),fontSize: 12,fontWeight: FontWeight.w500),)),
              // ),
              SizedBox(height: 20,),
              CustomButton(onTap: (){
                if(emailcontroller.text.isEmpty)
                {
                  setState(() {
                    emailcontroller.text.isEmpty?emailvalidater=true:emailvalidater=false;
                    // passwordController.text.isEmpty?passwordvalidator=true:passwordvalidator=false;
                  });
                }
                else {
                  authController.resetPassword(emailcontroller.text.trim());
                  emailcontroller.clear();
                }
              }, text: "Send Possword"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("YOU DON’T HAVE AN ACCOUNT?",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xff003F93)),),
                  InkWell(
                      onTap: (){
                        Get.to(CreateNewAcoount());
                      },
                      child: Text(" SIGN UP",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xffFF7D00)),)),
                ],
              ),
              SizedBox(height: 20,),
              Text("Password send to your email Address",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(
                  0xff999da2)),),
            ],
          ),
        ),
      ),
    );
  }
}
