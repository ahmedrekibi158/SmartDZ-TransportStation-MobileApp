import 'dart:convert';

import 'package:app0/pages/url.dart';
import 'package:app0/pages/wilayas.dart';
import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import '../Classes/Passenger.dart';
import '../Classes/Wilaya.dart';
import '../classes/Commune.dart';
import 'signupPhone.dart';
import 'package:http/http.dart' as http;

class SignUpSuitPage extends StatefulWidget {
  SignUpSuitPage({
    Key? key,
    required this.dataa,
  }) : super(key: key);

  //final String? title;
  final Passenger dataa;

  @override
  _SignUpSuitPageState createState() => _SignUpSuitPageState(dataa);
}

class _SignUpSuitPageState extends State<SignUpSuitPage> {
  Passenger passenger;
  _SignUpSuitPageState(this.passenger);

  final _formKey2 = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItemsWilaya {
    List<DropdownMenuItem<String>> menuitems = [];
    return menuitems;
  }

  String value = "";
  bool b = true;

  //print(_info[1][2]);
  List maps = [];

  List<Commune> initCommunes() {
    List<Commune> listc = [];
    //Commune w1 = new Commune(id: '161', nom: 'Commune');
    //listc.add(w1);
    return listc;
  }

//CALLING STATE API HERE
// Get State information by API

  String _myWilaya = "1";

  List communesList = [];
  int _myCommune = 1610000;

  Future _getCommunesList() async {
    print("------------------ signup suit---------------------");
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
      print("xyyz");
      _myCommune = communesList[0].id;
      passenger.commune = _myCommune.toString();
      print(_myCommune);
      int lengthcommunes = communesList.length;
      print("Nombre de communes:$lengthcommunes");
    });
  }

//----------------------------------------*-*-*---------------------------------------------------------

  var dropdownSexeValue = 'Male';
  var dropdownProfessionValue = 'Etudiant';
  var dropdownWilayaValue = 'Constantine';

  Widget _submitButton(width) {
    print("sexe value :" + dropdownSexeValue);
    print("profession value :" + dropdownProfessionValue);
    passenger.job = dropdownProfessionValue;
    passenger.gender = dropdownSexeValue;

    return InkWell(
      onTap: () {
        if (_formKey2.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPhonePage(data2: passenger)));
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
              'Suivant',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
            ),
            SizedBox(
              width: width * .008,
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

  String gendd(String s) {
    if (s == 'Masculin') return "Male";
    return "Femme";
  }

  Widget _fields(height, width) {
    List<Wilaya> wilayasList = getWilayas();
    print(passenger.birth_date);
    //var _currentSelectedValue = '';
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: height * 0.014,
          ),
          Container(
            //margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                            fontSize: 17,
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
                            //enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //filled: true,
                            //fillColor: Colors.blueAccent,
                          ),
                          value: dropdownProfessionValue,
                          items: ["Etudiant", "Retraité", "Employé"]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownProfessionValue = newValue!;
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
                            fontSize: 17,
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
                            //enabledBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //filled: true,
                            //fillColor: Colors.blueAccent,
                          ),
                          value: dropdownSexeValue,
                          items: ["Masculin", "Féminine"]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: gendd(label),
                                  ))
                              .toList(),
                          //hint: Text('Rating'),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownSexeValue = gendd(newValue!);
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                        borderRadius: BorderRadius.circular(20),
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
                                      fontSize: 17,
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
                                      //enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      //filled: true,
                                      //fillColor: Colors.blueAccent,
                                    ),
                                    value: _myWilaya,
                                    items: wilayasList.map((item) {
                                      return new DropdownMenuItem<String>(
                                        child: Text(item.name),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _myWilaya = newValue!;
                                        passenger.wilaya = _myWilaya;

                                        print("before get communes");
                                        print(communesList.length);
                                        setState(() {
                                          _getCommunesList();
                                        });

                                        print("after get communes");
                                        print(communesList.length);

                                        print(_myWilaya);
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
                                      fontSize: 17,
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
                                      //enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      //filled: true,
                                      //fillColor: Colors.blueAccent,
                                    ),
                                    value: _myCommune.toString(),
                                    items: communesList.map((item) {
                                      return new DropdownMenuItem<String>(
                                        child: Text(item.name),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    hint: Text('Commune'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        print("object1");

                                        _myCommune = int.parse(newValue!);
                                        print("object2");
                                        passenger.commune =
                                            _myCommune.toString();
                                        print("22222222222");
                                        print(passenger.wilaya);
                                        print(passenger.commune);

                                        print(_myCommune);
                                      });
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty || text == "1610000")
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
                  height: height * .034,
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
                  'assets/images/signupImg2.png',
                  width: width * .45, //180
                  height: height * .245, //180
                ),
                Container(
                  child: Text(
                    'Informations personnels',
                    style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height * .015),
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
