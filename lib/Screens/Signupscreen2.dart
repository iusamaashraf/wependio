import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/Verifyemailscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/constants.dart';

class Signupscreen2 extends StatefulWidget {
  const Signupscreen2({Key? key}) : super(key: key);

  @override
  _Signupscreenscreen2State createState() => _Signupscreenscreen2State();
}

class _Signupscreenscreen2State extends State<Signupscreen2> {
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
                        "Assets/Images/s3.svg",
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Text(
                        //"Sign up \\\\\\\\n to get started!",
                        "Last Step",
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
                        "Please tell us your Origin and Email Address",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Customtextfield(
                              labeltext: "Country",
                              trailingwidget: Icon(
                                Icons.keyboard_arrow_down,
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? maincolor
                                    : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Customtextfield(
                              labeltext: "Zip Code",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Customtextfield(
                        labeltext: "Residental Address",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Customtextfield(
                        labeltext: "Email",
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                fillColor: MaterialStateProperty.all(maincolor),
                                side: BorderSide(
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
                          Expanded(
                            child: Text(
                              "Send me updates from wependio with tailored offers and information.",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Verifyemailscreen();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: "greycliffcf",
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "By signing up, you agree to our Terms. Learn how we collect, use and share your data in our Privacy Policy and how we use cookies and similar technology in our Cookies Policy. ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
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