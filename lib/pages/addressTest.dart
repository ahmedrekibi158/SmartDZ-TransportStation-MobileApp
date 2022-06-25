import 'dart:convert';

import 'package:app0/classes/Commune.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Classes/Wilaya.dart';

class addressTestPage extends StatefulWidget {
  addressTestPage({
    Key? key,
  }) : super(key: key);

  @override
  _addressTestPageState createState() => _addressTestPageState();
}

class _addressTestPageState extends State<addressTestPage> {
  _addressTestPageState();
  @override
  List<Wilaya> getWilayas() {
    Wilaya w1 = new Wilaya(id: '1', name: 'Adrar');
    Wilaya w2 = new Wilaya(id: "2", name: "Chlef");
    Wilaya w3 = new Wilaya(id: "3", name: "Laghouat");
    Wilaya w4 = new Wilaya(id: "4", name: "Oum El Bouaghi");
    Wilaya w5 = new Wilaya(id: "5", name: "Batna");
    Wilaya w6 = new Wilaya(id: "6", name: "Béjaïa");
    Wilaya w7 = new Wilaya(id: "7", name: "Biskra");
    Wilaya w8 = new Wilaya(id: "8", name: "Bechar");
    Wilaya w9 = new Wilaya(id: "9", name: "Blida");
    Wilaya w10 = new Wilaya(id: "10", name: "Bouira");
    Wilaya w11 = new Wilaya(id: "11", name: "Tamanrasset");
    Wilaya w12 = new Wilaya(id: "12", name: "Tbessa");
    Wilaya w13 = new Wilaya(id: "13", name: "Tlemcen");
    Wilaya w14 = new Wilaya(id: "14", name: "Tiaret");
    Wilaya w15 = new Wilaya(id: "15", name: "Tizi Ouzou");
    Wilaya w16 = new Wilaya(id: "16", name: "Alger");
    Wilaya w17 = new Wilaya(id: "17", name: "Djelfa");
    Wilaya w18 = new Wilaya(id: "18", name: "Jijel");
    Wilaya w19 = new Wilaya(id: "19", name: "Setif");
    Wilaya w20 = new Wilaya(id: "20", name: "Saida");
    Wilaya w21 = new Wilaya(id: "21", name: "Skikda");
    Wilaya w22 = new Wilaya(id: "22", name: "Sidi Bel Abbes");
    Wilaya w23 = new Wilaya(id: "23", name: "Annaba");
    Wilaya w24 = new Wilaya(id: "24", name: "Guelma");
    Wilaya w25 = new Wilaya(id: "25", name: "Constantine");
    Wilaya w26 = new Wilaya(id: "26", name: "Medea");
    Wilaya w27 = new Wilaya(id: "27", name: "Mostaganem");
    Wilaya w28 = new Wilaya(id: "28", name: "M'Sila");
    Wilaya w29 = new Wilaya(id: "29", name: "Mascara");
    Wilaya w30 = new Wilaya(id: "30", name: "Ouargla");
    Wilaya w31 = new Wilaya(id: "31", name: "Oran");
    Wilaya w32 = new Wilaya(id: "32", name: "El Bayadh");
    Wilaya w33 = new Wilaya(id: "33", name: "Illizi");
    Wilaya w34 = new Wilaya(id: "34", name: "Bordj Bou Arreridj");
    Wilaya w35 = new Wilaya(id: "35", name: "Boumerdes");
    Wilaya w36 = new Wilaya(id: "36", name: "El Tarf");
    Wilaya w37 = new Wilaya(id: "37", name: "Tindouf");
    Wilaya w38 = new Wilaya(id: "38", name: "Tissemsilt");
    Wilaya w39 = new Wilaya(id: "39", name: "El Oued");
    Wilaya w40 = new Wilaya(id: "40", name: "Khenchela");
    Wilaya w41 = new Wilaya(id: "41", name: "Souk Ahras");
    Wilaya w42 = new Wilaya(id: "42", name: "Tipaza");
    Wilaya w43 = new Wilaya(id: "43", name: "Mila");
    Wilaya w44 = new Wilaya(id: "44", name: "Ain Defla");
    Wilaya w45 = new Wilaya(id: "45", name: "Naama");
    Wilaya w46 = new Wilaya(id: "46", name: "Ain Temouchent");
    Wilaya w47 = new Wilaya(id: "47", name: "Ghardaia");
    Wilaya w48 = new Wilaya(id: "48", name: "Ghelizane");

    List<Wilaya> listw = [];
    listw.add(w1);
    listw.add(w2);
    listw.add(w3);
    listw.add(w4);
    listw.add(w5);
    listw.add(w6);
    listw.add(w7);
    listw.add(w8);
    listw.add(w9);
    listw.add(w10);
    listw.add(w11);
    listw.add(w12);
    listw.add(w13);
    listw.add(w14);
    listw.add(w15);
    listw.add(w16);
    listw.add(w17);
    listw.add(w18);
    listw.add(w19);
    listw.add(w20);
    listw.add(w21);
    listw.add(w22);
    listw.add(w23);
    listw.add(w24);
    listw.add(w25);
    listw.add(w26);
    listw.add(w27);
    listw.add(w28);
    listw.add(w29);
    listw.add(w30);
    listw.add(w31);
    listw.add(w32);
    listw.add(w33);
    listw.add(w34);
    listw.add(w35);
    listw.add(w36);
    listw.add(w37);
    listw.add(w38);
    listw.add(w39);
    listw.add(w40);
    listw.add(w41);
    listw.add(w42);
    listw.add(w43);
    listw.add(w44);
    listw.add(w45);
    listw.add(w46);
    listw.add(w47);
    listw.add(w48);
    return listw;
  }

  List<Commune> initCommunes() {
    List<Commune> listc = [];
    //Commune w1 = new Commune(id: '161', name: 'Commune');
    //listc.add(w1);
    return listc;
  }

//CALLING STATE API HERE
// Get State information by API

  String _myWilaya = "1";

  late List communesList = [];
  String _myCommune = "161";

  Future _getCommunesList() async {
    String url2 = 'http://localhost:8081/getCommunes/$_myWilaya';
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
      _myCommune = communesList[0].id;
      int lengthcommunes = communesList.length;
      print("namebre de communes:$lengthcommunes");
    });
  }

  //wilayasList.add(w1);
  @override
  Widget build(BuildContext context) {
    List<Wilaya> wilayasList = getWilayas();
    //List<Commune> communesList = initCommunes();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myWilaya,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Wilaya'),
                        items: wilayasList.map((item) {
                          return new DropdownMenuItem<String>(
                            child: Text(item.name),
                            value: item.id,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _myWilaya = newValue!;
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myCommune,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Commune'),
                        onChanged: (newValue) {
                          setState(() {
                            _myCommune = newValue!;
                            print(_myCommune);
                          });
                        },
                        items: communesList.map((item) {
                          return new DropdownMenuItem<String>(
                            child: Text(item.name),
                            value: item.id,
                          );
                        }).toList(),

/*
                        items: wilayasList.map((item) {
                          return new DropdownMenuItem<String>(
                            child: Text(item.name),
                            value: item.id,
                          );
                        }).toList(),
*/
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

}
