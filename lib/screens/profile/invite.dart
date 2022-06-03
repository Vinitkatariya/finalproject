//import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/nature.jpg"), fit: BoxFit.cover),
      ),
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 70.0,
            backgroundImage: AssetImage("assets/images/farmlord.png"),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'INVITE YOUR FRIENDS',
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            'Help others to put addvertisement for their land and to buy land',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 60),
          Text(
            'Download Now....',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'www.farmlord/apk/download',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
