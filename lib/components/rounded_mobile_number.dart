import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/config/cons.dart';

class RoundedMobileNumber extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const RoundedMobileNumber({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
