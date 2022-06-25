class Wilaya {
  String id;
  String name;

  Wilaya({
    required this.id,
    required this.name,
  });

  factory Wilaya.fromJson(Map<String, dynamic> json) => Wilaya(
        id: json["id"],
        name: json["name"],
      );
}
