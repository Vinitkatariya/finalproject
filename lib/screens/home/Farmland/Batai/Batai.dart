import 'package:flutter_auth/screens/home/Farmland/Batai/searchbatai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/config/palette.dart';
import 'searchbatai.dart';

class Batai extends StatefulWidget {
  @override
  _BataiState createState() => _BataiState();
}

class _BataiState extends State<Batai> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SearchBatai();
          }),
        );
      },
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/batai.jpg'),
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          height: 200,
          width: screenWidth - 60,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                  )),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Flexible(
                    child: Text(
                      "BATAI",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      //softWrap: true,
                      style: TextStyle(
                          fontSize: 40,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
