import 'dart:convert';

import 'Gare.dart';

class Programme {
  int id;

  String departTime;
  String price;
  String stationorder;
  bool departure;
  bool arrival;
  Gare station;

  //late final DateTime birthday;

  Programme(this.id, this.departTime, this.price, this.stationorder,
      this.departure, this.arrival, this.station);

  factory Programme.fromJson(Map<String, dynamic> json) {
    return Programme(
      int.parse(json['id']),
      json['departTime'] as String,
      json['price'] as String,
      json['stationorder'] as String,
      json['departure'] as bool,
      json['arrival'] as bool,
      Gare.fromJson(json['station']),
    );
  }
}
