import 'dart:async';
import 'package:flutter_auth/screens/bottom_nav_screen.dart';

import 'screens/home_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> getnextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (email == null) {
            return WelcomeScreen();
          } else {
            return BottomNavScreen();
          }
        },
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 4), () {
      getnextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF9fe6a0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.10),
          // SvgPicture.asset(
          //   "assets/images/appstore.png",
          //   height: size.height * 0.45,
          // ),
          Card(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 16),
            elevation: 15,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image(
                  image: AssetImage("assets/images/farmlord.png"),
                ),
              ),
            ),
          ),
          //photoSize: 100.0,
          SizedBox(height: size.height * 0.10),
          Center(
            child: ColorizeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "FARMLORD",
                ],
                textStyle: TextStyle(
                    fontSize: 50.0,
                    fontFamily: "Horizon",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3),
                colors: [
                  Colors.black,
                  Colors.purple,
                  Colors.blue,
                  Colors.green,
                  Colors.pink,
                  Colors.lightGreenAccent,
                  Colors.red,
                ],
                totalRepeatCount: 1,
                speed: Duration(seconds: 1, milliseconds: 300),
                textAlign: TextAlign.start,

                // alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
          SizedBox(height: size.height * 0.02),
          // TypewriterAnimatedTextKit(
          //     onTap: () {
          //       print("Tap Event");
          //     },
          //     text: [
          //       "Place where all your doubts get cleared!",
          //     ],
          //     totalRepeatCount: 1,
          //     textStyle: TextStyle(
          //         fontSize: 16.0, fontFamily: "Agne", color: Colors.black),
          //     textAlign: TextAlign.center,
          //     alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          //     ),
        ],
      ),
    );
  }
}
