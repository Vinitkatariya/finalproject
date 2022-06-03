import 'package:flutter/material.dart';
//import 'package:feedback_collection/www/github/com/mrutyunjayagiri/utils/validator.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final double minValue = 8.0;
  final _feedbackTypeList = <String>["Comments", "Bugs", "Questions"];

  String _feedbackType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildHeader(), _buildContent()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          vertical: minValue * 4, horizontal: minValue * 3),
      height: 260.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: minValue * 2,
            ),
            Text(
              "Write Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.0,
                  color: Colors.white),
            ),
            SizedBox(
              width: 110.0,
              child: Container(
                height: 6,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: minValue * 4,
            ),
            Text(
              "Feel free to write us. We will get back to you as soon as we can.",
              style: TextStyle(fontSize: 16.0, color: Colors.grey[200]),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: Colors.black87),
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Select feedback type",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(
            height: minValue * 2,
          ),
          Row(
            children: <Widget>[
              Radio<String>(
                  value: 'COMMENT',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Comments'),
              SizedBox(
                width: minValue,
              ),
              Radio<String>(
                  value: 'BUG',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Bug Reports'),
              SizedBox(
                width: minValue,
              ),
              Radio<String>(
                  value: 'QUESTION',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Questiions')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _nameController,
        // validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            // errorStyle: _errorStyle,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            hintText: 'Full Name',
            labelText: 'Full  Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        // validator: validateEmail,
        onChanged: (String value) {},
        readOnly: true,
        decoration: InputDecoration(
            //   errorStyle: _errorStyle,
            border: UnderlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            // errorStyle: _errorStyle,
            labelText: 'Description',
            contentPadding: EdgeInsets.symmetric(horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      width: double.maxFinite,
      child: RaisedButton(
        onPressed: () => null,
        padding: EdgeInsets.symmetric(vertical: minValue * 2),
        elevation: 0.0,
        color: Colors.black87,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildCategory(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildName(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildEmail(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildDescription(),
          SizedBox(
            height: minValue * 6,
          ),
          _buildSubmitBtn()
        ],
      ),
    );
  }
}

/*class FormThree extends StatefulWidget {
  @override
  _FormThreeState createState() => _FormThreeState();
}

class _FormThreeState extends State<FormThree> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final double minValue = 8.0;
  final _feedbackTypeList = <String>["Comments", "Bugs", "Questions"];

  String _feedbackType = "";

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  void _onCreated() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    _feedbackType = _feedbackTypeList[0];
    _onCreated();
    super.initState();
  }

  Widget _buildHeader() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          vertical: minValue * 4, horizontal: minValue * 3),
      height: 260.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: minValue * 2,
            ),
            Text(
              "Write Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.0,
                  color: Colors.white),
            ),
            SizedBox(
              width: 110.0,
              child: Container(
                height: 6,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: minValue * 4,
            ),
            Text(
              "Feel free to write us. We will get back to you as soon as we can.",
              style: TextStyle(fontSize: 16.0, color: Colors.grey[200]),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: Colors.black87),
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Select feedback type",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(
            height: minValue * 2,
          ),
          Row(
            children: <Widget>[
              Radio<String>(
                  value: 'COMMENT',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Comments'),
              SizedBox(
                width: minValue,
              ),
              Radio<String>(
                  value: 'BUG',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Bug Reports'),
              SizedBox(
                width: minValue,
              ),
              Radio<String>(
                  value: 'QUESTION',
                  groupValue: _feedbackType,
                  onChanged: (String v) {
                    setState(() {
                      _feedbackType = v;
                    });
                  }),
              Text('Questiions')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _nameController,
        validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            hintText: 'Full Name',
            labelText: 'Full  Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        validator: validateEmail,
        onChanged: (String value) {},
        readOnly: true,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: UnderlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            labelText: 'Description',
            contentPadding: EdgeInsets.symmetric(horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      width: double.maxFinite,
      child: RaisedButton(
        onPressed: () => null,
        padding: EdgeInsets.symmetric(vertical: minValue * 2),
        elevation: 0.0,
        color: Colors.black87,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildCategory(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildName(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildEmail(),
          SizedBox(
            height: minValue * 3,
          ),
          _buildDescription(),
          SizedBox(
            height: minValue * 6,
          ),
          _buildSubmitBtn()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_buildHeader(), _buildContent()],
        ),
      ),
    );
  }
}*/
