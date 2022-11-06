import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/changeemailscreen.dart';
import 'package:wependio/Screens/changepasswordscreen.dart';

import '../Widgets/Textfieldwidget.dart';
import '../constants.dart';

class Securityscreen extends StatelessWidget {
  const Securityscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(MediaQuery.of(context).size.width, 10)),
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(
          "Security",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        // leadingWidth: 50,
        backgroundColor:
            AdaptiveTheme.of(context).theme.brightness == Brightness.light
                ? maincolor
                : Color(0xff4F5666),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "Assets/Images/message.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/notification.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/add.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Change password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Changepasswordscreen();
                }));
              },
              child: Customtextfield(
                enabled: false,
                trailingwidget: Icon(
                  Icons.arrow_forward_ios,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
                leadingwidget: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "Assets/Images/password.svg",
                    height: 18,
                    width: 18,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
                labeltext: "Password",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Change Email Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Changeemailscreen();
                    },
                  ),
                );
              },
              child: Customtextfield(
                enabled: false,
                trailingwidget: Icon(
                  Icons.arrow_forward_ios,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
                leadingwidget: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "Assets/Images/email.svg",
                    height: 18,
                    width: 18,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
                labeltext: "Email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
