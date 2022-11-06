import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/Textfieldwidget.dart';
import '../constants.dart';

class Changepasswordscreen extends StatefulWidget {
  const Changepasswordscreen({Key? key}) : super(key: key);

  @override
  State<Changepasswordscreen> createState() => _ChangepasswordscreenState();
}

class _ChangepasswordscreenState extends State<Changepasswordscreen> {
  bool showcurrentpassword = false;
  bool showpassword = false;
  bool showrepeatpassword = false;
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
          "Change Password",
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
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Customtextfield(
              password: showcurrentpassword,
              trailingwidget: GestureDetector(
                onTap: () {
                  setState(() {
                    showcurrentpassword = !showcurrentpassword;
                  });
                },
                child: Icon(
                  showcurrentpassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/password.svg",
                  height: 24,
                  width: 24,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              labeltext: "Current Password",
            ),
            SizedBox(
              height: 30,
            ),
            Customtextfield(
              password: showrepeatpassword,
              trailingwidget: GestureDetector(
                onTap: () {
                  setState(() {
                    showrepeatpassword = !showrepeatpassword;
                  });
                },
                child: Icon(
                  showrepeatpassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/key.svg",
                  height: 24,
                  width: 24,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              labeltext: "New Password",
            ),
            Text("Must be at least 8 charcters."),
            SizedBox(
              height: 30,
            ),
            Customtextfield(
              password: showrepeatpassword,
              trailingwidget: GestureDetector(
                onTap: () {
                  setState(() {
                    showrepeatpassword = !showrepeatpassword;
                  });
                },
                child: Icon(
                  showrepeatpassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "Assets/Images/repeatpassword.svg",
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                ),
              ),
              labeltext: "Repeat Password",
            ),
            Text("Both password must watch"),
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
                  "Reset Password",
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
