// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wependio/Screens/Logoutscreens.dart';
import 'package:wependio/Screens/deleteaccount1.dart';
import 'package:wependio/Screens/memoriesscreen.dart';
import 'package:wependio/Screens/personalinformation.dart';
import 'package:wependio/Screens/securityscreen.dart';

import '../constants.dart';

class Profilemainscreen extends StatefulWidget {
  bool me;
  Profilemainscreen({Key? key, this.me = false}) : super(key: key);

  @override
  _ProfilemainscreenState createState() => _ProfilemainscreenState();
}

class _ProfilemainscreenState extends State<Profilemainscreen> {
  bool following = false;
  int index = 0;
  bool overview = true;

  void _toggleLoginStatus() {
    setState(() {
      overview = !overview;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness bright = AdaptiveTheme.of(context).brightness!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                fillColor: Colors.transparent,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.scaled,
                child: child,
              );
            },
            child: overview
                ? Column(
                    children: [
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "34",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text("Following")
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "30M",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text("Followers")
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "104",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text("Memories")
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      if (!widget.me)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  following = !following;
                                  setState(() {});
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: following
                                        ? Center(
                                            child: Text(
                                              "Following",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: AdaptiveTheme.of(context)
                                                            .theme
                                                            .brightness ==
                                                        Brightness.light
                                                    ? maincolor
                                                    : Color(0xff4F5666),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Follow",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: following
                                        ? AdaptiveTheme.of(context)
                                                    .theme
                                                    .brightness ==
                                                Brightness.light
                                            ? maincolor
                                            : Color(0xff4F5666)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: AdaptiveTheme.of(context)
                                                    .theme
                                                    .brightness ==
                                                Brightness.light
                                            ? maincolor
                                            : Color(0xff4F5666)),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: Text(
                                        "Message",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AdaptiveTheme.of(context)
                                                  .theme
                                                  .brightness ==
                                              Brightness.light
                                          ? maincolor
                                          : Color(0xff4F5666)),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      if (widget.me)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // following = !following;
                                  // setState(() {});
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "Assets/Images/edit.svg",
                                          height: 24,
                                          width: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AdaptiveTheme.of(context)
                                                .theme
                                                .brightness ==
                                            Brightness.light
                                        ? maincolor
                                        : Color(0xff4F5666),
                                    border: Border.all(
                                        color: AdaptiveTheme.of(context)
                                                    .theme
                                                    .brightness ==
                                                Brightness.light
                                            ? maincolor
                                            : Color(0xff4F5666)),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showCupertinoModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Settings(bright: bright);
                                      });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "Assets/Images/settings.svg",
                                          color: AdaptiveTheme.of(context)
                                                      .theme
                                                      .brightness ==
                                                  Brightness.light
                                              ? maincolor
                                              : Color(0xff4F5666),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Settings",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AdaptiveTheme.of(context)
                                                    .theme
                                                    .brightness ==
                                                Brightness.light
                                            ? maincolor
                                            : Color(0xff4F5666)),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      Spacer(),
                      if (index == 0)
                        PageTransitionSwitcher(
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Memoriesmainscreen();
                              }));
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://images.unsplash.com/photo-1572204443441-3859041b6c88?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxhbmUlMjB3aW5kb3d8ZW58MHx8MHx8&w=1000&q=80",
                                        fit: BoxFit.cover,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://img.freepik.com/free-photo/couple-family-traveling-together_1150-7772.jpg?w=2000",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://imageio.forbes.com/blogs-images/johnnyjet/files/2017/10/traveling-alone.jpg?format=jpg&width=960",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                      if (index == 1)
                        PageTransitionSwitcher(
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
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Upcoming Goals",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1.5,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            //  _toggleLoginStatus();
                                            overview = false;
                                            setState(() {});
                                          },
                                          leading: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: 0.5,
                                                ),
                                              ),
                                              CircleAvatar(
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: bright ==
                                                            Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    bright == Brightness.dark
                                                        ? Colors.black
                                                        : maincolor
                                                            .withOpacity(0.3),
                                                radius: 16,
                                              )
                                            ],
                                          ),
                                          title: Text(
                                            "World Traveler",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: bright == Brightness.light
                                                  ? maincolor
                                                  : Colors.white,
                                            ),
                                          ),
                                          trailing: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Details",
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color:
                                                    bright == Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Spacer(),
                                        ListTile(
                                          leading: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: 0.5,
                                              ),
                                              CircleAvatar(
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: bright ==
                                                            Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    bright == Brightness.dark
                                                        ? Colors.black
                                                        : maincolor
                                                            .withOpacity(0.3),
                                                radius: 16,
                                              )
                                            ],
                                          ),
                                          title: Text(
                                            "Small Steps",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: bright == Brightness.light
                                                  ? maincolor
                                                  : Colors.white,
                                            ),
                                          ),
                                          trailing: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Details",
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color:
                                                    bright == Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Spacer(),
                                        ListTile(
                                          leading: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: 0.5,
                                              ),
                                              CircleAvatar(
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: bright ==
                                                            Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    bright == Brightness.dark
                                                        ? Colors.black
                                                        : maincolor
                                                            .withOpacity(0.3),
                                                radius: 16,
                                              )
                                            ],
                                          ),
                                          title: Text(
                                            "Aeronaut",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: bright == Brightness.light
                                                  ? maincolor
                                                  : Colors.white,
                                            ),
                                          ),
                                          trailing: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Details",
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color:
                                                    bright == Brightness.light
                                                        ? maincolor
                                                        : Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1.8,
                                color: bright == Brightness.dark
                                    ? Colors.white
                                    : maincolor,
                              ),
                              color: bright == Brightness.dark
                                  ? maincolordark
                                  : Colors.white,
                            ),
                          ),
                        ),

                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                index = 0;
                              });
                            },
                            icon: SvgPicture.asset(
                              "Assets/Images/photogallery.svg",
                              height: 24,
                              width: 24,
                              color: index == 0
                                  ? AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? maincolor
                                      : maincolordark
                                  : Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            icon: SvgPicture.asset(
                              "Assets/Images/options.svg",
                              height: 24,
                              width: 24,
                              color: index == 1
                                  ? AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? maincolor
                                      : maincolordark
                                  : Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                index = 2;
                              });
                            },
                            icon: ImageIcon(
                              AssetImage(
                                "Assets/Images/star.png",
                              ),
                              color: index == 2
                                  ? AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? maincolor
                                      : maincolordark
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // following = !following;
                          // setState(() {});
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "Assets/Images/globe.svg",
                                  height: 24,
                                  width: 24,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? maincolor
                                      : maincolordark,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Worldmap",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: AdaptiveTheme.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light
                                    ? maincolor
                                    : Color(0xff4F5666)),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "Assets/Images/worldtraveler.png",
                        height: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "World Traveler",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7.5,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              7.5,
                                      child: CircularProgressIndicator(
                                        value: 0.5,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "50%",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w500,
                                              color: bright == Brightness.light
                                                  ? maincolor
                                                  : Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Completed",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: bright == Brightness.light
                                                  ? maincolor
                                                  : Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      backgroundColor: bright == Brightness.dark
                                          ? Colors.black
                                          : maincolor.withOpacity(0.3),
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Remaining Kilometers",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "16.984",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "Assets/Images/photogallery.svg",
                                          height: 24,
                                          width: 24,
                                          color: index == 0
                                              ? AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? maincolor
                                                  : maincolordark
                                              : Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Go to Memories",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AdaptiveTheme.of(context)
                                                .theme
                                                .brightness ==
                                            Brightness.light
                                        ? maincolor
                                        : Color(0xff4F5666),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AdaptiveTheme.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light
                                    ? maincolor
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(15),
                            color: bright == Brightness.light
                                ? Colors.white
                                : maincolordark,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        child: Text(
                          "Back to Overview",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          overview = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
          decoration: BoxDecoration(
            color:
                AdaptiveTheme.of(context).theme.brightness == Brightness.light
                    ? maincolor
                    : Color(0xff4F5666),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height / 12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdHp1CC_rITk7YPbrJDL3LrGbhLSKV_TnhzGci7zhQZ-3vxq-2_7qmFFVUBRPSznmLbS4&usqp=CAU",
                              height: 130,
                              width: 130,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Furqan Abbas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Travelled Kilometers",
                            ),
                            Text(
                              "165.1K",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: [
                Positioned(
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              AdaptiveTheme.of(context).toggleThemeMode();
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              "Assets/Images/add.svg",
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "Assets/Images/message.svg",
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "Assets/Images/notification.svg",
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          )
                        ],
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
  }
}

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
    required this.bright,
  }) : super(key: key);

  final Brightness bright;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:
              widget.bright == Brightness.light ? Colors.white : Colors.black,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/save.svg",
                    height: 24,
                    width: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Saved",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/notification.svg",
                    height: 24,
                    width: 24,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                  title: Text(
                    "Notification Center",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/message.svg",
                    height: 24,
                    width: 24,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                  title: Text(
                    "Chat Settings",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Personalinformation();
                    }));
                  },
                  leading: SvgPicture.asset(
                    "Assets/Images/profile.svg",
                    height: 24,
                    width: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Personal Profile",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Securityscreen();
                    }));
                  },
                  leading: SvgPicture.asset(
                    "Assets/Images/security.svg",
                    height: 24,
                    width: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Security Settings",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/aboutwependio.svg",
                    height: 24,
                    width: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  // ImageIcon(

                  // ),
                  title: Text(
                    "About Wependio",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/faq.svg",
                    height: 24,
                    width: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "FAQ's & Support",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "Assets/Images/legal.svg",
                    height: 24,
                    width: 24,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                  title: Text(
                    "Legal Documents",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.star_border,
                    size: 26,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Rate Us",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Deleteaccount();
                    }));
                  },
                  leading: Icon(
                    CupertinoIcons.delete,
                    // size: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Delete Account",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Logout();
                    }));
                  },
                  leading: Icon(
                    Icons.logout,
                    size: 24,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: widget.bright == Brightness.light
                          ? maincolor
                          : Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.bright == Brightness.light
                        ? maincolor
                        : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("Assets/Images/facebook1.png"),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: SvgPicture.asset(
                          "Assets/Images/instagram1.svg",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("Assets/Images/tiktok.png"),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("Assets/Images/youtube.png"),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ImageIcon(
                          AssetImage("Assets/Images/snapchat.png"),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.bright == Brightness.light
                            ? maincolor
                            : maincolordark,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
