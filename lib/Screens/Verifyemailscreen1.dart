import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/Emailverifiedscreen.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/forgotpasswordscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/apis/resendemail.dart';
import 'package:wependio/apis/verifyemail.dart';
import 'package:wependio/constants.dart';
import 'package:widget_loading/widget_loading.dart';

import '../main.dart';

class Verifyemailscreen1 extends StatefulWidget {
  const Verifyemailscreen1({Key? key}) : super(key: key);

  @override
  _Verifyemailscreen1State createState() => _Verifyemailscreen1State();
}

class _Verifyemailscreen1State extends State<Verifyemailscreen1> {
  //Variables
  bool loading = false;
  TextEditingController code = TextEditingController();
  //API Calls
  ///
  checkotp(BuildContext context) async {
    setState(() {
      loading = true;
    });
    verifyUser(code: code.text).then((value) async {
      print(value);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('verified', value['user']['email_verified_at']);
      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Emailverifiedscreen();
      }));
    });
  }

  //Other Functions
  ///
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      //   child: SizedBox(
      //     width: MediaQuery.of(context).size.width,
      //     child: ElevatedButton(
      //       onPressed: () {},
      //       child: Padding(
      //         padding: const EdgeInsets.all(15),
      //         child: Text(
      //           "Next",
      //           style: TextStyle(
      //             fontFamily: "greycliffcf",
      //             fontWeight: FontWeight.w100,
      //             fontSize: 18,
      //           ),
      //         ),
      //       ),
      //       style: ButtonStyle(
      //         shape: MaterialStateProperty.all<OutlinedBorder>(
      //           RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //             // side: BorderSide(
      //             //   width: 1.0,
      //             //   color: Colors.red,

      //             //   borderRadius: BorderRadius.circular(5.0),
      //             // ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: CircularWidgetLoading(
        dotColor: AdaptiveTheme.of(context).brightness == Brightness.dark
            ? maincolordark
            : maincolor,
        loading: loading,
        child: Padding(
          padding: EdgeInsets.only(bottom: Adaptive.h(9), left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: Adaptive.h(12),
              ),
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
                height: Adaptive.h(22),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0))
                    ]),
                child: CircleAvatar(
                  backgroundColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff45454D),
                  radius: 30,
                  child: SvgPicture.asset(
                    "Assets/Images/email.svg",
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white,
                    height: 50,
                  ),
                ),
              ),
              Text(
                "Please insert\n your code here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white,
                    fontSize: Adaptive.px(35),
                    fontFamily: appMainFont),
              ),
              SizedBox(
                height: Adaptive.h(5),
              ),
              // Text(
              //   "Enter the confirmation code we sent to ${emailv}",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.grey,
              //   ),
              // style: TextStyle(
              //   color: maincolor,
              // ),
              //),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: OtpTextField(
                  numberOfFields: 4,

                  borderColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : maincolor,
                  cursorColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                  enabledBorderColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                  focusedBorderColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  styles: [
                    TextStyle(
                        fontSize: 20,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                    TextStyle(
                        fontSize: 20,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                    TextStyle(
                        fontSize: 20,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                    TextStyle(
                        fontSize: 20,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                  ],
                  showFieldAsBox: false,
                  borderWidth: 2.0,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here if necessary
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    code.text = verificationCode;
                  },
                ),
              ),
              SizedBox(
                height: Adaptive.h(4),
              ),
              TextButton(
                  onPressed: () {
                    resendEmail();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Got no email? ',
                      style: TextStyle(
                          color: hintTextColor, fontFamily: workSansRegular),
                      children: [
                        TextSpan(
                          text: ' Send Again',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: appMainFont,
                            fontSize: Adaptive.px(12),
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : mainTextColor,
                          ),
                        ),
                      ],
                    ),
                  )),
              const Spacer(),
              CommonButton(
                  onTap: () {
                    checkotp(context);
                  },
                  title: 'Continue')
            ],
          ),
        ),
      ),
    );
  }
}
