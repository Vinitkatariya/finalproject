import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/home/Farmland/Batai/add_bar.dart';
import 'package:toast/toast.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _firestore = FirebaseFirestore.instance;
  Color c1 = Color(0xff57C84D);
  Color c2 = Color(0xFFA8F3CD);
  Color c3 = Color(0xFFA8F3CD);
  Color c4 = Color(0xFFA8F3CD);
  Color c5 = Color(0xFFA8F3CD);

  List arr = [];
  List objects = [];
  Future<void> getAddsOfBatai1(db) async {
    try {
      objects.clear();
      await _firestore.collection(db).get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          List temp = [];
          for (int i = 0; i < arr.length; i++) {
            if (result.id.toString().toLowerCase() ==
                arr[i].toString().toLowerCase()) {
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
          }
        });
      });
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> temp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    arr = prefs.getStringList('favorit');
    print(arr);
    getAddsOfBatai1('Sell');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff57C84D),
        onPressed: () async {
          Toast.show(
            "Favorite Cleared!!!",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            textColor: Colors.white,
            backgroundRadius: 24,
            backgroundColor: Colors.black,
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setStringList('favorit', []);
          await temp();
          setState(() {});
        },
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      c2 = Color(0xFFA8F3CD);
                      c1 = Color(0xff57C84D);
                      c3 = Color(0xFFA8F3CD);
                      c4 = Color(0xFFA8F3CD);
                      c5 = Color(0xFFA8F3CD);
                      getAddsOfBatai1('Sell');
                    },
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: c1,
                      ),
                      child: Center(
                        child: Text('Buy'),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      c1 = Color(0xFFA8F3CD);
                      c2 = Color(0xff57C84D);
                      c3 = Color(0xFFA8F3CD);
                      c4 = Color(0xFFA8F3CD);
                      c5 = Color(0xFFA8F3CD);
                      getAddsOfBatai1('Rent');
                    },
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: c2,
                      ),
                      child: Center(
                        child: Text('Rent'),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      c1 = Color(0xFFA8F3CD);
                      c2 = Color(0xFFA8F3CD);
                      c3 = Color(0xff57C84D);
                      c4 = Color(0xFFA8F3CD);
                      c5 = Color(0xFFA8F3CD);
                      getAddsOfBatai1('Batai');
                    },
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: c3,
                      ),
                      child: Center(
                        child: Text('Batai'),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      print(4);
                      c2 = Color(0xFFA8F3CD);
                      c4 = Color(0xff57C84D);
                      c3 = Color(0xFFA8F3CD);
                      c1 = Color(0xFFA8F3CD);
                      c5 = Color(0xFFA8F3CD);
                      getAddsOfBatai1('+EquipmentRent');
                    },
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: c4,
                      ),
                      child: Center(
                        child: Text('E Rent'),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      print(5);
                      c2 = Color(0xFFA8F3CD);
                      c5 = Color(0xff57C84D);
                      c3 = Color(0xFFA8F3CD);
                      c4 = Color(0xFFA8F3CD);
                      c1 = Color(0xFFA8F3CD);
                      getAddsOfBatai1('EquipmentSell');
                    },
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: c5,
                      ),
                      child: Center(
                        child: Text('E Buy'),
                      ),
                    )),
              ],
            ),
            objects.length == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Container(
                        child: Text(
                          'No Favorites Added!',
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
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: objects.length,
                    itemBuilder: (context, index) {
                      return Add_Bar(
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
          ],
        ),
      ),
    );
  }
}
