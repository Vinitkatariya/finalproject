import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_auth/chat/chatpage.dart';


class Temp extends StatefulWidget {
  final List entries;
  final Map groups;
  @override
  _TempState createState() => _TempState();

  Temp(this.entries, this.groups);
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: widget.entries.length,
//   itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatPage(widget.groups[widget.entries[index].toString()][0],widget.groups[widget.entries[index].toString()][1], widget.groups[widget.entries[index].toString()][2], widget.groups[widget.entries[index].toString()][3]);
                  // return ChatPage(widget.entries[index], widget.groups[widget.entries[index]]);
                }));
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
//             backgroundColor:,
                        width: 50.0,
                        height: 50.0,
                        child: Center(
                          child: Text(
                            '${widget.groups[widget.entries[index].toString()][0][0].toUpperCase()}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          color: Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
//           height: 50,
//       color: Colors.amber[colorCodes[index]],
                              child: Text(
                                '${widget.groups[widget.entries[index].toString()][0]}',
                                style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4,
//                             fontFamily:
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
//                           Container(
// //           height: 50,
// //       color: Colors.amber[colorCodes[index]],
//                             child: Text('${desc[index]}'),
//                           ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black26,
                    indent: 60,
                    endIndent: 10,
                    thickness: 0.4,
                  ),
                ],
              ),
            ),
          );
        });
  }
}