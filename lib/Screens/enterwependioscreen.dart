// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wependio/Screens/loginscreen.dart';
import 'package:wependio/constants.dart';

class Enterwependioscreen extends StatefulWidget {
  const Enterwependioscreen({Key? key}) : super(key: key);

  @override
  _EnterwependioscreenState createState() => _EnterwependioscreenState();
}

class _EnterwependioscreenState extends State<Enterwependioscreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("Assets/Images/wepvideo.mp4")
      // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize().then((value) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          !_controller.value.isInitialized
              ? Container()
              : SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/Images/wependiosmall.png",
                height: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "board your horizon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: SafeArea(
              child:
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return Loginscreen();
                  //     }));
                  //   },
                  //   child: Container(
                  //     child: Container(
                  //       // padding: EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         // border: Border.all(
                  //         //   color: Colors.white,
                  //         //   width: 4,
                  //         // ),
                  //       ),
                  //       clipBehavior: Clip.antiAlias,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(15),
                  //         child: Text(
                  //           "Enter Wependio",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               fontFamily: "greycliffcf",
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 18,
                  //               color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: AdaptiveTheme.of(context).brightness ==
                  //               Brightness.dark
                  //           ? Colors.black.withOpacity(0.5)
                  //           : Colors.white.withOpacity(0.2),
                  //       border: Border.all(
                  //         color: Colors.white,
                  //         width: 2,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                clipBehavior: Clip.antiAlias,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Loginscreen();
                  }));
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Enter Wependio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "greycliffcf",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AdaptiveTheme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.white.withOpacity(0.1),
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.white,
                        //  borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //FURTHER IMPLEMENTATION
        ],
      ),
    );
  }
}
