class Commune {
  int id;
  String name;

  Commune({
    required this.id,
    required this.name,
  });

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
