import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/mapscreen.dart';
import 'package:wependio/Screens/postmainscreen..dart';
import 'package:wependio/Screens/profilemainscreen.dart';
import 'package:wependio/constants.dart';

class Mainhomescreen extends StatefulWidget {
  bool isDialogShow;
  Mainhomescreen({Key? key, required this.isDialogShow}) : super(key: key);

  @override
  _MainhomescreenState createState() => _MainhomescreenState();
}

class _MainhomescreenState extends State<Mainhomescreen> {
  int currentindex = 0;

  List<Widget> widgets = [
    Mapscreen(),
    Postsmainscreen(),
    Mapscreen(),
    Mapscreen(),
    Profilemainscreen(
      me: true,
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 0, color: Colors.transparent)),
              backgroundColor:
                  AdaptiveTheme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Color(0xff1B1B1F),
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              content: Container(
                height: MediaQuery.of(context).size.height * .40,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xff1B1B1F)),
                width: MediaQuery.of(context).size.width * .80,
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        alignment: Alignment.topRight,
                        child: Icon(Icons.cancel_outlined,
                            size: 30,
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? mainTextColor
                                : Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xffFAFAFD)
                                    : Color(0xff39393E),
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 0)),
                                ],
                              )),
                          Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xff47D58E),
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xC5C5C5FF),
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 0)),
                                ],
                              ),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: appMainFont,
                          fontWeight: FontWeight.w900,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? mainTextColor
                              : Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "The great world of wependio is waiting for you!",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: appMainFont,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? mainTextColor
                              : Colors.white.withOpacity(.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AdaptiveTheme.of(context).brightness ==
                                      Brightness.light
                                  ? mainBtnColor
                                  : btnDarkBgColor,
                              side: BorderSide(
                                width: 2.0,
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? mainTextColor
                                    : Colors.white,
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontFamily: "greycliffcf",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              actions: <Widget>[],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 75,
        animationDuration: Duration(
          milliseconds: 300,
        ),
        backgroundColor: Colors.transparent,

        // buttonBackgroundColor: Colors.white,
        //animationCurve: Curves.bounceOut,
        color: AdaptiveTheme.of(context).theme.brightness == Brightness.light
            ? maincolor
            : Color(0xff4F5666),
        items: <Widget>[
          Icon(
            Icons.star_border_outlined,
            color: Colors.white,
          ),
          SvgPicture.asset(
            "Assets/Images/people.svg",
            height: 24,
            width: 24,
            color: Colors.white,
          ),
          SvgPicture.asset(
            "Assets/Images/globe.svg",
            height: 24,
            width: 24,
            color: Colors.white,
          ),
          Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
          // ImageIcon(
          //   AssetImage("Assets/Images/search.png"),
          //   color: Colors.white,
          //   // currentindex == 3
          //   //     ? AdaptiveTheme.of(context).theme.brightness == Brightness.light
          //   //         ? maincolor
          //   //         : Color(0xff4F5666)
          //   //     : Colors.white,
          // ),
          SvgPicture.asset(
            "Assets/Images/options.svg",
            height: 24,
            width: 24,
            color: Colors.white,
          ),
        ],
        onTap: (indexx) {
          currentindex = indexx;
          setState(() {});
          //Handle button tap
        },
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            fillColor: Colors.transparent,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: widgets[currentindex],
      ),
    );
  }
}

void showAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text("hi"),
          ));
}
