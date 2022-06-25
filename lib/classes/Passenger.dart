class Passenger {
  String email;
  String password;
  String lastname;
  String firstname;
  String job;
  String birth_date;
  //late final communeTime birthday;
  String wilaya;
  String commune;
  String gender;
  String numPhone;

  Passenger({
    required this.email,
    required this.password,
    this.firstname = "",
    this.lastname = "",
    this.wilaya = "",
    this.commune = "",
    this.numPhone = "",
    this.gender = "",
    this.job = "",
    this.birth_date = "",
  });
  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        email: json["email"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        wilaya: json["wilaya"],
        commune: json["commune"],
        numPhone: json["numPhone"],
        gender: json["gender"],
        job: json["job"],
        birth_date: json["birth_date"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "wilaya": wilaya,
        "commune": commune,
        "numPhone": numPhone,
        "gender": gender,
        "job": job,
        "birth_date": birth_date,
      };
}

/*
  //late final communeTime birthday;

 this.sexe = "",
    this.profession = "",
    communeTime? birthday,
  }) : this.birthday = birthday ?? communeTime.now();
}
*/