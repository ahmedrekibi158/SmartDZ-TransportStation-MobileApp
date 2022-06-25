import 'dart:convert';

import 'package:app0/pages/url.dart';
import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Classes/Passenger.dart';

import 'testPage.dart';

class SignUpPhonePage extends StatefulWidget {
  SignUpPhonePage({Key? key, required this.data2}) : super(key: key);

  //final String? title;
  Passenger data2;

  @override
  _SignUpPhonePageState createState() => _SignUpPhonePageState(data2);
}

class _SignUpPhonePageState extends State<SignUpPhonePage> {
  final _formKey4 = GlobalKey<FormState>();
  Passenger pas1;
  _SignUpPhonePageState(this.pas1);

  String phoneNumbre = "";
  String code = "";
  Future getCode() async {
    String url3 =
        urrr + 'notification/sendConfirmeNumbre?phoneNumbre=$phoneNumbre';
    //String url3 = 'http://localhost:8081/validePhone/$phoneNumbre';

    var response = await http.get(
      Uri.parse(url3), // ou url idk
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );
    print("before response ");
    print(response.statusCode);
    var cv = json.decode(response.body).toString();
    print("code verificaion " + cv);
    setState(() {
      code = cv;
    });
    if (_formKey4.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TestPage(passenger: pas1, verificationCode: code),
          ));
    }
  }

  Widget _submitButton(width) {
    print('"""""""""""""""""""""');
    print(pas1.firstname);
    print(pas1.lastname);
    print(pas1.password);
    print(pas1.email);
    print(pas1.job);
    print(pas1.birth_date);
    print(pas1.commune);
    print(pas1.wilaya);
    print(pas1.gender);

    print('""""""""""""""""""""""""""""""');
    //TestPage.s = 1;
    print("submit");
    print("");
    //pas1.phone = phone;
    return InkWell(
      onTap: () {
        getCode();

        //if (_formKey.currentState!.validate()) {

        //}
      },
      child: Container(
        margin: EdgeInsets.only(left: width * 0.14, right: width * 0.14),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: blueColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Suivant',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: whiteColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fields(height, width) {
    //var _currentSelectedValue = '';
    return Form(
      key: _formKey4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            //margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        phoneNumbre = val;
                        print("phone:: " + phoneNumbre);
                        pas1.numPhone = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le numéro du téléphone est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Numéro du téléphone",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                Container(
                  child: _submitButton(width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/signupImg3.png',
                  width: width * .4,
                  height: height * .22,
                ),
                SizedBox(
                  height: height * 0.008,
                ),
                Container(
                  child: Text(
                    'Numéro du téléphone',
                    style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.034,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: width * 0.175, right: width * 0.175),
                  child: Text(
                    "Définissez votre numéro de téléphone pour recevoir des notifications de toute mise à jour",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * .02),
                _fields(height, width),
                SizedBox(height: height * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
