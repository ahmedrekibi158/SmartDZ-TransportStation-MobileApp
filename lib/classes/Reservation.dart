import 'Voyage.dart';

class Reservation {
  int id;

  String depart;
  String destination;
  String heure;
  String prix;
  String date;
  String jour;
  Voyage voyage;
  //late final DateTime birthday;

  Reservation(this.id, this.depart, this.destination, this.heure, this.prix,
      this.date, this.jour, this.voyage);

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      json["id"] as int,
      json["depart"] as String,
      json["destination"] as String,
      json["heure"] as String,
      json["prix"] as String,
      json["date"] as String,
      json["jour"] as String,
      Voyage.fromJson(json['station']),
    );
  }

/*
  Map<String, dynamic> toJson() => {
        "id": id,
        "depart": depart,
        "destination": destination,
        "heure": heure,
        "prix": prix,
        "date": date,
        "jour": jour,
      };*/
}




/*import 'package:app0/classes/Passenger.dart';
import 'package:app0/classes/Voyage.dart';

import 'Line.dart';

class Reservation {
  int id;
  String date;
  String price;
  bool valid;
  Passenger passenger;
  Voyage voyage;
  Line line;

  Reservation(this.id, this.date, this.price, this.valid, this.voyage,
      this.passenger, this.line);

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        int.parse(json['id']),
        json['date'] as String,
        json['price'] as String,
        json['valid'] as bool,
        Voyage.fromJson(json['voyage']),
        Passenger.fromJson(json['passenger']),
        Line.fromJson(json['line']),
      );
}*/
