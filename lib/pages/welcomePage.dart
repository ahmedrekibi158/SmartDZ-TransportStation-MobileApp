import 'package:app0/param/colors.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signup.dart';

bool isSwitched = false;
//String adresse = "http://192.168.28.4";
String adresse = "http://localhost/";

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _goToLogin(width) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.only(left: width * .14, right: width * .14),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: blueColor),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: blueColor,
        ),
        child: Text(
          "Connexion",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
        ),
      ),
    );
  }

  Widget _goToSignup(width) {
    return InkWell(
      hoverColor: blueColor,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.only(left: width * .14, right: width * .14),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: blackColor),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: whiteColor,
        ),
        child: Text(
          "Inscription",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.13,
              ),
              Stack(alignment: Alignment.topCenter, children: [
                Transform.scale(
                  scaleX: width * .1,
                  scaleY: height * .08,
                  child: Transform.translate(
                    offset: Offset(0, height * -0.0115),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: width * .6,
                      height: height * .032,
                      //margin: EdgeInsets.all(0),
                      //padding: EdgeInsets.all(140),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [blueColor, blueCielCircle],
                          )),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/Asset 2mdpi.png",
                    width: width * .31,
                    height: height * .155,
                  ),
                ),
              ]),
              SizedBox(
                height: height * 0.16,
              ),
              _goToLogin(width),
              SizedBox(
                height: height * 0.08,
              ),
              _goToSignup(width),
              SizedBox(
                height: height * 0.06,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Transform.translate(
                    offset: Offset(width * .38, -height * .23),
                    child: Container(
                      margin: EdgeInsets.all(100),
                      width: 60,
                      height: 60,
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [blueColor, blueCielCircle],
                          )),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(width * .41, -height * .08),
                    child: Container(
                      margin: EdgeInsets.all(100),
                      width: 120,
                      height: 120,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [blueColor, blueCielCircle],
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
