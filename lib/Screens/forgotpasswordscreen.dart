import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/constants.dart';

class Forgotpasswordscreen extends StatefulWidget {
  const Forgotpasswordscreen({Key? key}) : super(key: key);

  @override
  _ForgotpasswordscreenState createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  bool showpassword = false;
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffF7F9FD),
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // CircleAvatar(
                //   child: Image.asset(
                //     "Assets/Images/wependiosmall.png",
                //     height: 80,
                //   ),
                //   backgroundColor: Colors.white,
                //   radius: 70,
                // ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Let\'s Recover \n your account",
                    // style: TextStyle(
                    //   color: Colors.grey,
                    // ),
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily: "greycliffcf",
                      fontWeight: FontWeight.w900,
                      fontSize: 38,
                      color: maincolor,
                    ),
                    // children: [
                    //   // TextSpan(
                    //   //   text: '',
                    //   //   style: TextStyle(
                    //   //     fontWeight: FontWeight.w500,
                    //   //     color: maincolor,
                    //   //   ),
                    //   // ),
                    // ],
                  ),
                ),
                // Text(
                //   "Let\'s Recover \n your account",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w900,
                //     fontSize: 45,
                //     color: maincolor,
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                Customtextfield(
                  leadingwidget: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "Assets/Images/email.svg",
                      height: 24,
                      width: 24,
                    ),
                  ),
                  labeltext: "Enter your email",
                ),
                SizedBox(
                  height: 30,
                ),

                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return Loginscreen();
                    // }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Send Code",
                      style: TextStyle(
                        fontFamily: "greycliffcf",
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        // side: BorderSide(
                        //   width: 1.0,
                        //   color: Colors.red,

                        //   borderRadius: BorderRadius.circular(5.0),
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Login with one of the following options",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: 150,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.black),
                //       child: Padding(
                //         padding: const EdgeInsets.all(10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               "Assets/Images/apple.png",
                //               color: Colors.white,
                //               height: 30,
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               "Apple",
                //               style: TextStyle(
                //                 color: Colors.white,
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 30,
                //     ),
                //     Container(
                //       width: 150,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.blue.withOpacity(0.8),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               "Assets/Images/google.png",
                //               color: Colors.white,
                //               height: 30,
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               "Google",
                //               style: TextStyle(
                //                 color: Colors.white,
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// https://restcountries.com/v2/all