import 'package:app0/Classes/Wilaya.dart';
import 'package:app0/classes/Commune.dart';

class Gare {
  int id;
  String name;
  Wilaya wilaya;
  Commune commune;
  Gare(this.id, this.name, this.wilaya, this.commune);
  factory Gare.fromJson(Map<String, dynamic> json) {
    return Gare(
      int.parse(json['id']),
      json['name'] as String,
      Wilaya.fromJson(json['wilaya']),
      Commune.fromJson(json['commune']),
    );
  }
}
