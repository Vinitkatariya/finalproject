import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_auth/config/formconst.dart';
import 'package:flutter_auth/post_add.dart';
import 'package:flutter_auth/config/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key key}) : super(key: key);

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  
  SharedPreferences prefs;
  Future<void> getpref()async{
    prefs = 
        await SharedPreferences.getInstance();
    setState(() {
      
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpref();
  }
  
  final networkHandler = NetworkHandler();
  List<File> _images = [];
  File _image;

  Future<void> _pickImage(ImageSource source) async {
    File selected = (await ImagePicker().pickImage(source: source)) as File;
    setState(() {
      try {
        _images.add(selected);
      } catch (e) {
        print(e);
      }
    });
  }

  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  // DropdownMenuItem _menu = DropdownMenuItem();
  TextEditingController _taluka = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pin = TextEditingController();
  TextEditingController _area = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<String> _locations = ['Sell', 'Rent', 'Batai','EquipmentSell','EquipmentRent']; // Option 2
  List<String> _temp = ['Sell', 'Rent', 'Batai']; // Option 2

  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            Text(
              'Add Advertise',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton(
              isExpanded: true,
              hint: Text(
                'Please select Category',
                style: TextStyle(fontSize: 20),
              ), // Not necessary for Option 1
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                 // ++ print(_selectedLocation);
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            //  imageProfile(),
            SizedBox(
              height: 15,
            ),
            cityTextField(),
            SizedBox(
              height: 15,
            ),
            talukaTextField(),
            SizedBox(
              height: 15,
            ),
            districtTextField(),
            SizedBox(
              height: 15,
            ),
            // dobField(),
            // SizedBox(
            //   height: 20,
            // ),
            pinTextField(),
            SizedBox(
              height: 15,
            ),
            priceTextField(),
            SizedBox(
              height: 15,
            ),
            mobileTextField(),
            SizedBox(
              height: 15,
            ),
            _selectedLocation==null || _temp.contains(_selectedLocation)? areaTextField():quantityTextField(),
            SizedBox(
              height: 15,
            ),
            aboutTextField(),
            SizedBox(
              height: 15,
            ),

            // _images.length == 0
            //     ? Container(
            //         width: double.infinity,
            //         height: 200.0,
            //         margin: EdgeInsets.only(bottom: 20.0),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.grey[400])),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('No image selected.'),
            //             FlatButton(
            //               color: Colors.black,
            //               onPressed: () async =>
            //                   _pickImage(ImageSource.gallery),
            //               child: Text(
            //                 "Add New Photos",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     : Column(
            //         children: <Widget>[
            //           Container(
            //             padding: EdgeInsets.all(20.0),
            //             child: FlatButton(
            //               color: Colors.black,
            //               onPressed: () async =>
            //                   _pickImage(ImageSource.gallery),
            //               child: Text(
            //                 "Add New Photos",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ),
            //           Stack(
            //             children: <Widget>[
            //               Container(
            //                 height: 180.0,
            //                 child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   padding: EdgeInsets.all(10.0),
            //                   itemCount: _images.length,
            //                   itemBuilder: (BuildContext context, int index) {
            //                     return Stack(
            //                       children: <Widget>[
            //                         Image.file(
            //                           _images[index],
            //                         ),
            //                         Container(
            //                           width: 180.0,
            //                           height: 50.0,
            //                           color: Colors.black45,
            //                         ),
            //                         Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceAround,
            //                           children: <Widget>[
            //                             SizedBox(
            //                               width: 10.0,
            //                             ),
            //                             index == 0
            //                                 ? Text(
            //                                     "Main Photo",
            //                                     style: TextStyle(
            //                                         color: Colors.white,
            //                                         fontWeight:
            //                                             FontWeight.w600),
            //                                   )
            //                                 : Text(""),
            //                             SizedBox(
            //                               width: 30.0,
            //                             ),
            //                             IconButton(
            //                               icon: Icon(
            //                                 Icons.cancel,
            //                                 color: Colors.white70,
            //                               ),
            //                               onPressed: () => setState(() {
            //                                 _images.removeAt(index);
            //                               }),
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     );
            //                   },
            //                 ),
            //               ),
            //               Positioned(
            //                   right: 0.0,
            //                   top: 30.0,
            //                   child: IconButton(
            //                       icon: Icon(
            //                         Icons.arrow_right,
            //                         color: Colors.black,
            //                         size: 80.0,
            //                       ),
            //                       onPressed: null)),
            //             ],
            //           ),
            //         ],
            //       ),

            InkWell(
              // onTap: () async {
              //   setState(() {
              //     circular = true;
              //   });
              //   if (_globalkey.currentState.validate()) {
              //     Map<String, String> data = {
              //       // "menu" : _menu.text;
              //       "city": _city.text,
              //       "taluka": _taluka.text,
              //       "district": _district.text,
              //       "pin": _pin.text,
              //       "price": _price.text,
              //       "mobile": _mobile.text,
              //       //"mobile":
              //
              //       "area": _area.text,
              //       "about": _about.text,
              //     };
              //     var response =
              //         await networkHandler.post("/profile/add", data);
              //     if (response.statusCode == 200 ||
              //         response.statusCode == 201) {
              //       if (_imageFile.path != null) {
              //         var imageResponse = await networkHandler.patchImage(
              //             "/profile/add/image", _imageFile.path);
              //         if (imageResponse.statusCode == 200) {
              //           setState(() {
              //             circular = false;
              //           });
              //           Navigator.of(context).pushAndRemoveUntil(
              //               MaterialPageRoute(builder: (context) => Scaffold()),
              //               (route) => false);
              //         }
              //       } else {
              //         setState(() {
              //           circular = false;
              //         });
              //         Navigator.of(context).pushAndRemoveUntil(
              //             MaterialPageRoute(builder: (context) => Scaffold()),
              //             (route) => false);
              //       }
              //     }
              //   }
              // },
              child: GestureDetector(
                onTap: () {
                  if (_globalkey.currentState.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return Post_Add(

                            type: _selectedLocation,
                            city: _city.text,
                            taluka: _taluka.text,
                            district: _district.text,
                            pincode: _pin.text,
                            price: _price.text,
                            mobile: _mobile.text,
                            area: _area.text,
                            description: _about.text,
                            userId: prefs.get("userId"),
                          );
                        }));
                  }
                },
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Palette.btn1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: //circular
                      //     ? CircularProgressIndicator()
                      //     :
                      Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/profile.jpeg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget talukaTextField() {
    return TextFormField(
      controller: _taluka,
      validator: (value) {
        if (value.isEmpty) return "Taluka can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.location_on_sharp,
          color: Palette.btn1,
        ),
        labelText: "Taluka",
        helperText: "Taluka can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }

  Widget mobileTextField() {
    return TextFormField(
      controller: _mobile,
      validator: (value) {
        if (value.isEmpty) return "Mobile Number can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.call,
          color: Palette.btn1,
        ),
        labelText: "Mobile Number",
        helperText: "Mobile Number can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }

  Widget districtTextField() {
    return TextFormField(
      controller: _district,
      validator: (value) {
        if (value.isEmpty) return "District can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.location_on_sharp,
          color: Palette.btn1,
        ),
        labelText: "District",
        helperText: "District can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }

  Widget cityTextField() {
    return TextFormField(
      controller: _city,
      validator: (value) {
        if (value.isEmpty) return "City can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.location_city_outlined,
          color: Palette.btn1,
        ),
        labelText: "City",
        helperText: "City can't be empty",
        // hintText: "Full Stack Developer",
      ),
    );
  }

  // Widget dobField() {
  //   return TextFormField(
  //     controller: _dob,
  //     validator: (value) {
  //       if (value.isEmpty) return "DOB can't be empty";
  //
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //           borderSide: BorderSide(
  //         color: Colors.teal,
  //       )),
  //       focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //         color: Colors.orange,
  //         width: 2,
  //       )),
  //       prefixIcon: Icon(
  //         Icons.person,
  //         color: Colors.green,
  //       ),
  //       labelText: "Date Of Birth",
  //       helperText: "Provide DOB on dd/mm/yyyy",
  //       hintText: "01/01/2020",
  //     ),
  //   );
  // }

  Widget pinTextField() {
    return TextFormField(
      controller: _pin,
      // validator: (value) {
      //   if (value.isEmpty) return "Title can't be empty";
      //
      //   return null;
      // },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.pin_drop_sharp,
          color: Palette.btn1,
        ),
        labelText: "Pin Code",
        // helperText: "It can't be empty",
        // hintText: "Flutter Developer",
      ),
    );
  }

  Widget areaTextField() {
    return TextFormField(
      controller: _area,
      validator: (value) {
        if (value.isEmpty) return "Plot Area can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.a,
        //   color: Colors.teal,
        // ),
        labelText: "Plot Area in acres",
        helperText: "Plot Area can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }
  Widget quantityTextField() {
    return TextFormField(
      controller: _area,
      validator: (value) {
        if (value.isEmpty) return "This can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.a,
        //   color: Colors.teal,
        // ),
        labelText: "Number of equipment",
        helperText: "This can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }

  Widget priceTextField() {
    return TextFormField(
      controller: _price,
      validator: (value) {
        if (value.isEmpty) return "Price can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.btn1,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.filter_vintage_sharp,
          color: Palette.btn1,
        ),
        labelText: "Price",
        helperText: "Price can't be empty",
        //  hintText: "Dev Stack",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        if (value.isEmpty) return "About can't be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),

        labelText: "About your land",
        helperText: "Write about your land",
        // hintText: "I am Dev Stack",
      ),
    );
  }
}