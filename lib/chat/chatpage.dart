import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final senderName;
  final myId;
  final userId;
  final chatDocId;
  ChatPage(this.senderName,this.myId, this.userId, this.chatDocId);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _controller = TextEditingController();

  Future<void> printChats() async {
    final _fireStore = FirebaseFirestore.instance;

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore
        .collection('CHATS')
        .doc(widget.chatDocId)
        .collection("Messages")
        .get();
    for (var doc in querySnapshot.docs) {
      print(doc.get("message"));
    }
  }

  Future<void> addMessage(String message) async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore
        .collection("CHATS")
        .doc(widget.chatDocId)
        .collection("Messages")
        .add({
      "sendby": widget.myId,
      "sendto": widget.userId,
      "message": message,
      "timestamp": FieldValue.serverTimestamp(),
    });
    await printChats();
  }

  Widget _onPressed1() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("CHATS")
          .doc(widget.chatDocId)
          .collection("Messages")
          .orderBy('timestamp')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
                child: new Container(
              child: Text("fetching chats"),
            ));
          default:
            return new ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.fromLTRB(6, 6, 30, 6),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 8, bottom: 8, right: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.docs[index]['sendby'].toString() ==
                                  widget.myId
                              ? "Me"
                              : widget.senderName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Colors.pinkAccent),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            snapshot.data.docs[index]['message'].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.myId);
    print(widget.userId);
    print(widget.chatDocId);
    printChats();
  }

  @override
  Widget build(BuildContext context) {
    _sendMessageArea() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              iconSize: 25,
              color: Colors.green,
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message..',
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Colors.green,
              onPressed: () async {
                await addMessage(_controller.text);
                _controller.clear();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.green),
              height: 40,
              width: 40,
              child: Center(child: Text(widget.senderName[0].toString().toUpperCase())),
            ),
            SizedBox(
              width: 20,
            ),
            Text(widget.senderName)
          ],
        ),
      ),
      body: Container(
        child: Column(

          children: <Widget>[
            Expanded(child: _onPressed1()),

            _sendMessageArea(),
          ],
        ),
      ),
    );
  }
}
