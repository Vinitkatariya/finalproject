import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> with SingleTickerProviderStateMixin {
  bool _status = true;
  final _firestore = FirebaseFirestore.instance;
  final FocusNode myFocusNode = FocusNode();
  String name = " ";
  String email = " ";
  String Mobile = " ";
  Future<void> temp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await _firestore.collection('Profile').get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (prefs.getString('email').toString() == result.data()['email']) {
            name = result.data()['fname'].toString() +
                ' ' +
                result.data()['lname'].toString();
            email = result.data()['email'];
            Mobile = result.data()['phone'];
          }
        });
      });
      setState(() {
        // print(name);
        // print(email);
        // print(Mobile);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 250.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: new Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 22.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: new Text('PROFILE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                      /* Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )*/
                      /*Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),*/
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 71,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 69,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                                // backgroundColor: ColorsConsts.gradiendFEnd,
                                // backgroundImage:
                                //     _image == null ? null : FileImage(_image),
                              ),
                            ),
                          ),
                          // Positioned(
                          //     top: 120,
                          //     left: 110,
                          //     child: RawMaterialButton(
                          //       elevation: 10,
                          //       fillColor: Colors.teal,
                          //       child: Icon(Icons.add_a_photo),
                          //       padding: EdgeInsets.all(15.0),
                          //       shape: CircleBorder(),
                          //       onPressed: () {
                          //         showDialog(
                          //             context: context,
                          //             builder: (BuildContext context) {
                          //               return AlertDialog(
                          //                 title: Text(
                          //                   'Choose option',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.w600,
                          //                       color: Colors.teal),
                          //                 ),
                          //                 content: SingleChildScrollView(
                          //                   child: ListBody(
                          //                     children: [
                          //                       InkWell(
                          //                         onTap: getImage(
                          //                             ImageSource.camera),
                          //                         splashColor:
                          //                             Colors.purpleAccent,
                          //                         child: Row(
                          //                           children: [
                          //                             Padding(
                          //                               padding:
                          //                                   const EdgeInsets
                          //                                       .all(8.0),
                          //                               child: Icon(
                          //                                 Icons.camera,
                          //                                 color: Colors
                          //                                     .purpleAccent,
                          //                               ),
                          //                             ),
                          //                             Text(
                          //                               'Camera',
                          //                               style: TextStyle(
                          //                                   fontSize: 18,
                          //                                   fontWeight:
                          //                                       FontWeight.w500,
                          //                                   color:
                          //                                       Colors.black),
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       InkWell(
                          //                         onTap: getImage(
                          //                             ImageSource.gallery),
                          //                         splashColor:
                          //                             Colors.purpleAccent,
                          //                         child: Row(
                          //                           children: [
                          //                             Padding(
                          //                               padding:
                          //                                   const EdgeInsets
                          //                                       .all(8.0),
                          //                               child: Icon(
                          //                                 Icons.image,
                          //                                 color: Colors
                          //                                     .purpleAccent,
                          //                               ),
                          //                             ),
                          //                             Text(
                          //                               'Gallery',
                          //                               style: TextStyle(
                          //                                   fontSize: 18,
                          //                                   fontWeight:
                          //                                       FontWeight.w500,
                          //                                   color:
                          //                                       Colors.black),
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       /*InkWell(
                          //                       onTap: _remove,
                          //                       splashColor:
                          //                           Colors.purpleAccent,
                          //                       child: Row(
                          //                         children: [
                          //                           Padding(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     8.0),
                          //                             child: Icon(
                          //                               Icons.remove_circle,
                          //                               color: Colors.red,
                          //                             ),
                          //                           ),
                          //                           Text(
                          //                             'Remove',
                          //                             style: TextStyle(
                          //                                 fontSize: 18,
                          //                                 fontWeight:
                          //                                     FontWeight.w500,
                          //                                 color: Colors.red),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),*/
                          //                     ],
                          //                   ),
                          //                 ),
                          //               );
                          //             });
                          //       },
                          //     ))
                        ],
                      ),
                    ],
                  ),
                ),
                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Personal Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                // child: new TextField(
                                //   decoration: const InputDecoration(
                                //     hintText: "Enter Your Name",
                                //   ),
                                //   enabled: !_status,
                                //   autofocus: !_status,
                                // ),
                                //
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Email ID',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: Text(
                                    Mobile,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )),

                        // Padding(
                        //     padding: EdgeInsets.only(
                        //         left: 25.0, right: 25.0, top: 25.0),
                        //     child: new Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: <Widget>[
                        //         Expanded(
                        //           child: Container(
                        //             child: new Text(
                        //               'Pin Code',
                        //               style: TextStyle(
                        //                   fontSize: 16.0,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //           flex: 2,
                        //         ),
                        //         Expanded(
                        //           child: Container(
                        //             child: new Text(
                        //               'State',
                        //               style: TextStyle(
                        //                   fontSize: 16.0,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //           flex: 2,
                        //         ),
                        //       ],
                        //     )),
                        // Padding(
                        //     padding: EdgeInsets.only(
                        //         left: 25.0, right: 25.0, top: 2.0),
                        //     child: new Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: <Widget>[
                        //         Flexible(
                        //           child: Padding(
                        //             padding: EdgeInsets.only(right: 10.0),
                        //             child: new TextField(
                        //               decoration: const InputDecoration(
                        //                   hintText: "Enter Pin Code"),
                        //               enabled: !_status,
                        //             ),
                        //           ),
                        //           flex: 2,
                        //         ),
                        //         Flexible(
                        //           child: new TextField(
                        //             decoration: const InputDecoration(
                        //                 hintText: "Enter State"),
                        //             enabled: !_status,
                        //           ),
                        //           flex: 2,
                        //         ),
                        //       ],
                        //     )),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }*/

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
