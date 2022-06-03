import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/chat/chatpage.dart';
import 'package:flutter_auth/chat/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_auth/chat/chat_screen.dart';

class Detail extends StatefulWidget {
  final url;
  final price;
  final area;
  final city;
  final taluka;
  final district;
  final description;
  final fname;
  final lname;
  final mobile;
  final List images;
  final id;
  final String userId;

  Detail(
      this.url,
      this.price,
      this.area,
      this.city,
      this.taluka,
      this.district,
      this.description,
      this.fname,
      this.lname,
      this.mobile,
      this.images,
      this.id,
      this.userId);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<String> x = [];
  String chatDocId;



  
  Future<void> addChat(String myId,String userId) async{

    final _fireStore = FirebaseFirestore.instance;

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('CHATS').get();
    bool a=false;
    String temp;
    for(var doc in querySnapshot.docs){
      if((myId==doc.get("myId") && userId==doc.get("senderId")) || (userId==doc.get("myId") && myId==doc.get("senderId"))){
        a=true;
        temp=doc.id;
        break;
      }
    }
    final CollectionReference chatCollection = FirebaseFirestore.instance.collection("CHATS");

    if(a==false){
      DocumentReference chatRef = await chatCollection.add({
        "myId":myId,
        "senderId":userId
      });
      await chatRef.update({
        "people":FieldValue.arrayUnion([userId])
      });
      chatDocId=chatRef.id;

    }else{
      await chatCollection.doc(temp).update({
        "people":FieldValue.arrayUnion([userId])
      });
      chatDocId=temp;
    }

  }
  
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff57C84D),
          onPressed: () async {
            Toast.show(
              "Added To Favorite!!!",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              textColor: Colors.white,
              backgroundRadius: 24,
              backgroundColor: Colors.black,
            );

            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getStringList('favorit') == null) {
              prefs.setStringList('favorit', ['${widget.id}']);
            } else {
              x = prefs.getStringList('favorit');
              x.add(widget.id);
              prefs.setStringList('favorit', x);
            }
          },
          child: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: width,
                child: Image(
                  image: NetworkImage(
                    '${widget.url}',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 35, 0, 0),
                child: Text(
                  'Farm Details',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 0, 10),
                    child: Card(
                      elevation: 20,
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: width / 2 - 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: Center(
                            child: Text(
                              '₹' + '${widget.price}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 0, 10),
                    child: Card(
                      elevation: 20,
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: width / 2 - 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: Center(
                            child: Text(
                              'Acre ' + '${widget.area}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 30, 10),
                child: Text(
                  '${widget.city}, ' +
                      '${widget.taluka}, ' +
                      '${widget.district}.',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 0, 0),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 20, 0),
                child: Text(
                  '${widget.description}',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 300.0,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${widget.images[index]}'),
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 0, 10),
                child: Text(
                  'Contact Details',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 60,
                    width: width - 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff83D475),
                              Color(0xffC5E8B7),
                              Color(0xffC5E8B7),
                              Color(0xff83D475),

                              // Color(0xff57C84D),
                            ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 6, 0, 6),
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 6, 0, 6),
                          child: Text(
                            'Owner: ' + '${widget.fname} ' + '${widget.lname}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launch("tel://" + "${widget.mobile}");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 10),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 60,
                      width: width - 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff83D475),
                                Color(0xffC5E8B7),
                                Color(0xffC5E8B7),
                                Color(0xff83D475),

                                // Color(0xff57C84D),
                              ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 0, 6),
                            child: Icon(
                              Icons.phone,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 6, 0, 6),
                            child: Text(
                              '+91 ' + '${widget.mobile}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String userId = prefs.getString("userId");

                  // chat -> myid -> people ->userid
                  // chat -> user -> people ->my
                  
                  
                  // User user = new User();
                  await addChat(userId,widget.userId);
                  await addChat(widget.userId, userId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ChatPage(widget.fname+" "+widget.lname,userId,widget.userId,chatDocId);
                    }),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 30),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 60,
                      width: width - 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff83D475),
                                Color(0xffC5E8B7),
                                Color(0xffC5E8B7),
                                Color(0xff83D475),

                                // Color(0xff57C84D),
                              ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 0, 6),
                            child: Icon(
                              Icons.message_sharp,
                              size: 30,
                            )       ,                  ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 6, 0, 6),
                            child: Text(
                              'Chat Now',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,

                              ),


                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
