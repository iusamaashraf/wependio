import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/Verifyemailscreen1.dart';
import 'package:wependio/Screens/forgotpasswordscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/apis/resendemail.dart';
import 'package:wependio/constants.dart';

class Verifyemailscreen extends StatefulWidget {
  const Verifyemailscreen({Key? key}) : super(key: key);

  @override
  _VerifyemailscreenState createState() => _VerifyemailscreenState();
}

class _VerifyemailscreenState extends State<Verifyemailscreen> {
  bool showpassword = false;
  bool remember = false;

  showbar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AdaptiveTheme.of(context).brightness == Brightness.dark
            ? maincolordark
            : maincolor,
        content: Text(
          text,
          style: TextStyle(
              color: AdaptiveTheme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resendEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Adaptive.h(20), left: Adaptive.w(13), right: Adaptive.w(13)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Spacer(),
            // CircleAvatar(
            //   child: SvgPicture.asset(
            //     "Assets/Images/email.svg",
            //     height: 60,
            //     color:
            //         AdaptiveTheme.of(context).brightness == Brightness.light
            //             ? maincolor
            //             : Colors.white,
            //   ),
            //   backgroundColor:
            //       AdaptiveTheme.of(context).brightness == Brightness.light
            //           ? Colors.white
            //           : Color(0xff555555),
            //   radius: 70,
            // ),
            Container(
              width: 170,
              height: Adaptive.h(21),
              //  margin: EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0))
                  ]),
              child: CircleAvatar(
                child: SvgPicture.asset(
                  "Assets/Images/email.svg",
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? mainTextColor
                          : Colors.white,
                  height: Adaptive.h(6.2),
                ),
                backgroundColor:
                    AdaptiveTheme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Color(0xff45454D),
                radius: 50,
              ),
            ),
            SizedBox(
              height: Adaptive.h(3.8),
            ),
            Text(
              "Verify your\n email address",
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontWeight: FontWeight.w900,
                fontFamily: appMainFont,
                fontSize: Adaptive.px(35),
              ),
            ),
            // const Spacer(),
            SizedBox(
              height: Adaptive.h(20.3),
            ),

            CommonButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Verifyemailscreen1();
                  }));
                },
                title: "Send verification code"),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       primary:
            //           AdaptiveTheme.of(context).brightness == Brightness.light
            //               ? mainBtnColor
            //               : btnDarkBgColor,
            //       side: BorderSide(
            //           color: AdaptiveTheme.of(context).brightness ==
            //                   Brightness.light
            //               ? mainTextColor
            //               : Colors.white,
            //           width: 2)),
            //   onPressed: () {

            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Text(
            //       "Send verification code",
            //       style: TextStyle(
            //         fontFamily: workSansSemibold,
            //         // fontWeight: FontWeight.w100,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            //   // style: ButtonStyle(
            //   //   elevation: MaterialStateProperty.all<double>(0),
            //   //   shape: MaterialStateProperty.all<OutlinedBorder>(
            //   //     RoundedRectangleBorder(
            //   //       borderRadius: BorderRadius.circular(10),
            //   //       // side: BorderSide(
            //   //       //   width: 1.0,
            //   //       //   color: Colors.red,

            //   //       //   borderRadius: BorderRadius.circular(5.0),
            //   //       // ),
            //   //     ),
            //   //   ),
            //   // ),
            // ),

            SizedBox(
              height: Adaptive.h(2.3),
            ),
            TextButton(
                onPressed: () {
                  resendEmail().then((value) {
                    if (value['message'] == null) {
                      print(value);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Verifyemailscreen1();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Verifyemailscreen1();
                      }));
                      showbar(value['message'], context);
                    }
                  });
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Did not recieve? ',
                    style: TextStyle(
                        color: hintTextColor, fontFamily: workSansRegular),
                    children: [
                      TextSpan(
                        text: ' Send Again',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: appMainFont,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.dark
                              ? Colors.white
                              : maincolor,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
