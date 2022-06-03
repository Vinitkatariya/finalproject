import 'dart:io';
import 'success_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

class Post_Add extends StatefulWidget {
  final String type;
  final String city;
  final String taluka;
  final String district;
  final String pincode;
  final String price;
  final String mobile;
  final String area;
  final String description;
  final String userId;
  Post_Add(
      {@required this.type,
      @required this.city,
      @required this.taluka,
      @required this.district,
      @required this.pincode,
      @required this.price,
      @required this.mobile,
      @required this.area,
      @required this.description,@required this.userId});
  @override
  _Post_AddState createState() => _Post_AddState();
}

class _Post_AddState extends State<Post_Add> {
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Image'),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  setState(() {
                    uploading = true;
                  });
                  uploadFile().whenComplete(() => Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) {
                        return Success();
                      })));
                },
                child: Text(
                  'upload',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    !uploading ? chooseImage() : null),
                          )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                  }),
            ),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  final List imageUrls = [];
  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageUrls.add(value);

          i++;
        });
      });
    }
    await imgRef.add({
      'fname': fname,
      'lname': lname,
      'email': uemail,
      'type_of_add': widget.type,
      'city': widget.city,
      'taluka': widget.taluka,
      'district': widget.district,
      'pincode': widget.pincode,
      'price': widget.price,
      'mobile': widget.mobile,
      'area': widget.area,
      'description': widget.description,
      'imageUrls': imageUrls,
      'userId':widget.userId
    });
    print(imageUrls);
  }

  String uemail = " ";
  String fname = " ";
  String lname = " ";
  String uphone = " ";
  final _firestore = FirebaseFirestore.instance;

  void getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      _firestore.collection("Profile").get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if ((result.data()["email"]) == email) {
            var phone = result.data()["number"];
            var name1 = result.data()["fname"];
            var name2 = result.data()["lname"];
            setState(() {
              uemail = email;
              uphone = phone;
              fname = name1;
              lname = name2;
            });
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    imgRef = FirebaseFirestore.instance.collection(widget.type);
  }
}
