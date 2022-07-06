import 'dart:convert';

import 'package:app0/classes/Historique.dart';
import 'package:app0/pages/Dashboard.dart';
import 'package:app0/pages/profilPage.dart';
import 'package:app0/pages/rechercheVoyage.dart';
import 'package:app0/pages/url.dart';
import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class historiquePage extends StatefulWidget {
  const historiquePage({
    Key? key,
    this.title,
  }) : super(key: key);
  //final List<Historique> historiques;

  final String? title;

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<historiquePage> {
  List<dynamic> hhh = [];
  Future getHistoriques() async {
    String url = urrr + 'reservation/passager/historique';

    print("before send request");
    var res = await http.get(
      Uri.parse(url), // ou url idk
      headers: {
        "Authorization": "Bearer " + jj.jw,
        "Accept": "application/json; charset=UTF-8 ",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
        "Access-Control-Allow-Origin": "*",
      },
    );

    var historiques = json.decode(res.body);

    setState(() {
      if (historiques['reservations'] != null) {
        hhh = historiques['reservations'];
      }
      //data = dataa['reservations'];
    });
  }

  @override
  void initState() {
    getHistoriques();
  }

  int _selectedIndex = 2;
  int idh = 0;
  List<Historique> hist = [];
  Widget cards(id, depart, destination, date, height, width) {
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
                        /*child: Text(
                          'jour',
                          style: TextStyle(fontSize: 15, color: whiteColor),
                        ),*/
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: height * .03),
                        padding: EdgeInsets.only(
                            right: width * .025, left: width * .025),
                        child: Text(
                          date,
                          style: TextStyle(fontSize: 12, color: whiteColor),
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
                    idh = int.parse(id);
                  });

                  String url2 = urrr + 'reservation/passager/reservation/$idh';

                  var resp22 = await http.get(
                    Uri.parse(url2),
                    headers: {
                      "Authorization": "Bearer " + jj.jw,
                      "Accept": "application/json; charset=UTF-8 ",
                      "Content-Type": "application/json",
                      "Access-Control-Allow-Methods": "GET, OPTIONS",
                      "Access-Control-Allow-Origin": "*",
                    },
                  );
                  print(resp22.statusCode);

                  var historiqueJson = json.decode(resp22.body);
                  List<String> historique = [
                    historiqueJson['date'],
                    historiqueJson['line']['departure']['station']['commune']
                            ['name'] +
                        ', ' +
                        historiqueJson['line']['departure']['station']['wilaya']
                            ['name'],
                    "15:30",
                    historiqueJson['line']['arrival']['station']['wilaya']
                            ['name'] +
                        ', ' +
                        historiqueJson['line']['arrival']['station']['wilaya']
                            ['name'],
                    historiqueJson['line']['arrival']['departTime'],
                    historiqueJson['price'].toString() + " DA",
                    historiqueJson['valid'].toString()
                  ];
                  List<String> fields = [
                    "Date",
                    "Départ",
                    "Heure de départ",
                    "Arrivé",
                    "Heure d'arrivéé",
                    "Prix",
                    "Etat",
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
                                Text("Détaille de l'historique"),
                                SizedBox(
                                  width: width * .008,
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
                            height: height * .5,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      //padding: EdgeInsets.only(top: width * .055),
                                      width: width * .28,
                                      height: height * .3,
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
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width * .4,
                                      height: height * .3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...historique.map((val) {
                                            return Text(
                                              val,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          })
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
      if (index == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => recherchePage(),
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
    Future.delayed(const Duration(seconds: 3), () {});

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .2),
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
                      Icon(
                        Icons.history,
                        size: width * .1,
                        color: whiteColor,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        'Historique des voyages',
                        style: TextStyle(fontSize: 25, color: whiteColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: height * .04, bottom: height * .03),
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
    if (hhh.isNotEmpty) {
      return ListView(
        children: <Widget>[
          for (var item in hhh)
            cards(
              item['id'].toString(),
              item['line']['departure']['station']['commune']['name'] +
                  ', ' +
                  item['line']['departure']['station']['wilaya']['name'],
              item['line']['arrival']['station']['wilaya']['name'] +
                  ', ' +
                  item['line']['arrival']['station']['wilaya']['name'],
              item['date'],
              height,
              width,
            ),
          SizedBox(
            height: height * .06,
          ),
        ],
        //child: _widgetOptions.elementAt(_selectedIndex),
      );
    } else {
      return Column(
        children: [
          Center(
            //padding: EdgeInsets.,
            child: Image.asset(
              'assets/images/reservationEmpty.png',
              width: width * .6,
              height: height * .6,
            ),
          ),
          Center(
            child: Text('Pas d\'historique',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          )
        ],
      );
    }
  }
}
