import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/chat/temp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth/chat/models/message_model.dart';
import 'package:flutter_auth/chat/chat_screen.dart';
//import 'package:flutter_auth/chat/palette.dart';


class Chat extends StatefulWidget {


  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {




  List<String> peoples = new List();
  Map groups = new Map();

  Future<void> getMyAndOtherId(String docId) async{
    String myId;
    String otherId;
    final _fireStore = FirebaseFirestore.instance;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    myId=preferences.getString("userId");

    // Get docs from collection reference
    DocumentReference documentReference = await _fireStore.collection('CHATS').doc(docId);
    documentReference.get().then((value) {
      if(myId==value.get("myId")){
        otherId=value.get("senderId");
      }
      if(myId==value.get("senderId")) {
        otherId = value.get("myId");
      }
    }).then((value) async{
      QuerySnapshot querySnapshot = await _fireStore.collection('Profile').get();
      String name;
      for(var doc in querySnapshot.docs){
        if(doc.id==otherId){
          name=doc.get("fname")+" "+doc.get("lname");
          break;
        }
      }
      List<String> t=["","","",""];
      t[0]=name;
      t[1]=myId;
      t[2]=otherId;
      t[3]=docId;
      peoples.add(docId);
      groups[docId]=t;
      // print(t);

      // peoples.add(t);

    });

    }


  Future<void> getPeoples() async{
    String myId;
    final _fireStore = FirebaseFirestore.instance;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    myId=preferences.getString("userId");
    QuerySnapshot querySnapshot = await _fireStore.collection('CHATS').get();
    for(var doc in querySnapshot.docs){
      if(myId==doc.get("myId") || myId==doc.get("senderId")){
        await getMyAndOtherId(doc.id);
      }
    }
    Future.delayed(Duration(seconds: 3), (){
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeoples();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //brightness: Brightness.dark,
        backgroundColor: Colors.green,
        elevation: 8,

        title: Text(
          'Inbox',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child:
          peoples.isNotEmpty?
          Temp(peoples,groups):Container(),
        ),
      ),
    );
  }
}


