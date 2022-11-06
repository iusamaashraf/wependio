import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/Verifyemailscreen.dart';
import 'package:wependio/Screens/enterwependioscreen.dart';
import 'package:wependio/Screens/favouriteplaces.dart';
import 'package:wependio/Screens/loginscreen.dart';
import 'package:wependio/Screens/toggledarkmodescreen.dart';
import 'package:wependio/Screens/uploadprofilepicture.dart';

import '../constants.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool changesize = false;
  bool changeside = false;
  bool showtext = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        changesize = true;
      });
      Future.delayed(
          const Duration(
            milliseconds: 500,
          ), () {
        setState(() {
          changeside = true;
        });
      }).then((value) {
        Future.delayed(
            const Duration(
              milliseconds: 500,
            ), () {
          setState(() {
            showtext = true;
          });
        }).then((value) {
          Future.delayed(
              const Duration(
                seconds: 2,
              ), () {
            checkToken();
          });
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? verified = prefs.getString('verified');
    String? picture = prefs.getString('picture');
    if (token != null) {
      if (verified != null) {
        if (picture != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const Favouriteplaces();
          }));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const Uploadpicture();
          }));
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Verifyemailscreen();
            },
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Toggledarkmodescreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : const Color(0xff1B1B1F),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 500),
            //   height: changesize ? 100 : 70,
            //   width: changesize ? 100 : 70,
            //   decoration: BoxDecoration(
            //       image: AdaptiveTheme.of(context).brightness ==
            //               Brightness.light
            //           ? DecorationImage(
            //               image: AssetImage("Assets/Images/wependiologo1.png"),
            //             )
            //           : DecorationImage(
            //               image:
            //                   AssetImage("Assets/Images/wependiologowhite.png"),
            //             )),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  alignment:
                      changeside ? Alignment.centerLeft : Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: changesize ? 100 : 70,
                    width: changesize ? 100 : 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? const AssetImage(
                                "Assets/Images/wependiologo1.png")
                            : const AssetImage(
                                "Assets/Images/wependiologowhite.png"),
                      ),
                    ),
                  ),
                ),
                if (showtext)
                  FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 500),
                      height: 150,
                      placeholder: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? const AssetImage(
                              "Assets/Images/whitebg.png",
                            )
                          : const AssetImage("Assets/Images/darkbg.png"),
                      image: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? AssetImage(
                              "Assets/Images/wependiologo2.png",
                            )
                          : AssetImage("Assets/Images/whitewependio.png"),
                      width: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
