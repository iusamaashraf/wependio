import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/Signupscreen2.dart';
import 'package:wependio/Screens/Verifyemailscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/constants.dart';

class Signupscreen1 extends StatefulWidget {
  const Signupscreen1({Key? key}) : super(key: key);

  @override
  _Signupscreenscreen1State createState() => _Signupscreenscreen1State();
}

class _Signupscreenscreen1State extends State<Signupscreen1> {
  bool showpassword = false;
  bool showrepeatpassword = false;
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      //backgroundColor: Color(0xFF0C0D0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // title: Text("Sign Up"),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SvgPicture.asset(
                        "Assets/Images/s2.svg",
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Text(
                        //"Sign up \\\\\\\\n to get started!",
                        "Second Step",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tell us your Full Name,Gender and Birthday",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Customtextfield(
                        labeltext: "Full Name",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Customtextfield(
                        labeltext: "Gender",
                        trailingwidget: Icon(
                          Icons.keyboard_arrow_down,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? maincolor
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Customtextfield(
                        labeltext: "Set Birthday",
                        trailingwidget: Icon(
                          Icons.keyboard_arrow_down,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? maincolor
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "User must be over 16 years of age",
                        textAlign: TextAlign.end,
                      ),
                      Spacer(),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Signupscreen2();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontFamily: "greycliffcf",
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


// https://restcountries.com/v2/all