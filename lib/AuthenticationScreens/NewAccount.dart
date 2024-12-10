import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_daz/Controller/AuthController.dart';
import 'package:home_daz/Widgets/CustomButton.dart';
import 'package:home_daz/Widgets/TextFields.dart';
import 'package:home_daz/constant.dart';

class CreateNewAcoount extends StatefulWidget {
  // const LogIn({Key? key}) : super(key: key);

  @override
  State<CreateNewAcoount> createState() => _CreateNewAcoountState();
}

class _CreateNewAcoountState extends State<CreateNewAcoount> {
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  bool namevalidatero=false,phonevalidator=false,emailvalidater=false,passwordvalidator=false;
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
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                child: Center(child: Image(image: AssetImage("assets/logo.png"),)),
              ),
              SizedBox(height: 20,),
              Text("HOME SERVICES",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xffFF7D00)),),
              SizedBox(height: 10,),
              Text("WELCOME TO BEST SERVICE PROVIDER SYSTEM",style: TextStyle(fontSize:10 ,fontWeight:FontWeight.w500 ,color: Color(0xffADADAD )),),
              SizedBox(height: 20,),
              Text("SIGNIN",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xff003F93)),),
              SizedBox(height: 20,),
              CustomTextFields(
                  namecontroller,
                  namevalidatero,
                  "ENTER FULLNAME",
                  TextInputType.text,
                  false,
                  Icon(Icons.person,color: Colors.blue,)
              ),
              CustomTextFields(
                  phoneController,
                  phonevalidator,
                  "ENTER PHONE NUMBER",
                  TextInputType.number,
                  false,
                  Icon(Icons.phone_in_talk,color: Colors.blue,)
              ),
              CustomTextFields(
                  emailcontroller,
                  emailvalidater,
                  "ENTER EMAIL ADDRESS",
                  TextInputType.emailAddress,
                  false,
                  Icon(Icons.email_outlined,color: Colors.blue,)
              ),
              CustomTextFields(
                  passwordController,
                  passwordvalidator,
                  "ENTER PASSWORD",
                  TextInputType.text,
                  true,
                  Icon(Icons.lock_outline,color: Colors.blue,)
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    onTap: (){ },
                    child: Text("FORGET PASSWORD? ",style: TextStyle(color: Color(0xff003F93),fontSize: 12,fontWeight: FontWeight.w500),)),
              ),
              SizedBox(height: 20,),
              CustomButton(
                  onTap: (){
                if(emailcontroller.text.isEmpty || passwordController.text.isEmpty ||namecontroller.text.isEmpty ||phoneController.text.isEmpty)
                {
                  setState(() {
                    phoneController.text.isEmpty? phonevalidator=true:phonevalidator=false;
                    namecontroller.text.isEmpty?namevalidatero=true:namevalidatero=false;
                    emailcontroller.text.isEmpty?emailvalidater=true:emailvalidater=false;
                    passwordController.text.isEmpty?passwordvalidator=true:passwordvalidator=false;
                  });
                }
                else {
                  authController.register(
                      emailcontroller.text.trim(),
                      passwordController.text.trim(),
                      namecontroller.text.trim(),
                      phoneController.text.trim());
                }
              },
                  text: "SIGNIN"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("YOU DON’T HAVE AN ACCOUNT?",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xff003F93)),),
                  InkWell(
                      onTap: (){

                      },
                      child: Text(" SIGN UP",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xffFF7D00)),)),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
