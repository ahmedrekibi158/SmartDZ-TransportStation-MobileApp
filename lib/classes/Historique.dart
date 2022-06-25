class Historique {
  String id;

  String departStation;
  String arrivalStation;
  String arrivalTime;
  String prix;
  String date;
  String status;

  Historique({
    this.id = "",
    this.departStation = "",
    this.arrivalStation = "",
    this.arrivalTime = "",
    this.prix = "",
    this.date = "",
    this.status = "",
  });

  factory Historique.fromJson(Map<String, dynamic> json) => Historique(
        id: json["id"],
        date: json['date'],

        departStation: json["departStation"],
        arrivalStation: json["arrivalStation"],
        arrivalTime: json["arrivalTime"],
        prix: json["prix"],

        //jour: json["jour"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departStation": departStation,
        "arrivalStation": arrivalStation,
        "arrivalTime": arrivalTime,
        "prix": prix,
        "date": date,
        //"jour": jour,
        "status": status,
      };
}

/*
  //late final DateTime date;

 this.sexe = "",
    this.profession = "",
    DateTime? birthday,
  }) : this.birthday = birthday ?? DateTime.now();
}
*/