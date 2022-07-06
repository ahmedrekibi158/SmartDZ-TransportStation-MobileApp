import 'dart:convert';

import 'package:app0/pages/appBar.dart';
import 'package:app0/pages/profilPage.dart';
import 'package:app0/pages/url.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../param/colors.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPage({
    Key? key,
  }) : super(key: key);
  //final List<Reservation> reser;

  @override
  _upState createState() => _upState();
}

class _upState extends State<UpdatePasswordPage> {
  @override
  static var respoorr = "not66tt yet";
  final _globKey = GlobalKey<FormState>();

  var oldPass = "";
  var newPass = "";
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(seconds: 3), () {});
    Future<String> updatePass() async {
      print("UPDATE pass");
      String url = urrr + 'user/account/modifiyPassword';
      var resG = await http.post(
        Uri.parse(url), // ou url idk
        headers: {
          "Authorization": "Bearer " + jj.jw,
          "Accept": "application/json; charset=UTF-8",
          "Content-Type": "application/json",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Origin": "*",
        },
        body: json.encode({'oldPassword': oldPass, 'newPassword': newPass}),
      );

      String respoorr = json.decode(resG.body)['response'].toString();
      print('respoo before $respoorr');
      if (respoorr == 'ok') {
        print('respoo ok $respoorr');

        print('respoo==ok');
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Le mot de passe a été bien modifié!',
          autoCloseDuration: Duration(seconds: 2),
        );
        await Future.delayed(const Duration(seconds: 2), () {});
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => profilePage(),
            ));

        //Navigator.pop(context);
        //Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Erreur'),
                  content: Text("L'ancien password est incorrect"),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('Fermer!'),
                      onPressed: () {
                        //Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePasswordPage()));
                      },
                    )
                  ],
                ));
      }

      return respoorr;
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar:
            appbar(height, width, 'Modification du mot de passe', 3, context),
        body: Form(
          key: _globKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .1,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passenger.password),
                    onChanged: (val) {
                      setState(() {
                        oldPass = val;

                        print('old pass0');
                        print(oldPass);
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "L'ancien mot de passe est vide";
                      }
                      return null;
                    },
                    obscureText: true,

                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Ancien Mot de passe",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passenger.password),
                    onChanged: (val) {
                      setState(() {
                        newPass = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le mot de passe est vide";
                      }
                      if (text.length < 8) {
                        return "Mot de passe trop court";
                      }
                      return null;
                    },

                    //onSaved: (val) => passenger.password = text,
                    obscureText: true,

                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Nouveau Mot de passe",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passwordConfirmation),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le mot de passe est vide ";
                      }
                      if (text != newPass) {
                        return "Ne pas correspondre";
                      }
                      return null;
                    },
                    obscureText: true,

                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Confirmer le nouveau mot de passe",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_globKey.currentState!.validate()) {
                        updatePass();
                      }
                    },
                    child: Text('Confirmer'))
              ],
            ),
          ),
        ));
  }
}
