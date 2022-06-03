import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/bottom_nav_screen.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BottomNavScreen();
          }));
        },
        child: Container(
          child: Center(
              child: Text(
            "Advertisement Successfully Added 🥳",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
        ),
      ),
    );
  }
}
