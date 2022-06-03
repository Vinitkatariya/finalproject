import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/components/rounded_email.dart';
import 'package:flutter_auth/components/rounded_mobile_number.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SBody extends StatefulWidget {
    @override
    _SBodyState createState() => _SBodyState();
  }
class _SBodyState extends State<SBody>{
  //static String id = 'sign_up';
  String fname,lname,email,password,phone;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RoundedInputField(
              hintText: "First Name",
              onChanged: (value) {
                fname = value;
              },
            ),
            RoundedInputField(
              hintText: "Last Name",
              onChanged: (value) {
                lname = value;
              },
            ),
            RoundedMobileNumber(
              hintText: "Your Mobile Number",
              onChanged: (value) {
                phone=value;
                if(phone.length<10)
                  {
                    return 'Please enter 10 digit mobile number.';
                  }
              },
            ),
            RoundedEmail(
              hintText: "Your Email",
              onChanged: (value) {
                email=value;
                if(!value.contains('@'))
                  {
                    return 'Please enter a valid email.';
                  }
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password=value;
                if(password.length<6)
                {
                  return 'Password must be at least 6 characters.';
                }
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    _firestore.collection('Profile').add({
                      'fname': fname,
                      'lname': lname,
                      'phone': phone,
                      'email': email,
                      'password': password,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  }
                }catch (e) {
                  print(e);
                }
              }
              ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
              ],
            ),
           ),
          );
      }
}
