import 'dart:core';
import 'dart:ffi';
import 'package:flutter_auth/addBar1.dart';
import 'package:flutter_auth/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_auth/screens/home/Farmland/Batai/add_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter_auth/components/rounded_city_field.dart';

class SearchRenteq extends StatefulWidget {
  @override
  _SearchRenteqState createState() => _SearchRenteqState();
}

class _SearchRenteqState extends State<SearchRenteq> {
  final _firestore = FirebaseFirestore.instance;
  int flag = 0;
  List objects = [];

  Future<Void> getAddsOfBatai1(city) async {
    try {
      await _firestore.collection('EquipmentRent').get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          List temp = [];
          if (result.data()['city'].toString().toLowerCase() ==
              city.toString().toLowerCase()) {
            temp.add(result.data()['price']);
            temp.add(result.data()['lname']);
            temp.add(result.data()['fname']);
            temp.add(result.data()['taluka']);
            temp.add(result.data()['city']);
            temp.add(result.data()['area']);
            temp.add(result.data()['imageUrls'][0]);
            temp.add(result.data()['district']);
            temp.add(result.data()['description']);
            temp.add(result.data()['mobile']);
            temp.add(result.data()['imageUrls']);
            temp.add(result.id);
            temp.add(result.data()['userId']);
            objects.add(temp);
          }
        });
      });
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void getAddsOfBatai() async {
    try {
      await _firestore.collection('EquipmentRent').get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          List temp = [];
          temp.add(result.data()['price']);
          temp.add(result.data()['lname']);
          temp.add(result.data()['fname']);
          temp.add(result.data()['taluka']);
          temp.add(result.data()['city']);
          temp.add(result.data()['area']);
          temp.add(result.data()['imageUrls'][0]);
          temp.add(result.data()['district']);
          temp.add(result.data()['description']);
          temp.add(result.data()['mobile']);
          temp.add(result.data()['imageUrls']);
          temp.add(result.id);
          temp.add(result.data()['userId']);
          objects.add(temp);
        });
      });
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddsOfBatai();
  }

  String city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavScreen(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image.asset('assets/among.png',fit: BoxFit.cover,),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              RoundedInputField(
                hintText: "Enter City",
                onChanged: (value) {
                  city = value;
                },
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    objects.clear();
                    if (city == null || city.length == 0) {
                      getAddsOfBatai();
                      flag = 0;
                    } else {
                      getAddsOfBatai1(city);
                      flag = 1;
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      color: Color(0xFFA8F3CD),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.search,
                      size: 30,
                    )),
                  )),
            ]),

            // SizedBox(
            //   height: 200,
            // ),
            objects.length == 0
                ? flag == 1
                    ? Column(
                        children: [
                          SizedBox(
                            height: 150,
                          ),
                          Container(
                            child: Text(
                              'No Adds found for given village!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            '🤔',
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      )
                    : Container(
                        height: 10,
                        width: 10,
                        // child: Text('Search For Land'),
                      )
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: objects.length,
                      itemBuilder: (context, index) {
                        return Add_Bar1(
                            objects[index][11],
                            objects[index][6],
                            objects[index][0],
                            objects[index][5],
                            objects[index][4],
                            objects[index][3],
                            objects[index][7],
                            objects[index][8],
                            objects[index][2],
                            objects[index][1],
                            objects[index][9],
                            objects[index][10],objects[index][12]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
