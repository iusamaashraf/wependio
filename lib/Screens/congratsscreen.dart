import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/toggledarkmodescreen.dart';
import 'package:wependio/Screens/uploadprofilepicture.dart';
import 'package:wependio/constants.dart';

class Congratsscreen extends StatefulWidget {
  const Congratsscreen({Key? key}) : super(key: key);

  @override
  _CongratsscreenState createState() => _CongratsscreenState();
}

class _CongratsscreenState extends State<Congratsscreen> {
  int _currentIndex = 0;
  List images = [
    "Assets/Images/img1.jpg",
    "Assets/Images/img2.jpg",
    "Assets/Images/img3.jpg",
  ];
  List darkimages = [
    "Assets/Images/img1b.png",
    "Assets/Images/img2b.png",
    "Assets/Images/img3b.png",
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (mounted) {
        setState(() {
          if (_currentIndex + 1 == images.length) {
            _currentIndex = 0;
          } else {
            _currentIndex = _currentIndex + 1;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: Image.asset(
                AdaptiveTheme.of(context).brightness == Brightness.light
                    ? images[_currentIndex]
                    : darkimages[_currentIndex],
                key: ValueKey<int>(_currentIndex),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Positioned(
          //   top: 20,
          //   right: 20,
          //   child: SafeArea(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         // Navigator.push(context,
          //         //     MaterialPageRoute(builder: (context) {
          //         //   return Loginscreen();
          //         // }));
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8),
          //         child: Text(
          //           "Skip",
          //           style: TextStyle(
          //               fontFamily: "greycliffcf",
          //               fontWeight: FontWeight.w600,
          //               color: Colors.white),
          //         ),
          //       ),
          //       style: ButtonStyle(
          //         elevation: MaterialStateProperty.all<double>(0),
          //         backgroundColor: MaterialStateProperty.all<Color>(
          //             AdaptiveTheme.of(context).brightness == Brightness.light
          //                 ? maincolor
          //                 : Colors.transparent),
          //         shape: MaterialStateProperty.all<OutlinedBorder>(
          //           RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             side: BorderSide(
          //               width: 1.0,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      "Assets/Images/wependiosmall.png",
                      height: 133,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Congrats!",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Your E-Mail Address is successfully\n confirmed, and now you can join the great\n world of wependio.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: appMainFont,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Colors.white),
                      primary: AdaptiveTheme.of(context).brightness ==
                              Brightness.light
                          ? Color(0xff575E68).withOpacity(.8)
                          : Color(0xff101520)),
                  onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return const Uploadpicture();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Finalize your wependio profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: workSansSemibold,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                  // style: ButtonStyle(
                  //   elevation: MaterialStateProperty.all<double>(0),
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       Colors.black.withOpacity(0.5)),
                  //   // shape: MaterialStateProperty.all<OutlinedBorder>(
                  //   //   RoundedRectangleBorder(
                  //   //     borderRadius: BorderRadius.circular(10),
                  //   //     // side: BorderSide(
                  //   //     //   width: 1.0,
                  //   //     //   color: Colors.red,

                  //   //     //   borderRadius: BorderRadius.circular(5.0),
                  //   //     // ),
                  //   //   ),
                  //   // ),
                  // ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip for Now",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: appMainFont,
                          fontSize: 14,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
