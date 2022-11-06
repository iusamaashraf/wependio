import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/Textfieldwidget.dart';
import '../constants.dart';

class Changeemailscreen extends StatefulWidget {
  const Changeemailscreen({Key? key}) : super(key: key);

  @override
  State<Changeemailscreen> createState() => _ChangeemailscreenState();
}

class _ChangeemailscreenState extends State<Changeemailscreen> {
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
          "Change Email",
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
                  "message.svg",
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
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Customtextfield(
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/email.svg",
                  height: 20,
                  width: 20,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.black,
                ),
              ),
              labeltext: "Current Email",
            ),
            SizedBox(
              height: 30,
            ),
            Customtextfield(
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/repeatpassword.svg",
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.black,
                ),
              ),
              labeltext: "Repeat Password",
            ),
            SizedBox(
              height: 30,
            ),
            Customtextfield(
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/repeatpassword.svg",
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.black,
                ),
              ),
              labeltext: "Repeat Password",
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return Verifyemailscreen();
                // }));
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Update",
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
