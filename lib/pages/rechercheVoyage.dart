import 'dart:convert';

import 'package:app0/classes/Historique.dart';
import 'package:app0/pages/Dashboard.dart';
import 'package:app0/pages/profilPage.dart';
import 'package:app0/pages/historiquePage.dart';
import 'package:app0/pages/url.dart';

import 'package:app0/pages/wilayas.dart';
import 'package:app0/param/colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Classes/Wilaya.dart';
import '../classes/Commune.dart';

class recherchePage extends StatefulWidget {
  const recherchePage({
    this.jwwt,
    Key? key,
    this.title,
  }) : super(key: key);
  //final List<Historique> historiques;

  final String? title;
  final jwwt;

  @override
  _rechercheState createState() => _rechercheState(jwwt);
}

class _rechercheState extends State<recherchePage> {
  _rechercheState(this.jjwt);
  var jjwt;
  final _formKeyyy = GlobalKey<FormState>();

  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  TextEditingController _datee = TextEditingController();
  static final DateFormat formatter2 = DateFormat('yyyy-MM-dd');

  String _myWilaya = "1";
  String _myWilaya2 = "1";

  List communesList = [];
  List communesList2 = [];

  String ddd = '';

  String _myCommune = "500000";
  String _myCommune2 = "500000";

  Future _getCommunesList1() async {
    String _url2 = urrr + 'user/commune?wilaya=$_myWilaya';
    var response = await http.get(Uri.parse(_url2), headers: {
      //"Authorization": "Bearer " + jj.jw,
      "Access-Control-Allow-Origin": "*",
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Access-Control-Allow-Methods": "GET, OPTIONS",
    });

    List<Commune> communes = (json.decode(response.body) as List)
        .map((i) => Commune.fromJson(i))
        .toList();
    communes.insert(0, Commune(id: 500000, name: 'Aucune ---'));
    setState(() {
      communesList = communes;

      _myCommune = communesList[0].id.toString();
      int lengthcommunes = communesList.length;
      print("Nombre de communes:$lengthcommunes");
      print('end setstate commune 1-----------');
    });
  }

  Future _getCommunesList2() async {
    String _url23 = urrr + 'user/commune?wilaya=$_myWilaya2';

    var response = await http.get(
      Uri.parse(_url23),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );
    List<Commune> communes2 = (json.decode(response.body) as List)
        .map((i) => Commune.fromJson(i))
        .toList();
    communes2.insert(0, Commune(id: 500000, name: 'Aucune ---'));

    setState(() {
      print('setstate commune 2-----------');

      communesList2 = communes2;
      _myCommune2 = communesList2[0].id.toString();
      int lengthcommunes2 = communesList2.length;
      print("Nombre de communes:$lengthcommunes2");
      print('end setstate commune 1-----------');
    });
  }

  Widget dd(height, width) {
    List<Wilaya> wilayasList = getWilayas();

    return Column(children: [
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                left: width * .01,
              ),
              child: Text(
                "Départ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: whiteColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(right: width * .02),
              //alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                iconSize: 32,
                //style: TextStyle(color: Colors.greenAccent),
                dropdownColor: Colors.greenAccent,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                value: _myWilaya,
                items: wilayasList.map((item) {
                  return new DropdownMenuItem<String>(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: whiteColor,
                      ),
                    ),
                    value: item.id,
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _myWilaya = newValue!;
                    print('wilaaaaya' + _myWilaya);
                    setState(() {
                      _getCommunesList1();
                    });
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                iconSize: 32,
                //style: TextStyle(color: Colors.greenAccent),
                dropdownColor: Colors.greenAccent,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 6,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //filled: true,
                  //fillColor: Colors.blueAccent,
                ),
                value: _myCommune,
                items: communesList.map((item) {
                  return new DropdownMenuItem<String>(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: whiteColor,
                      ),
                    ),
                    value: item.id.toString(),
                  );
                }).toList(),
                hint: Text('Commune '),
                onChanged: (newValue) {
                  setState(() {
                    _myCommune = newValue!;
                    print(_myCommune);
                  });
                },
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: height * .01,
      ),
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                left: width * .01,
              ),
              //alignment: Alignment.center,
              child: Text(
                "Destination",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: whiteColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(right: width * .02),
              //padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                iconSize: 32,
                //style: TextStyle(color: Colors.greenAccent),
                dropdownColor: Colors.greenAccent,
                isExpanded: true,
                //focusColor: blueColor,
                decoration: InputDecoration(
                  //enabledBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.greenAccent, width: 6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //filled: true,
                  //fillColor: Colors.blueAccent,
                ),
                value: _myWilaya2,
                items: wilayasList.map((item) {
                  return new DropdownMenuItem<String>(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: whiteColor,
                      ),
                    ),
                    value: item.id.toString(),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _myWilaya2 = newValue!;
                    print("before get communes");
                    print(communesList2.length);
                    setState(() {
                      _getCommunesList2();
                    });

                    print("after get communes");
                    print(communesList2.length);

                    print(_myWilaya2);
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              //margin: EdgeInsets.only(right: width * .02),
              //padding: EdgeInsets.symmetric(vertical: 3),
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                iconSize: 32,
                //style: TextStyle(color: Colors.greenAccent),
                dropdownColor: Colors.greenAccent,
                isExpanded: true,
                decoration: InputDecoration(
                  //enabledBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //filled: true,
                  //fillColor: Colors.blueAccent,
                ),
                value: _myCommune2,
                items: communesList2.map((item) {
                  return new DropdownMenuItem<String>(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: whiteColor,
                      ),
                    ),
                    value: item.id.toString(),
                  );
                }).toList(),
                hint: Text('Commune'),
                onChanged: (newValue) {
                  setState(() {
                    _myCommune2 = newValue!;
                    print(_myCommune2);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Map<String, String> headers = {
    "Authorization": "Bearer " + jj.jw,
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Access-Control-Allow-Origin": "*",
  };
  List<dynamic> hhhh = [];
  Future getVoyages() async {
    String _url = urrr +
        'voyage/passager/ChercherVoyage?wilayaD=$_myWilaya&&wilayaA=$_myWilaya2';
    var ress = await http.get(
      Uri.parse(_url), // ou url idk
      headers: headers,
    );

    if (_myCommune != '500000') {
      _url = _url + '&&communeD=$_myCommune';
    }
    if (_myCommune2 != '500000') {
      print(_myCommune2 != '500000');
      _url = _url + '&&communeA=$_myCommune2';
    }
    print('uuuuurl' + _url);
    print("before send request");
    print(ress.statusCode);

    var vv = jsonDecode(ress.body);
    if (vv['voyages'].length != 0) {
      setState(() {
        print('vv voyage != null');
        print(vv['voyages']);
        hhhh = vv['voyages'];
      });
    } else
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    Text('  Malheuresement'),
                  ],
                ),
                content: Text('Aucun voyage trouvé'),
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

  @override
  void initState() {
    //getVoyages();
  }

  int _selectedIndex = 1;
  String idh = "";
  List<Historique> hist = [];
  Widget cards(id, depart, destination, heure, height, width) {
    double s = 10;
    return Container(
      height: height * .14,
      width: width * .75,
      margin: EdgeInsets.only(
        left: width * .009,
        right: width * .009,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s),
      ),
      child: Card(
        shadowColor: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(s),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(s),
                    bottomLeft: Radius.circular(s)),
                child: Container(
                  color: blueColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height * .03),
                        padding: EdgeInsets.only(
                            right: width * .025, left: width * .025),
                        child: Text(
                          'Heure',
                          style: TextStyle(fontSize: 15, color: whiteColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: height * .03),
                        padding: EdgeInsets.only(
                            right: width * .025, left: width * .025),
                        child: Text(
                          heure,
                          style: TextStyle(fontSize: 15, color: whiteColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * .008),
                      child: Image.asset(
                        'assets/images/picres.png',
                        width: width * .11,
                        height: height * .115,
                      ),
                    ),
                    Column(
                      //mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          //alignment: Alignment.centerLeft,
                          child: Container(
                            //padding: EdgeInsets.only(left: 0),
                            //margin: EdgeInsets.all(width * .01),
                            margin: EdgeInsets.only(
                                bottom: width * .06,
                                top: width * .01,
                                right: width * .05),
                            child: Text(depart),
                          ),
                        ),
                        Align(
                          //alignment: Alignment.centerLeft,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 0),
                            margin: EdgeInsets.only(right: width * .05),
                            child: Text(destination),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: width * .15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: blueColor,
                    size: 30,
                  ),
                  //color: Colors.yellow,
                ),
                onTap: () async {
                  setState(() {
                    idh = id;
                    print("id voyage == " + idh);
                  });
                  String url2 = urrr + 'voyage/getLine?line=$idh';
                  var resp22 = await http.get(
                    Uri.parse(url2),
                    headers: {
                      "Authorization": "Bearer " + jj.jw,
                      "Accept": "application/json; charset=UTF-8",
                      "Content-Type": "application/json",
                      "Access-Control-Allow-Methods": "GET, OPTIONS",
                      "Access-Control-Allow-Origin": "*",
                    },
                  );

                  print(resp22.statusCode);
                  //var jjss = json.decode(resp22.body);

                  var jjs = json.decode(resp22.body);

                  //String idr = r.id;
                  List<String> voyagge = [
                    jjs['departure']['station']['name'],
                    jjs['departure']['station']['commune']['name'] +
                        ', ' +
                        jjs['departure']['station']['wilaya']['name'],
                    jjs['departure']['departTime'],

                    jjs['arrival']['station']['name'],
                    jjs['arrival']['station']['commune']['name'] +
                        ', ' +
                        jjs['departure']['station']['wilaya']['name'],
                    jjs['arrival']['departTime'],

                    //"15:30",
                    (jjs['arrival']['price'] - jjs['departure']['price'])
                            .toString() +
                        " DA",
                  ];
                  List<String> fields = [
                    "Gare du départ",
                    "Ville du départ",
                    "Heure de départ",
                    "Gare d'arrivée",
                    "Ville d'arrivée",
                    "Heure d'arrivée",
                    "Prix ",
                  ]; //********************************************************************* */

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: Container(
                            //height: height-400,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * .035,
                                ),
                                Text(
                                  "Détaille de voyage",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: width * .075,
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
                            width: double.infinity,
                            height: height * .66,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      //padding: EdgeInsets.only(top: width * .055),
                                      width: width * .28,
                                      height: height * .43,
                                      //margin: EdgeInsets.only(right: width*.2),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...fields.map((val) {
                                            return Text(
                                              val,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width * .4,
                                      height: height * .43,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...voyagge.map((val) {
                                            return Text(
                                              val,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          })
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * .008,
                                ),
                                Form(
                                  key: _formKeyyy,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: width * .025,
                                      right: width * .025,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 7),
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      //key: _formKeyyy,
                                      controller: _datee,
                                      onTap: () async {
                                        var dept =
                                            jjs['departure']['departTime'];
                                        DateTime dtm = DateTime.now()
                                            .add(Duration(days: 30));

                                        TimeOfDay _startTime = TimeOfDay(
                                            hour: int.parse(dept.split(":")[0]),
                                            minute:
                                                int.parse(dept.split(":")[1]));
                                        print(_startTime);

                                        TimeOfDay noow =
                                            TimeOfDay.now(); //if(dt.hour>)

                                        double toDouble(TimeOfDay myTime) =>
                                            myTime.hour + myTime.minute / 60.0;
                                        print(noow);
                                        double xx = toDouble(_startTime);
                                        double yy = toDouble(noow);
                                        print(xx);
                                        print(yy);
                                        DateTime dtd = DateTime.now();
                                        if (xx <= yy) {
                                          print('dtd');
                                          print(dtd);

                                          dtd = DateTime.now()
                                              .add(Duration(days: 1));
                                          print('dtd2');
                                          print(dtd);
                                        }
                                        DateTime? formattedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: dtd,
                                          firstDate: dtd,
                                          lastDate: dtm,
                                        );
                                        if (formattedDate == null) {
                                          print(
                                              "Hi bro, i came from cancel button or via click outside of datepicker");
                                        }
                                        setState(() {
                                          if (formattedDate != null) {
                                            print(
                                                "date.text bef " + _datee.text);
                                            ddd = formatter2
                                                .format(formattedDate);
                                            _datee.text =
                                                formatter.format(formattedDate);
                                            String g = _datee.text;
                                            print("date.text " + _datee.text);
                                            print("date.text g " + g);
                                          }
                                          //passenger.birthday = date.text;
                                          //print(passenger.birthday);
                                          //DateTime dt = DateTime.parse(date.text);
                                          //print(dt);
                                        });
                                      },
                                      validator: (text) {
                                        if (text!.isEmpty) {
                                          return "La date est vide";
                                        }
                                        return null;
                                      }, //**************************************************************************************************************** */
                                      decoration: InputDecoration(
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: blueColor)),
                                        prefixIcon: Icon(
                                          Icons.date_range_outlined,
                                          color: blueColor,
                                        ),
                                        prefixIconColor: blueColor,
                                        hintText:
                                            'Sélectionner la date de voyage',
                                        hintStyle: TextStyle(
                                          color: blueColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        fillColor: whiteColor,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                ElevatedButton.icon(
                                  //key: _formKeyyy,
                                  onPressed: () {
                                    if (_formKeyyy.currentState!.validate()) {
                                      reserver();
                                    }
                                  },
                                  icon: Icon(Icons.directions_bus),
                                  label: Text(
                                    'Réserver',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });

                  //--------------------------------------------------------------------
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future reserver() async {
    String url = urrr + 'reservation/passager/reserver';

    print("before send request96");
    print(int.parse(idh));
    print(ddd);
    final olmm = json.encode({
      'line': int.parse(idh),
      'date': ddd,
    });
    var res = await http.post(Uri.parse(url), // ou url idk
        headers: {
          "Authorization": "Bearer " + jj.jw,
          "Accept": "application/json; charset=UTF-8",
          "Content-Type": "application/json",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Origin": "*",
        },
        body: olmm);
    print("before ccc sss");
    print(res.statusCode);
    print(res.body);
    //String msg = json.decode(res.body).toString();
    //print(msg);
    if (res.statusCode == 200 && res.body == 'ok') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: 'La réservation a été faite!',
        autoCloseDuration: Duration(seconds: 2),
      );
      await Future.delayed(const Duration(seconds: 2), () {});

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    } else {
      if (res.statusCode == 200) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      Text('  Malheuresement'),
                    ],
                  ),
                  content: Text(res.body),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('Fermer !'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  void onItemTapped(int index) {
    setState(() {
      print("index $index");
      if (index == 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
      }

      if (index == 2) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => historiquePage(),
            ));
      }
      if (index == 3) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => profilePage(),
            ));
      }

      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .43),
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
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: height * .05,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: width * .1,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          Text(
                            'Rechercher un voyage',
                            style: TextStyle(fontSize: 25, color: whiteColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .015,
                      ),
                      dd(height, width),
                      SizedBox(
                        height: height * .025,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            shadowColor: whiteColor,
                            fixedSize: Size(width * .35, height * .05),
                          ),
                          onPressed: () {
                            getVoyages();
                          },
                          child: Text(
                            'Rechercher',
                            style: TextStyle(color: blueColor, fontSize: 16),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: height * .02, bottom: height * .02),
        child: listViewCards(height, width),
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

  Widget listViewCards(height, width) {
    print('object2220');
    print(hhhh.length);

    if (hhhh.isNotEmpty) {
      return ListView(
        children: <Widget>[
          ...hhhh.map((val) {
            print("map value");

            //String dayy = val.date.day as String;
            return cards(
              val['id'].toString(),
              val['departure']['station']['commune']['name'] +
                  ', ' +
                  val['departure']['station']['wilaya']['name'],
              val['arrival']['station']['commune']['name'] +
                  ', ' +
                  val['departure']['station']['wilaya']['name'],
              val['departure']['departTime'],
              height,
              width,
            );
          }),
          SizedBox(
            height: height * .06,
          ),
        ],
        //child: _widgetOptions.elementAt(_selectedIndex),
      );
    } else
      return Column(
        children: [
          Center(
            //padding: EdgeInsets.,
            child: Image.asset(
              'assets/images/voyageEmpty.png',
              width: width * .37,
              height: height * .37,
            ),
          ),
        ],
      );
  }
}
