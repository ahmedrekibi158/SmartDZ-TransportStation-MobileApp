import 'Programme.dart';
import 'Voyage.dart';

class Line {
  int id;
  Programme departure;
  Programme arrival;
  Voyage voyage;

  Line(this.id, this.departure, this.arrival, this.voyage);

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        int.parse(json["id"]),
        Programme.fromJson(json['station']),
        Programme.fromJson(json['station']),
        Voyage.fromJson(json['station']),
      );
}
