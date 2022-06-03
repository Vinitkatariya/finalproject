import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_auth/screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/screens/profile/account.dart';
import 'package:flutter_auth/screens/profile/help.dart';
import 'package:flutter_auth/screens/profile/invite.dart';
import 'package:flutter_auth/screens/profile/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:profile_app_ui/constants.dart';
//import 'package:profile_app_ui/widgets/profile_list_item.dart';
import 'package:flutter_auth/config/cons.dart';
//import 'cons.dart';
import 'package:flutter_auth/screens/profile/profilecom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic screenWidth = MediaQuery.of(context).size.width;
    dynamic screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(
      context,
     // deviceSize: Size(screenWidth, screenHeight),
      designSize: const Size(360, 690),
      //orientation: Orientation.portrait,
    );
    // ScreenUtil.init(BoxConstraints());

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          // Container(
          //   height: kSpacingUnit.w * 10,
          //   width: kSpacingUnit.w * 10,
          //   margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
          //   child: Stack(
          //     children: <Widget>[
          //       CircleAvatar(
          //         radius: kSpacingUnit.w * 5,
          //         backgroundImage: AssetImage('assets/images/profile.png'),
          //       ),
          //
          //     ],
          //   ),
          // ),
          SizedBox(height: kSpacingUnit.w * 2),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/farmlord.png'),
            radius: 80,
          ),
          // SizedBox(height: kSpacingUnit.w * 0.5),
          // Text(
          //   'nicolasadams@gmail.com',
          //   style: kCaptionTextStyle,
          // ),
          SizedBox(height: kSpacingUnit.w * 2),
          // Container(
          //   height: kSpacingUnit.w * 4,
          //   width: kSpacingUnit.w * 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          //     color: Theme.of(context).accentColor,
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Upgrade to PRO',
          //       style: kButtonTextStyle,
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
          ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        // Icon(
        //   LineAwesomeIcons.arrow_left,
        //   size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        // ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Account();
                            }),
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.user,
                          text: 'Account',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Language();
                            }),
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.language,
                          text: 'Language',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Help();
                            }),
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Help & Support',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Invite();
                            }),
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.user_plus,
                          text: 'Invite a Friend',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.remove('email');
                          _auth.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return WelcomeScreen();
                              },
                            ),
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          hasNavigation: false,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
