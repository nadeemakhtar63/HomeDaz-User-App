import 'package:flutter/material.dart';

CustomTextFields(choseContrroler,bool boolvalidate,
    hintText,textInputType,bool check,Icon icon)
{
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child:      Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        autocorrect: true,
        obscureText: check,
        keyboardType: textInputType,
        controller: choseContrroler,
        style: TextStyle(color: Color(0xff3D4864)),
        decoration: InputDecoration(
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: new BorderSide(color: Color(0xffFF7D00))
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:  BorderSide(color: Color(0xffFF7D00), width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:  BorderSide(color: Color(0xffFF7D00), width: 0.0),
            ),
            hintText: hintText,
            prefixIcon: icon,
            hintStyle: TextStyle(color: Color(0xff3D4864)),
            errorText: boolvalidate?"$hintText Required*":null
        ),

      ),
    ),
  );
}