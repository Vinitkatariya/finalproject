import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_email.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/homepage.dart';
import 'package:flutter_auth/screens/bottom_nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LBody extends StatelessWidget {
  static String id = 'login_screen';
  String email, password, phone;

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            RoundedEmail(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
                if (!value.contains('@')) {
                  return 'Please enter a valid email.';
                }
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
                if (password.length < 6) {
                  return 'Password must be at least 6 characters.';
                }
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    print("Hello");
                    final _fireStore = FirebaseFirestore.instance;

                      // Get docs from collection reference
                      QuerySnapshot querySnapshot = await _fireStore.collection('Profile').get();


                      //for a specific field
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    for(var doc in querySnapshot.docs){
                      if(email==doc.get("email")){
                      prefs.setString("userId", doc.id);
                      }

                    }




                    await prefs.setString('email', email);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BottomNavScreen();
                        },
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
