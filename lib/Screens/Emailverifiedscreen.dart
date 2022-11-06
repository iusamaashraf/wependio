import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/congratsscreen.dart';
import 'package:wependio/Screens/forgotpasswordscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/constants.dart';

class Emailverifiedscreen extends StatefulWidget {
  const Emailverifiedscreen({Key? key}) : super(key: key);

  @override
  _EmailverifiedscreenState createState() => _EmailverifiedscreenState();
}

class _EmailverifiedscreenState extends State<Emailverifiedscreen> {
  bool showpassword = false;
  bool remember = false;
  bool animate = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      animate = true;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: Adaptive.h(10), left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xff303036),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff47D58E), width: 2),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0))
                    ]),
                width: 170,
                height: Adaptive.h(22),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // const CircleAvatar(
                    //   backgroundColor: Color(0xff47D58E),
                    //   radius: 72,
                    // ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        "Assets/Images/email.svg",
                        height: 70,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? Color(0xff47D58E)
                            : Color(0xff47D58E),
                      ),
                      backgroundColor: AdaptiveTheme.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff303036),
                      radius: 70,
                    ),
                    Positioned(
                      bottom: Adaptive.h(5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          height: animate ? 30 : 0,
                          width: animate ? 30 : 0,
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: AdaptiveTheme.of(context).brightness ==
                            //             Brightness.light
                            //         ? Colors.white
                            //         : Color(0xff555555),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset:
                            //         Offset(0, 3), // changes position of shadow
                            //   ),
                            // ],
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? Colors.white
                                : Color.fromARGB(255, 63, 63, 63),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: 20,
                            height: Adaptive.h(5),
                            decoration: BoxDecoration(
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xff1B1B1F),
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 0))
                                ]),
                            child: Icon(
                              Icons.check,
                              color: Color(0xff47D58E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: Adaptive.h(5),
              ),

              Text(
                "Successfully\n Verified",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Adaptive.px(35),
                    fontFamily: appMainFont,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white),
              ),
              const Spacer(),
              CommonButton(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Congratsscreen();
                    }));
                  },
                  title: 'Continue'),
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

              // TextButton(
              //     onPressed: () {
              //   // Navigator.push(context,
              //   //     MaterialPageRoute(builder: (context) {
              //   //   return Signupscreen();
              //   // }));
              // },
              //     child: RichText(
              //       text: TextSpan(
              //         text: 'Got no email? ',
              //         style: TextStyle(
              //           color: Colors.grey,
              //         ),
              //         children: [
              //           TextSpan(
              //             text: ' Send Again',
              //             style: TextStyle(
              //               fontWeight: FontWeight.w500,
              //               fontFamily: "greycliffcf",
              //               color: maincolor,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
