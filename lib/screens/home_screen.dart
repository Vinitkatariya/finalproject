import 'package:flutter/material.dart';
import 'package:flutter_auth/config/palette.dart';
import 'package:flutter_auth/config/styles.dart';
import 'package:flutter_auth/screens/home/Equipments/Renteq/Renteq.dart';
import 'package:flutter_auth/screens/home/Equipments/Selleq/Selleq.dart';
//import 'package:farmland/data/data.dart';
import 'package:flutter_auth/widgets/widgets.dart';
import 'package:flutter_auth/screens/home/Farmland//Sell/Sell.dart';
import 'package:flutter_auth/screens/home/Farmland/Rent/Rent.dart';
import 'package:flutter_auth/screens/home/Farmland/Batai/Batai.dart';
import 'package:flutter_auth/chat/chat.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffC5E8B7),
            Color(0xffC5E8B7),
            Color(0xff83D475),
            Color(0xff83D475),
            Color(0xff57C84D),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: 290,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      // color: Palette.appbar,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'FARMLAND',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Chat();
                                  }),
                                );
                              },
                              child: Icon(
                                   Icons.chat,
                                size: 35,
                              ),
                            ),
                            // Icon(
                            //       Icons.chat,
                            //       size: 35,
                            //     ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Are you searching for Land?',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'If you wanna buy, sell, rent or wants to do batai , please go for below listed option',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            // SizedBox(height: screenHeight * 0.01),
                          ],
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget>[
                              SizedBox(
                                width:10,
                              ),
                              Sell(),
                              SizedBox(
                                height: 10,width:10,
                              ),
                              Rent(),
                              SizedBox(
                                height: 10,width:10,
                              ),
                              Batai(),
                              SizedBox(
                                height: 40,width:10,
                              ),
                            ]
                        ) ,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    height: 270,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      // color: Palette.appbar,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //SizedBox(height: screenHeight * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Equipment',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Are you searching for Equipments?',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'If you wanna buy,sell,rent your Equipment , please go for below listed option',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            //SizedBox(height: screenHeight * 0.01),
                          ],
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget>[
                              SizedBox(
                                width:10,
                              ),
                              Selleq(),
                              SizedBox(
                                height: 10,width:10,
                              ),
                              Renteq(),
                              SizedBox(
                                height: 10,width:10,
                              ),

                            ]
                        ) ,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20
              ),
                ],
              )
        ),
      ),
    );
  }
}