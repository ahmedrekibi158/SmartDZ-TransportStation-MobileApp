import 'dart:convert';

import 'package:app0/pages/loginPage.dart';
import 'package:app0/pages/rechercheVoyage.dart';
import 'package:app0/pages/updatePasswordPage.dart';
import 'package:app0/pages/url.dart';
import 'package:app0/pages/wilayas.dart';
import 'package:app0/param/colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:app0/pages/Dashboard.dart';
import 'package:intl/intl.dart';

import '../Classes/Passenger.dart';
import '../Classes/Wilaya.dart';
import '../classes/Commune.dart';
import 'historiquePage.dart';

class profilePage extends StatefulWidget {
  const profilePage({
    Key? key,
    this.title,
  }) : super(key: key);
  //final List<Historique> historiques;

  final String? title;

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profilePage> {
  var passenger;
  var passengerPass;

  Map<String, String> headers = {
    "Authorization": "Bearer " + jj.jw,
    "Accept": "application/json; charset=UTF-8",
    "Content-Type": "application/json",
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Access-Control-Allow-Origin": "*",
  };
  String datt = "";
  String email = "";
  String firstname = "";
  String lastname = "";
  String gender = "";
  String numPhone = "";
  String job = "";
  String commune = "";
  String wilaya = "";
  String email4 = "";
  String email5 = "";

  Future getUser() async {
    String url = urrr + 'user/passager/profile';

    var res = await http.get(
      Uri.parse(url), // ou url idk
      headers: headers,
    );
    print('999999999999');
    print(res.body);
    print('222222222222222222');
    var userJson = json.decode(res.body); //error
    print(userJson);

    setState(() {
      passenger = userJson;

      DateTime d = DateTime.parse(passenger['birth_date']);
      datt = formatter.format(d);
      lastnameController.text = passenger['lastname'];
      firstnameController.text = passenger['firstname'];
      emailController.text = passenger['email'];
      email4 = passenger['email'];
      dateController.text = datt;

      genderController.text = passenger['gender'];
      numPhoneController.text = "0" + passenger['numPhone'];
      //jobController.text = passenger['job'];
      communeController.text = passenger['adresse']['commune']['name'];
      wilayaController.text = passenger['adresse']['wilaya']['name'];
      dropdownProfessionValue = passenger['job'];
      dropdownSexeValue = passenger['gender'];
      _myCommune = passenger['adresse']['commune']['id'].toString();
      _myCommuneName = passenger['adresse']['commune']['name'];
      _myWilaya = passenger['adresse']['wilaya']['id'].toString();
      _myWilayaName = passenger['adresse']['wilaya']['name'];
    });
  }

  String _code = "8888";

  Future _getCode(var phon) async {
    //String url3 =
    //urrr + 'notification/sendConfirmeNumbre?phoneNumbre=$phoneNumbre';
    //String url3 = 'http://localhost:8081/validePhone/$phon';
    String url3 = urrr + 'notification/sendConfirmeNumbre?phoneNumbre=$phon';

    var response24 = await http.get(
      Uri.parse(url3), // ou url idk
      headers: {
        "Authorization": "Bearer " + jj.jw,
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );
    var cv = json.decode(response24.body).toString();
    print("code verificaion " + cv);
    setState(() {
      _code = cv;
    });
    if (_formKeyyr2.currentState!.validate()) {}
  }

  String respoo = "not yet";
  static var respoor = "nottt yet";
  static var respoorr = "not66tt yet";

  bool valide = false;

  Future<String> updateUser() async {
    print("UPDATE user");
    String url = urrr + 'user/passager/updateProfile';

    var resG = await http.post(
      Uri.parse(url), // ou url idk
      headers: {
        "Authorization": "Bearer " + jj.jw,
        "Accept": "application/json; charset=UTF-8",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Origin": "*",
      },
      body: json.encode(passenger),
    );

    String userJsonG = json.decode(resG.body)['response'].toString();
    print('userJsonG== $userJsonG');
    setState(() {
      respoo = userJsonG;
      respoor = userJsonG;
      print('respoo == $respoo');
      print(respoo == 'ok');
    });

    return userJsonG;
  }

  String genderf(String sexe) {
    if (sexe == 'Femme') return 'Féminine';
    return 'Masculin';
  }

  String gendd(String s) {
    if (s == 'Masculin') return "Male";
    return "Femme";
  }

  @override
  void initState() {
    getUser();
  }

  final _formKeyyr = GlobalKey<FormState>();
  final _formKeyyr2 = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController numPhoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController wilayaController = TextEditingController();
  TextEditingController testPass = TextEditingController();

  var dropdownProfessionValue = 'Etudiant';
  var dropdownSexeValue = 'Male';
  String _myWilaya = "1";
  String _myWilayaName = "Adrar";
  String phoneNumbre = "";

  List communesList = [];
  String _myCommune = '';
  String _myCommuneName = '';

  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  static final DateFormat formatter2 = DateFormat('yyyy-MM-dd');
  Future _getCommunesList() async {
    //String url2 = "http://localhost:8081/getCommunes/$_myWilaya";
    String url2 = urrr + 'user/commune?wilaya=$_myWilaya';
    //String url2 = "192.168.43.92:8081/getCommunes/10";

    //
    var response = await http.get(
      Uri.parse(url2),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    List<Commune> communes = (json.decode(response.body) as List)
        .map((i) => Commune.fromJson(i))
        .toList();
    setState(() {
      communesList = communes;
      _myCommune = communesList[0].id.toString();
      //passenger.commune = _myCommune.toString();
    });
  }

  var _selectedIndex = 3;
  Widget _submitButton(height, width) {
    return InkWell(
      onTap: () {
        setState(() {
          _getCode("0" + passenger['numPhone']);
        });
        if (_formKeyyr.currentState!.validate()) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Confirmer l'opération",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: width * .06,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.cancel_rounded,
                            color: blackColor,
                            size: 24.0,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    width: width * .85,
                    height: height * .45,
                    child: _ffields(height, width),
                  ),
                );
              });

          //updateUser();
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: width * .14, right: width * .14),
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
              'Modifier',
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
    List<Wilaya> wilayasList = getWilayas();

    Future.delayed(const Duration(seconds: 1), () {});

    return Form(
      key: _formKeyyr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //key: passenger,
                    //initialValue: widget.lastname,

                    controller: lastnameController,
                    onChanged: (val) {
                      setState(() {
                        //lastnameController.text = val;
                        passenger['lastname'] = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le nom est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: blueColor),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Nom",
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
                    //initialValue: ,

                    controller: firstnameController,
                    //TextEditingController(text: passenger['firstname']),
                    onChanged: (val) {
                      setState(() {
                        passenger['firstname'] = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le prénom est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Prénom",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(color: blueColor)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: dateController,
                    //initialValue: dd,

                    onTap: () async {
                      DateTime? formattedDate = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1930),
                          lastDate: new DateTime(2023));

                      setState(() {
                        passenger['birth_date'] =
                            formatter2.format(formattedDate!);
                        //dateController.text; // important
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "La date de naissance est vide";
                      }
                      return null;
                    }, //**************************************************************************************************************** */
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.date_range_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: 'Date de naissance',
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
                    controller: emailController,
                    //initialValue: passenger['email'],
                    onChanged: (val) {
                      setState(() {
                        //email4 = val;
                        passenger['email'] = val;
                      });
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
                  margin:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: numPhoneController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        //phoneNumbre = val;
                        passenger['numPhone'] = val;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            width * .08, height * 0.028, 3, 0),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        //alignment: Alignment.center,
                        child: Text(
                          "Profession",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: width * .08, right: width * .08),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: blueColor),
                            ),
                            //enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //filled: true,
                            //fillColor: Colors.blueAccent,
                          ),
                          value: dropdownProfessionValue,
                          hint: Text(jobController.text),
                          items: ["Etudiant", "Retraité", "Employé"]
                              .map((label) => DropdownMenuItem(
                                    child: Text(
                                      label,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownProfessionValue = newValue!;
                              jobController.text = newValue;
                              passenger['job'] = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                //sexe
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            width * .08, height * 0.028, 3, 0),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        //alignment: Alignment.center,
                        child: Text(
                          "Sexe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: width * .08, right: width * .08),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: blueColor),
                            ),
                            //enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //filled: true,
                            //fillColor: Colors.blueAccent,
                          ),
                          hint: Text(genderf(dropdownSexeValue)),
                          value: dropdownSexeValue,
                          items: ["Masculin", "Féminine"]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label,
                                        style: TextStyle(fontSize: 15)),
                                    value: gendd(label),
                                  ))
                              .toList(),
                          //hint: Text('Rating'),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownSexeValue = newValue!;
                              passenger['gender'] = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: width * .08,
                      right: width * .08,
                      top: height * 0.014,
                      bottom: 0),
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    "Adresse",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),

                Container(
                  child: SizedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: width * .05,
                          right: width * .05,
                          top: height * 0.014),
                      padding: EdgeInsets.only(
                          top: height * .021, bottom: height * .021),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blackColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          //row wilaya
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      width * .05, height * .028, 3, 0),
                                  padding: EdgeInsets.only(top: 1),
                                  //alignment: Alignment.center,
                                  child: Text(
                                    "Wilaya",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(right: width * .05),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: blueColor),
                                      ),
                                      //enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      //filled: true,
                                      //fillColor: Colors.blueAccent,
                                    ),
                                    hint: Text(_myWilayaName),
                                    value: _myWilaya,
                                    items: wilayasList.map((item) {
                                      setState(() {});
                                      return new DropdownMenuItem<String>(
                                        child: Text(item.name,
                                            style: TextStyle(fontSize: 15)),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _myWilaya = newValue!;
                                        passenger['adresse']['wilaya']['id'] =
                                            int.parse(newValue);

                                        setState(() {
                                          _getCommunesList();
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //row commune
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      width * .05, height * .028, 0, 0),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  //alignment: Alignment.center,
                                  child: Text(
                                    "Commune",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(right: width * .05),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: blueColor),
                                      ),
                                      //enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      //filled: true,
                                      //fillColor: Colors.blueAccent,
                                    ),
                                    value: _myCommune.toString(),
                                    items: communesList.map((item) {
                                      return new DropdownMenuItem<String>(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    hint: Text(_myCommuneName),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _myCommune = newValue!;
                                        passenger['adresse']['commune']['id'] =
                                            int.parse(newValue);
                                      });
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty || text.length == 0)
                                        return 'La commune est vide';
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                  child: _submitButton(height, width),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePasswordPage(),
                          ));
                    },
                    icon: Icon(Icons.key),
                    label: Text('Modifier le mot de passe'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
      }

      if (index == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => recherchePage(),
            ));
      }
      if (index == 2) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => historiquePage(),
            ));
      }
    });
  }

  Widget destination() {
    print(passenger['email']);
    print('email44 = $email4');
    if (passenger['email'] == email4) {
      return profilePage();
    }
    jj.jw = '';
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .195),
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
                //alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: width * .375),
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: width * .2,
                              color: whiteColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * .375, top: 12, bottom: 12),
                            child: Text(
                              'Profile',
                              style: TextStyle(fontSize: 25, color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: width * .2, top: height * .04),
                              child: Icon(
                                Icons.logout_sharp,
                                size: width * .1,
                                color: whiteColor,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: width * .2, top: 12, bottom: 12),
                              child: Text(
                                'Déconnecter',
                                style:
                                    TextStyle(fontSize: 11, color: whiteColor),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          jj.jw = "10";
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: height * .04, bottom: height * .03),
          child: _fields(height, width),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page d\'accueil',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Recherche',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'Historique',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: whiteColor,
        onTap: onItemTapped,
      ),
    );
  }

  String val1 = "";
  String val2 = "";
  String val3 = "";
  String val4 = "";
  String s = "";
  Color bcolor = blueColor;

  Color ccolor = blackColor;
  Widget _ffields(height, width) {
    //var _currentSelectedValue = '';
    return Form(
      key: _formKeyyr2,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: height * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: height * .08,
                  width: width * .1,
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

                          //FocusScope.of(context).nextFocus();
                          if (s.length == _code.length && s == _code) {
                            valide = true;
                            //isDisabledButtonSubmit = false;
                          }
                          if (s.length == _code.length && s != _code) {
                            valide = false;

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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .08,
                  width: width * .1,
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

                          if (s.length == _code.length && s == _code) {
                            valide = true;
                          }
                          if (s.length == _code.length && s != _code) {
                            valide = false;
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  width: width * .1,
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

                          if (s.length == _code.length && s == _code) {
                            valide = true;
                          }
                          if (s.length == _code.length && s != _code) {
                            valide = false;
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  width: width * .1,
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

                          if (s.length == _code.length && s == _code) {
                            valide = true;
                          }
                          if (s.length == _code.length && s != _code) {
                            valide = false;
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .05,
            ),
            ElevatedButton(
                child: Text("Confirmer"),
                onPressed: () async {
                  //String rrs = updateUser().toString();
                  if (valide) {
                    print('befoooore $respoor');
                    String h = await updateUser();

                    print('afteeer  $h');

                    if (respoor == 'ok') {
                      print('respoo==ok');
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: 'Le profil a été bien modifié!',
                        autoCloseDuration: Duration(seconds: 2),
                      );
                      await Future.delayed(const Duration(seconds: 2), () {});

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => destination(),
                          ));
                      //Navigator.pop(context);
                      //Navigator.pop(context);
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Erreur'),
                              content: Text('Le code est incorrect'),
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
                }),
          ],
        ),
      ),
    );
  }
}



/*String h = await updateUser();

                    if (respoor == 'ok') {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: 'Le profil a été bien modifié!',
                        autoCloseDuration: Duration(seconds: 2),
                      );
                      await Future.delayed(const Duration(seconds: 2), () {});

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => destination(),
                          ));
                      //Navigator.pop(context);
                      //Navigator.pop(context);
                    }*/