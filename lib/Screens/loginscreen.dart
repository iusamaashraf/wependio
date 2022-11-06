import 'dart:io';
import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/forgotpasswordscreen.dart';
import 'package:wependio/Screens/mainhomescreen.dart';
import 'package:wependio/Screens/uploadprofilepicture.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/apis/login.dart';
import 'package:wependio/constants.dart';
import 'package:widget_loading/widget_loading.dart';

import '../main.dart';
import 'Verifyemailscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  //Variables
  bool showpassword = true;
  bool remember = false;
  bool loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ///APIs Functions

  login(BuildContext context) async {
    setState(() {
      loading = true;
    });

    loginUser(email: email.text, password: password.text)
        .then((responsex) async {
      setState(
        () {
          loading = false;
        },
      );
      if (responsex['message'] == null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", responsex["token"]);
        prefs.setString("name", responsex["user"]["name"]);
        prefs.setString("email", responsex["user"]["email"]);

        token = responsex["token"];
        namev = responsex["user"]["name"];
        emailv = responsex["user"]["email"];
        if (responsex["user"]["email_verified_at"] == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Verifyemailscreen();
              },
            ),
          );
        } else {
          if (responsex["user"]["profile_picture"] == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Uploadpicture();
                },
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Mainhomescreen(
                    isDialogShow: false,
                  );
                },
              ),
            );
          }
        }
      } else {
        showbar(responsex['message'], context);
      }
    });
  }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(14.25)),
        child: CircularWidgetLoading(
          dotColor: AdaptiveTheme.of(context).brightness == Brightness.dark
              ? maincolordark
              : maincolor,
          loading: loading,
          child: FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Adaptive.h(6.5),
                ),
                Container(
                  width: Adaptive.w(47.2),
                  height: Adaptive.h(15.8),
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 0))
                      ]),
                  child: CircleAvatar(
                    child: Image.asset(
                      "Assets/Images/wependiosmall.png",
                      color: AdaptiveTheme.of(context).brightness ==
                              Brightness.light
                          ? maincolor
                          : Colors.white,
                      height: Adaptive.h(10.4),
                    ),
                    backgroundColor:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xff555555),
                    radius: 50,
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(4),
                ),

                Container(
                  //  margin: EdgeInsets.symmetric(vertical: size.height * 0.004),
                  child: Text(
                    "Lets get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //fontWeight: FontWeight.w900,
                      color: AdaptiveTheme.of(context).brightness ==
                              Brightness.light
                          ? mainTextColor
                          : Colors.white,
                      fontSize: Adaptive.px(35),
                      fontFamily: 'greycliffcf',

                      // color: maincolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(7.75),
                ),
                Container(
                  //   margin: EdgeInsets.only(top: size.height * 0.025),
                  child: Column(
                    children: [
                      Customtextfield(
                        fillcolor: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : Colors.transparent,
                        controller: email,
                        textinputAction: TextInputAction.next,
                        leadingwidget: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            "Assets/Images/email.svg",
                            height: 0,
                            width: 0,
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? mainTextColor
                                : Colors.white,
                          ),
                        ),
                        labeltext: "Enter your email",
                      ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      SizedBox(
                        height: Adaptive.h(2.7),
                      ),
                      Customtextfield(
                        fillcolor: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : Colors.transparent,
                        controller: password,
                        password: showpassword,
                        textinputAction: TextInputAction.done,
                        trailingwidget: GestureDetector(
                          onTap: () {
                            setState(() {
                              showpassword = !showpassword;
                            });
                          },
                          child: Icon(
                            showpassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: hintTextColor,
                          ),
                        ),
                        leadingwidget: Padding(
                          padding: EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            "Assets/Images/password.svg",
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? mainTextColor
                                : Colors.white,
                            height: Adaptive.h(2.2),
                          ),
                        ),
                        labeltext: "Password",
                      ),
                      SizedBox(
                        height: Adaptive.h(2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: Adaptive.h(2.6),
                                width: Adaptive.w(6),
                                child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.all(maincolor),
                                    side: const BorderSide(
                                      color: Color(
                                          0xffD0D0D0), //your desire colour here
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    value: remember,
                                    onChanged: (value) {
                                      remember = value!;
                                      setState(() {});
                                    }),
                              ),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                    fontSize: Adaptive.px(12),
                                    color: hintTextColor,
                                    fontFamily: nunitoSansRegular),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Forgotpasswordscreen();
                              }));
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontSize: Adaptive.px(12),
                                  fontFamily: nunitoSansRegular,
                                  color: mainTextColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(2),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: CommonButton(
                            onTap: () {
                              login(context);
                            },
                            title: "Sign In"),
                      ),
                      // SizedBox(
                      //   width: size.width,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         primary: AdaptiveTheme.of(context).brightness ==
                      //                 Brightness.light
                      //             ? mainBtnColor
                      //             : btnDarkBgColor,
                      //         side: BorderSide(
                      //           width: 2.0,
                      //           color: AdaptiveTheme.of(context).brightness ==
                      //                   Brightness.light
                      //               ? mainTextColor
                      //               : Colors.white,
                      //         )),
                      //     onPressed: () {
                      //       login(context);

                      //       // Navigator.push(context,
                      //       //     MaterialPageRoute(builder: (context) {
                      //       //   return Mainhomescreen();
                      //       // }));
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(20),
                      //       child: Text(
                      //         "Sign In",
                      //         style: TextStyle(
                      //           fontFamily: "greycliffcf",
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //     ),
                      //     // style: ButtonStyle(
                      //     //   elevation: MaterialStateProperty.all<double>(0),
                      //     //   shape: MaterialStateProperty.all<OutlinedBorder>(
                      //     //     RoundedRectangleBorder(
                      //     //       borderRadius: BorderRadius.circular(10),
                      //     //       // side: BorderSide(
                      //     //       //   width: 1.0,
                      //     //       //   color: Colors.red,

                      //     //       //   borderRadius: BorderRadius.circular(5.0),
                      //     //       // ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      SizedBox(
                        height: Adaptive.h(2),
                      ),
                      Container(
                        // margin:
                        //     EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Adaptive.w(17),
                              height: .3,
                              color: lightTextGrey,
                            ),
                            Container(
                              //  padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Or Continue with",
                                style: TextStyle(
                                    color: hintTextColor,
                                    fontFamily: workSansRegular,
                                    fontSize: size.height * 0.018),
                              ),
                            ),
                            Container(
                              width: Adaptive.w(17),
                              height: .3,
                              color: lightTextGrey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                // Text(
                //   "Login with one of the following options",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Adaptive.w(32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black
                              : Color(0xff555555)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Adaptive.h(1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "Assets/Images/apple.png",
                              color: Colors.white,
                              height: 30,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            const Text(
                              "Apple",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: size.width * 0.1,
                    // ),
                    Container(
                      width: Adaptive.w(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.withOpacity(0.8),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Adaptive.h(1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "Assets/Images/google.png",
                              color: Colors.white,
                              height: 30,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            const Text(
                              "Google",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Signupscreen();
                        }));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t Have an Account?',
                          style: TextStyle(
                            color: hintTextColor,
                            fontFamily: workSansRegular,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: appMainFont,
                                  fontSize: Adaptive.px(14),
                                  color: mainTextColor),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
