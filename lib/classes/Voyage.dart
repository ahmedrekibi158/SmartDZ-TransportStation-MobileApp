class Voyage {
  int id;
  String name;
  String numPlace;

  Voyage(
    this.id,
    this.name,
    this.numPlace,
  );

  factory Voyage.fromJson(Map<String, dynamic> json) => Voyage(
        json["id"] as int,
        json["name"] as String,
        json["numPlace"] as String,
      );
}
