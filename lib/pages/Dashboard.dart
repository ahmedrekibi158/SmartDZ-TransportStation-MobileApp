import 'dart:convert';

import 'package:app0/pages/appBar.dart';
import 'package:app0/pages/historiquePage.dart';
import 'package:app0/pages/position.dart';
import 'package:app0/pages/profilPage.dart';
import 'package:app0/pages/rechercheVoyage.dart';
import 'package:app0/pages/url.dart';
import 'package:collection/collection.dart';

import 'package:app0/param/colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, this.title}) : super(key: key);
  //final List<Reservation> reser;
  final String? title;

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<Dashboard> {
  List<dynamic> data = [];

  Future getReservations() async {
    //var myjwt = await storag.read(key: "myjwt");

    String url = urrr + 'reservation/passager/reservationList';
    //String url = "http://localhost:8081/getReservations";
    var res = await http.get(
      Uri.parse(url), // ou url idk
      headers: {
        "Authorization": "Bearer " + jj.jw,
        "Accept": "application/json; charset=UTF-8",
        "Content-Type": "application/json",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
        "Access-Control-Allow-Origin": "*",
      },
    );

    var dataa = jsonDecode(res.body);
    setState(() {
      if (dataa['reservations'] != null) {
        data = dataa['reservations'];
      }
      //data = dataa['reservations'];
    });
  }

  @override
  void initState() {
    //var storage = FlutterSecureStorage();
    getReservations();
  }

  int _selectedIndex = 0;
  int idg = 0;

  Widget cards(
      id, depart, destination, heure, date, prix, jour, height, width) {
    double s = 10;
    return InkWell(
      onTap: () async {
        setState(() {
          idg = int.parse(id);
        });
        String url2 = urrr + 'reservation/passager/reservation/$idg';
        var resp = await http.get(
          Uri.parse(url2),
          headers: {
            "Authorization": "Bearer " + jj.jw,
            "Accept": "application/json; charset=UTF-8 ",
            "Content-Type": "application/json",
            "Access-Control-Allow-Methods": "GET, OPTIONS",
            "Access-Control-Allow-Origin": "*",
          },
        );

        var data3 = json.decode(resp.body);
        List<String> reservation = [
          getDay(DateFormat('EEEE').format(DateTime.parse(data3['date']))),
          data3['date'],
          data3['line']['departure']['station']['commune']['name'] +
              ', ' +
              data3['line']['departure']['station']['wilaya']['name'],
          data3['line']['arrival']['station']['wilaya']['name'] +
              ', ' +
              data3['line']['arrival']['station']['wilaya']['name'],
          data3['line']['departure']['departTime'],
          data3['price'].toString() + " DA"
        ];
        List<String> fields = [
          "Jour",
          "Date",
          "Départ",
          "Destination",
          "Heure",
          "Prix"
        ];

        Widget continueButton = ElevatedButton(
          child: Text("Oui"),
          onPressed: () async {
            String url2 = urrr + 'reservation/passager/deletReservation/$idg';
            var respp = await http.delete(
              Uri.parse(url2),
              headers: {
                "Authorization": "Bearer " + jj.jw,
                "Accept": "application/json; charset=utf-8",
                "Content-Type": "application/json",
                "Access-Control-Allow-Methods": "DELETE, OPTIONS",
                "Access-Control-Allow-Origin": "*",
              },
            );

            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'La réservation a été annulé!',
              autoCloseDuration: Duration(seconds: 2),
            );
            await Future.delayed(const Duration(seconds: 2), () {});
            //******************************************************************************************************

            String url8 = urrr + 'reservation/passager/reservationList';
            //String url = "http://localhost:8081/getReservations";
            var respons = await http.get(
              Uri.parse(url8), // ou url idk
              headers: {
                "Authorization": "Bearer " + jj.jw,
                "Accept": "application/json; charset=UTF-8",
                "Content-Type": "application/json",
                "Access-Control-Allow-Methods": "GET, OPTIONS",
                "Access-Control-Allow-Origin": "*",
              },
            );

            var dataa4 = jsonDecode(respons.body);
            setState(() {
              if (dataa4['reservations'] != null) {
                data = dataa4['reservations'];
              } else
                setState(() {
                  data = [];
                });
            });

            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
        Widget cancelButton = ElevatedButton(
          child: Text("Non"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        AlertDialog alert = AlertDialog(
          //title: Text("Annuler la réservation"),
          content: Text("Voulez-vous vraiment continuer?"),
          actions: [
            continueButton,
            cancelButton,
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Détaille de réservation",
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
                  height: height * .55,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            //padding: EdgeInsets.only(top: width * .055),
                            width: width * .235,
                            height: height * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...fields.map((val) {
                                  return Text(
                                    val,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                })
                              ],
                            ),
                          ),
                          Container(
                            width: width * .42,
                            height: height * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...reservation.map((val) {
                                  return Text(val);
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: height * .05,
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: blueColor,
                            ),
                            icon: Icon(
                              Icons.gps_fixed,
                              color: blackColor,
                              size: 24.0,
                            ),
                            label: Text('Localiser le bus'),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Position(),
                                  ));
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: height * .05, bottom: height * .05),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            icon: Icon(
                              Icons.delete,
                              color: blackColor,
                              size: 24.0,
                            ),
                            label: Text('Annuler la réservation'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        height: height * .17,
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
                flex: 1,
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
                            jour,
                            style: TextStyle(fontSize: 18, color: whiteColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * .03),
                          padding: EdgeInsets.only(
                              right: width * .025, left: width * .025),
                          child: Text(
                            date,
                            style: TextStyle(fontSize: 18, color: whiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          //margin: EdgeInsets.all(20),
                          child: //Text("A"),
                              Image.asset(
                            'assets/images/picres.png',
                            width: width * .1,
                            height: height * .1,
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
                                  bottom: height * .009,
                                  top: height * .0055,
                                ),
                                child: Text(
                                  depart,
                                ),
                              ),
                            ),
                            Align(
                              //alignment: Alignment.centerLeft,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 0),
                                margin: EdgeInsets.only(
                                    right: width * .15, top: height * .009),
                                child: Text(destination),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(s))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: Text(
                                "Heure",
                                style: TextStyle(fontSize: 18),
                              )),
                              Container(
                                child: Text(
                                  heure,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text(
                                  "Prix",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(
                                  prix + " DA",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
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

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {});

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbar(height, width, 'Liste de réservations', 1, context),
      body: Container(
        padding: EdgeInsets.only(top: height * .04, bottom: height * .03),
        child: listViewCards(height, width),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  String getDay(String day) {
    if (day == 'Sunday') return 'Dimanche';
    if (day == 'Monday') return 'Lundi';
    if (day == 'Tuesday') return 'Mardi';
    if (day == 'Thursday') return 'Mercredi';
    if (day == 'Wednesday') return 'Jeudi';
    if (day == 'Friday') return 'Vendredi';
    return 'Samedi';
  }

  Function eq = const ListEquality().equals;
  Widget listViewCards(height, width) {
    if (data.isNotEmpty) {
      return ListView(
        children: <Widget>[
          for (var item in data)
            cards(
                item['id'].toString(),
                item['line']['departure']['station']['commune']['name'] +
                    ', ' +
                    item['line']['departure']['station']['wilaya']['name'],
                item['line']['arrival']['station']['wilaya']['name'] +
                    ', ' +
                    item['line']['arrival']['station']['wilaya']['name'],
                item['line']['departure']['departTime'],
                item['date'],
                item['price'].toString(),
                getDay(DateFormat('EEEE').format(DateTime.parse(item['date']))),
                //.day,
                //.day,
                height,
                width),
          SizedBox(
            height: height * .06,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/reservationEmpty.png',
              width: width * .6,
              height: height * .6,
            ),
          ),
          Center(
            child: Text('Aucun voyage réservé',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          )
        ],
      );
    }
  }
}
