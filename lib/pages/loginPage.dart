import 'dart:convert';

import 'package:app0/classes/Reservation.dart';
import 'package:app0/pages/Dashboard.dart';
import 'package:app0/pages/url.dart';
import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../Classes/Passenger.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey23 = GlobalKey<FormState>();
  Passenger passenger = Passenger(email: "", password: "");
  List<Reservation> reservations = [];
  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
  };

  Future login() async {
    final olm = json.encode({
      'email': passenger.email,
      'password': passenger.password,
    });

    //String url = "http://localhost:8081/loginn";
    String url = urrr + 'user/login';

    var res = await http.post(Uri.parse(url), // ou url idk
        headers: headers,
        body: olm);

    if (res.statusCode == 200) {
      //var storage = FlutterSecureStorage();
      //jwtjwt = jsonDecode(res.body)['jwt'];
      jj.jw = jsonDecode(res.body)['jwt'];
      //storage.write(key: "myjwt", value: jsonDecode(res.body)['jwt']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
      //res = Response();    // initialize on all classes
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Erreur'),
                content: Text('Email ou mot de passe est incorrect'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Fermer!'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (_formKey23.currentState!.validate()) {
          setState(() {
            login();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 55, right: 55),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: blueColor,
        ),
        child: Text(
          'Connexion',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vous n\'avez pas de compte ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Inscrivez-vous',
              style: TextStyle(
                  color: blueColor, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    //var _passwordVisible = false;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: TextEditingController(text: passenger.email),
                  onChanged: (val) {
                    passenger.email = val;
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "L'email est vide";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: blueColor)),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: blueColor,
                    ),
                    prefixIconColor: blueColor,
                    hintText: "   Email",
                    hintStyle: TextStyle(color: blueColor),
                    fillColor: whiteColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: TextEditingController(text: passenger.password),
                  onChanged: (val) {
                    passenger.password = val;
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Le mot de passe est vide';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: blueColor,
                    ),
                    prefixIconColor: blueColor,
                    hintText: "   Mot de passe",
                    hintStyle: TextStyle(color: blueColor),
                    fillColor: whiteColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: new BorderSide(color: blueColor)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        height: hei,
        width: wid,
        child: Stack(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.symmetric(horizontal: wid * .1),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey23,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //SizedBox(height: hei * .08),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: Offset(-wid * .16, -hei * .1),
                              child: Container(
                                width: 320,
                                height: 320,
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blueColor,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(wid * .52, -hei * .1),
                              child: Container(
                                width: 240,
                                height: 240,
                                //alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blueColor,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: hei * .12, left: wid * .05),
                              child: Text(
                                "Connexion",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 260),
                              alignment: Alignment.center,
                              child: Text(
                                "Bienvenue",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _emailPasswordWidget(),
                      Container(
                        //padding: EdgeInsets.symmetric(vertical: hei * .02),
                        alignment: Alignment.centerRight,
                        child: Text('Mot de passe oublié ?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: blueColor,
                            )),
                      ),
                      SizedBox(height: hei * .06),

                      _submitButton(),

                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
