import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'description_page.dart';

class Add_Bar extends StatefulWidget {
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

  Add_Bar(
      this.id,
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
      this.userId);

  @override
  _Add_BarState createState() => _Add_BarState();
}

class _Add_BarState extends State<Add_Bar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Detail(
              widget.url,
              widget.price,
              widget.area,
              widget.city,
              widget.taluka,
              widget.district,
              widget.description,
              widget.fname,
              widget.lname,
              widget.mobile,
              widget.images,
              widget.id,
          widget.userId);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 16),
          elevation: 15,

          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.yellow,
          //   border: Border.all(
          //     color: Colors.black12,
          //     width: 1,
          //   ),
          //   gradient: LinearGradient(
          //     colors: [Colors.white70, Colors.black12, Colors.white24],
          //   ),
          // ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: width - 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "₹ " + '${widget.price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage('${widget.url}'),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    ), //decorationimage
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Address : ' + '${widget.city}' + ',',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.taluka}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: Text(
                    //     "Owner: " + '${widget.fname}' + ' ' + '${widget.lname}',
                    //     textAlign: TextAlign.start,
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        '${'Acre : ' + widget.area}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
