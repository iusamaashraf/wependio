import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';

import '../constants.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

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
          "Logout",
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 130,
              width: 130,
              child: Icon(
                Icons.logout_outlined,
                color: AdaptiveTheme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : maincolor,
                size: 50,
              ),
              decoration: BoxDecoration(
                color: AdaptiveTheme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xff555555),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Text(
                "Are you sure you want to log out?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "greycliffcf",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              // style: ButtonStyle(
              //   elevation: MaterialStateProperty.all<double>(0),
              //   shape: MaterialStateProperty.all<OutlinedBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       // side: BorderSide(
              //       //   width: 1.0,
              //       //   color: Colors.red,

              //       //   borderRadius: BorderRadius.circular(5.0),
              //       // ),
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
