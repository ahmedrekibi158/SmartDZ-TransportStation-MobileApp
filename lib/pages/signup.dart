import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Classes/Passenger.dart';
import 'signupSuit.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKeyy = GlobalKey<FormState>();

  TextEditingController date = TextEditingController();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  TextEditingController testPass = TextEditingController();

  String passwordConfirmation = "";
  bool _obscureText = true;
  /*void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }*/

  Passenger passenger = Passenger(
    email: "",
    password: "",
    firstname: "",
    lastname: "",
    birth_date: "",
  );

  Widget _submitButton(height, width) {
    return InkWell(
      onTap: () {
        if (_formKeyy.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  //builder: (context) => addressTestPage(
                  builder: (context) => SignUpSuitPage(
                        dataa: passenger,
                      )));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: width * .14, right: width * .14),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: blueColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Suivant',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: whiteColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fields(height, width) {
    return Form(
      key: _formKeyy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passenger.lastname),
                    onChanged: (val) {
                      setState(() {
                        passenger.lastname = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le nom est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Nom",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller:TextEditingController(text: passenger.firstname),
                    onChanged: (val) {
                      setState(() {
                        passenger.firstname = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le prénom est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Prénom",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: new BorderSide(color: blueColor)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: date,
                    onTap: () async {
                      DateTime? formattedDate = await showDatePicker(
                        context: context,
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(1930),
                        lastDate: new DateTime(2023),
                      );
                      if (formattedDate == null) {
                        print(
                            "Hi bro, i came from cancel button or via click outside of datepicker");
                      }

                      setState(() {
                        print("date.text bef " + date.text);
                        if (formattedDate != null) {
                          date.text = formatter.format(formattedDate!);
                          //String g = date.text;
                          passenger.birth_date = date.text;
                          print(passenger.birth_date);
                        }
                        //print("date.text " + date.text);
                        //print("date.text g " + g);
                        //DateTime dt = DateTime.parse(date.text);
                        //print(dt);
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "La date de naissance est vide";
                      }
                      return null;
                    }, //**************************************************************************************************************** */
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.date_range_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: 'Date de naissance',
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passenger.email),
                    onChanged: (val) {
                      setState(() {
                        passenger.email = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "L'email est vide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Email",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passenger.password),
                    onChanged: (val) {
                      setState(() {
                        passenger.password = val;
                      });
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le mot de passe est vide";
                      }
                      if (text.length < 8) {
                        return "Mot de passe trop court";
                      }
                      return null;
                    },

                    //onSaved: (val) => passenger.password = text,
                    obscureText: _obscureText,

                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: blueColor,
                      ),
                      /*suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 24,
                          ),
                        ),
                      ),*/
                      prefixIconColor: blueColor,
                      hintText: "   Mot de passe",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width * .1, right: width * .1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: TextFormField(
                    //controller: TextEditingController(text: passwordConfirmation),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Le mot de passe est vide ";
                      }
                      if (text != passenger.password) {
                        return "Ne pas correspondre";
                      }
                      return null;
                    },
                    obscureText: _obscureText,

                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: blueColor)),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: blueColor,
                      ),
                      prefixIconColor: blueColor,
                      hintText: "   Confirmer le mot de passe",
                      hintStyle: TextStyle(color: blueColor),
                      fillColor: whiteColor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: _submitButton(height, width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/signupImg1.png',
                  width: width * .4,
                  height: height * .22,
                ),
                Container(
                  child: Text(
                    'Créer un nouveau compte',
                    style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height * .015),
                _fields(height, width),
                SizedBox(height: height * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
