import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:wependio/Screens/mainhomescreen.dart';

import '../Widgets/Textfieldwidget.dart';
import '../constants.dart';

class Connectwependioscreen extends StatefulWidget {
  const Connectwependioscreen({Key? key}) : super(key: key);

  @override
  _ConnectwependioscreenState createState() => _ConnectwependioscreenState();
}

class _ConnectwependioscreenState extends State<Connectwependioscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return Loginscreen();
                // }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontFamily: "greycliffcf",
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(
                    AdaptiveTheme.of(context).brightness == Brightness.light
                        ? maincolor
                        : Colors.transparent),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Connect \n Wependio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "You can automatically find persons who are using wependio too. Just connect with one or more of the social media platforms shown below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "Assets/Images/facebook.png",
                          color: Colors.white,
                        ),
                      ),
                      height: 100,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xff5378FE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "Assets/Images/instagram.png",
                          color: Colors.white,
                        ),
                      ),
                      height: 100,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xffE54673),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "Assets/Images/tiktok.png",
                          color: Colors.white,
                        ),
                      ),
                      height: 100,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "Assets/Images/pin.png",
                          color: Colors.white,
                        ),
                      ),
                      height: 100,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xffBD081C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Mainhomescreen(isDialogShow: false,);
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: "greycliffcf",
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              // style: ButtonStyle(
              //   elevation: MaterialStateProperty.all<double>(0),
              //   shape: MaterialStateProperty.all<OutlinedBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
            ),
            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
    );
  }
}
