import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/config/cons.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}
class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(child: TextField(
      obscureText: _isHidden,
      onChanged: widget.onChanged,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: "Password",
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: InkWell(
          onTap: _togglePasswordView,
          child: Icon(Icons.visibility),
        ),
        border: InputBorder.none,
      ),
    ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
