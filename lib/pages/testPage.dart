import 'dart:async';
import 'dart:convert';

import 'package:app0/pages/loginPage.dart';
import 'package:app0/pages/url.dart';
import 'package:app0/pages/welcomePage.dart';
import 'package:app0/param/colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Classes/Passenger.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key, required this.passenger, required this.verificationCode})
      : super(key: key);
  Passenger passenger;
  String verificationCode;
  //final String? title;
  static int s = 0;
  @override
  _TestPageState createState() => _TestPageState(passenger, verificationCode);
}

class _TestPageState extends State<TestPage> {
  _TestPageState(this.p, this.code);
  Passenger p;
  String code;
  int start = 59;
  int min = 1;
  int sec = 30;
  Duration myDuration = Duration(minutes: 8, seconds: 30);
  Timer? countdownTimer;
  double tsize = 15;
  Color tcolor = blackColor;
  Color bcolor = blueColor;
  //int f=startTimer();
  final _formKeyC = GlobalKey<FormState>();
  String val1 = "";
  String val2 = "";
  String val3 = "";
  String val4 = "";
  String confirmationCode = "6582";
  String s = "";
  Color ccolor = blackColor;

  Future getCode(context) async {
    final obb = jsonEncode({
      'email': p.email,
      'password': p.password,
      'wilaya': p.wilaya,
      'commune': p.commune,
      'lastname': p.lastname,
      'firstname': p.firstname,
      'birth_date': p.birth_date,
      'job': p.job,
      'numPhone': p.numPhone,
      'gender': p.gender,
    });
    print(p.numPhone);
    String url2 = urrr + 'user/createPassager';
    //String url2 = 'http://localhost:8081/createUser';

    var response = await http.post(Uri.parse(url2),
        headers: {
          "Accept": "application/json;charset=UTF-8",
          "Content-Type": "application/json",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Origin": "*",
        },
        body: obb);
    print(response.body);
    var msg = jsonDecode(response.body)['response'];
    print('response++ ' + msg);
    print(msg == 'ok');
    if (response.statusCode == 200 && msg == 'ok') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: 'Inscription terminée avec succès!',
        autoCloseDuration: Duration(seconds: 3),
      );
      await Future.delayed(const Duration(seconds: 2), () {});
      //if (_formKeyC.currentState!.validate()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Erreur'),
                content: Text(msg),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Fermer!'),
                    onPressed: () {
                      //Navigator.of(context).pop();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    },
                  )
                ],
              ));
    }
  }

  Widget _submitButton(width, context) {
    return InkWell(
      onTap: () {
        if (_formKeyC.currentState!.validate()) {
          getCode(context);
          //var cv = json.decode(response.body);

        }
      },
      child: Container(
        margin: EdgeInsets.only(left: width * .14, right: width * .14),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: bcolor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirmer',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
            ),
            SizedBox(
              width: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fields(height, width) {
    //var _currentSelectedValue = '';
    return Form(
      key: _formKeyC,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: height * .092,
              width: width * .16,
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Obligatoire";
                  }
                  return null;
                },
                //controller: ,
                onChanged: (value) {
                  if (value.length == 1) {
                    setState(() {
                      val1 = value;

                      s = val1 + val2 + val3 + val4;
                      FocusScope.of(context).nextFocus();
                      if (s.length == code.length && s == code) {
                        ccolor = Colors.green;

                        bcolor = blueColor;
                        //isDisabledButtonSubmit = false;
                      }
                      if (s.length == code.length && s != code) {
                        ccolor = Colors.red;
                        //bcolor = Colors.blueGrey;
                        //isDisabledButtonSubmit = true;
                      }
                    });
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.092,
              width: width * .16,
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Obligatoire";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.length == 1) {
                    setState(() {
                      val2 = value;
                      s = val1 + val2 + val3 + val4;

                      FocusScope.of(context).nextFocus();
                      if (s.length == code.length && s == code) {
                        ccolor = Colors.green;
                        bcolor = blueColor;
                        //isDisabledButtonSubmit = false;
                      }
                      if (s.length == code.length && s != code) {
                        ccolor = Colors.red;
                        //bcolor = Colors.blueGrey;
                        //isDisabledButtonSubmit = true;
                      }
                    });
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counter: Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.092,
              width: width * .16,
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Obligatoire";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.length == 1) {
                    setState(() {
                      val3 = value;
                      s = val1 + val2 + val3 + val4;
                      FocusScope.of(context).nextFocus();
                      if (s.length == code.length && s == code) {
                        ccolor = Colors.green;
                        bcolor = blueColor;
                        //isDisabledButtonSubmit = false;
                      }
                      if (s.length == code.length && s != code) {
                        ccolor = Colors.red;
                        //bcolor = Colors.blueGrey;
                        //isDisabledButtonSubmit = true;
                      }
                    });
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counter: Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.092,
              width: width * .16,
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Obligatoire";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.length == 1) {
                    setState(() {
                      val4 = value;
                      s = val1 + val2 + val3 + val4;
                      FocusScope.of(context).nextFocus();
                      if (s.length == code.length && s == code) {
                        ccolor = Colors.green;
                        bcolor = blueColor;
                        //isDisabledButtonSubmit = false;
                      }
                      if (s.length == code.length && s != code) {
                        ccolor = Colors.red;
                        //bcolor = Colors.blueGrey;
                        //isDisabledButtonSubmit = true;
                      }
                    });
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counter: Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------------------------------------
  Widget _timeout(height) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return Form(
      child: Column(children: [
        SizedBox(
          height: height * 0.014,
        ),
        InkWell(
          onTap: () async {
            String pphone = p.numPhone;
            String url3 =
                urrr + 'notification/sendConfirmeNumbre?phoneNumbre=$pphone';
            //String url3 = 'http://localhost:8081/validePhone/$phone';

            var response = await http.get(
              Uri.parse(url3), // ou url idk
              headers: {
                "Access-Control-Allow-Origin": "*",
                "Accept": "application/json;charset=UTF-8",
                "Content-Type": "application/json",
                "Access-Control-Allow-Methods": "GET, OPTIONS",
              },
            );
            print("before respon201se ");
            print(response.statusCode);
            var cv5 = json.decode(response.body).toString();
            print("code verificaion " + cv5);
            setState(() {
              code = cv5;
            });
          },
          child: Text(
            "Renvoyer",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: tsize,
                color: tcolor),
          ),
        ),
      ]),
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
                SizedBox(
                  height: height * .07,
                ),
                Image.asset(
                  'assets/images/signupImg4.png',
                  width: width * .475,
                  height: height * .31,
                ),
                SizedBox(
                  height: height * .014,
                ),
                SizedBox(
                  height: height * 0.034,
                ),
                Container(
                  child: Text(
                    'Code de confirmation',
                    style: TextStyle(
                        fontSize: 23,
                        color: ccolor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height * .04),
                _fields(height, width),
                SizedBox(height: height * .04),
                _timeout(height),
                SizedBox(height: height * .03),
                _submitButton(width, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
