import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/Splashscreen.dart';
import 'package:wependio/Screens/loginscreen.dart';
import 'package:wependio/Screens/uploadprofilepicture.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/constants.dart';

class Toggledarkmodescreen extends StatefulWidget {
  const Toggledarkmodescreen({Key? key}) : super(key: key);

  @override
  _ToggledarkmodescreenState createState() => _ToggledarkmodescreenState();
}

class _ToggledarkmodescreenState extends State<Toggledarkmodescreen> {
  int value = 0;
  //bool positive = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor:
      //     MediaQuery.of(context).platformBrightness == Brightness.light
      //         ? Colors.white
      //         : const Color(0xff1B1B1F),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     vertical: 40,
      //     horizontal: 30,
      //   ),
      //   child: SizedBox(
      //     width: MediaQuery.of(context).size.width,
      //     child: ElevatedButton(
      //       onPressed: () {
      //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //         //   return Congratsscreen();
      //         // }));
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(15),
      //         child: Text(
      //           "Continue",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Adaptive.w(14.25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            // CircleAvatar(
            //   child: Image.asset(
            //     "Assets/Images/wependiosmall.png",
            //     height: 80,
            //     color:
            //         AdaptiveTheme.of(context).brightness == Brightness.light
            //             ? maincolor
            //             : Colors.black,
            //   ),
            //   backgroundColor: Colors.white,
            //   radius: 70,
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            //  Spacer(),
            SizedBox(
              height: Adaptive.h(22.27),
            ),
            Container(
              width: Adaptive.w(53.04),
              height: Adaptive.h(21.717),
              // margin: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.35),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 0))
              ]),
              child: CircleAvatar(
                backgroundColor:
                    AdaptiveTheme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color(0xff363843),
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
            SizedBox(
              height: Adaptive.h(7.06),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedToggleSwitch<bool>.dual(
                  indicatorSize: Size(Adaptive.w(15), Adaptive.w(10)),
                  current:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? false
                          : true,
                  first: false,
                  second: true,
                  dif: 0.0,
                  borderColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.white,
                  borderWidth: 2.0,
                  height: Adaptive.h(5),
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                  onChanged: (b) async {
                    print(b);
                    b ? value = 1 : value = 0;
                    setState(() {});

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // setState(() => positive = b);
                    if (b == true) {
                      prefs.setString("theme", "dark");
                      // ignore: use_build_context_synchronously
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      prefs.setString("theme", "light");
                      // ignore: use_build_context_synchronously
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                  colorBuilder: (b) => b ? Colors.white : mainTextColor,
                  iconBuilder: (value) => value
                      ? SvgPicture.asset(
                          "Assets/Images/dark.svg",
                          height: Adaptive.h(3),
                          width: Adaptive.w(3),
                          color: Colors.black,
                        )
                      : SvgPicture.asset(
                          "Assets/Images/light.svg",
                          height: Adaptive.h(3),
                          width: Adaptive.w(3),
                          color: Colors.white,
                        ),
                ),
              ],
            ),
            SizedBox(
              height: Adaptive.h(4.58),
            ),
            SizedBox(
              child: Text(
                value == 0 ? "On the Lightside?" : "On the Darkside!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    // fontWeight: FontWeight.w700,
                    fontSize: Adaptive.px(35),
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white,
                    fontFamily: appMainFont),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Adaptive.h(1.52)),
              child: Text(
                "For the best User Experience we would\n recommend using wependio in Lightmode.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white,
                    fontFamily: appMainFont,
                    fontSize: Adaptive.px(13),
                    height: 1.5,
                    fontWeight: FontWeight.w600),
              ),
            ),
            // const Spacer(),
            SizedBox(
              height: Adaptive.h(11.53),
            ),
            CommonButton(
                title: "Continue",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Loginscreen();
                  }));
                }),
            SizedBox(
              height: Adaptive.h(5),
            ),
          ],
        ),
      ),
    );
  }
}
