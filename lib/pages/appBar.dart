import 'package:app0/pages/profilPage.dart';
import 'package:flutter/material.dart';

import '../param/colors.dart';

PreferredSizeWidget appbar(height, width, textt, bool, context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height * .135),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF005CE6),
            Color(0xFF066AFF),
          ],
        ),
        //color: blueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      //automaticallyImplyLeading: false,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/appBar.png',
              color: blueColor,
              //width: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.all(12),
              child: Row(
                children: [
                  retourDash(width, bool, context),
                  SizedBox(
                    width: width * .02,
                  ),
                  Text(
                    textt,
                    style: TextStyle(fontSize: 20, color: whiteColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget retourDash(width, b, context) {
  if (b == 2) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: width * .07,
            color: whiteColor,
          ),
        ),
        SizedBox(
          width: width * .12,
        ),
        Icon(
          Icons.gps_fixed,
          size: width * .075,
          color: whiteColor,
        ),
      ],
    );
  }
  if (b == 3) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => profilePage(),
                ));
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: width * .07,
            color: whiteColor,
          ),
        ),
        SizedBox(
          width: width * .06,
        ),
        Icon(
          Icons.key,
          size: width * .075,
          color: whiteColor,
        ),
      ],
    );
  }
  return Row(
    children: [
      Icon(
        Icons.list,
        size: width * .1,
        color: whiteColor,
      ),
    ],
  );
}
//------------------------------------------------------------------------------------------
//******************************************************************************************
