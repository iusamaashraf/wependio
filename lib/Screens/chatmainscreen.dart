import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/Textfieldwidget.dart';
import '../constants.dart';

class Chatmainscreen extends StatefulWidget {
  const Chatmainscreen({Key? key}) : super(key: key);

  @override
  _ChatmainscreenState createState() => _ChatmainscreenState();
}

class _ChatmainscreenState extends State<Chatmainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(MediaQuery.of(context).size.width, 10)),
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        // leadingWidth: 50,
        backgroundColor:
            AdaptiveTheme.of(context).theme.brightness == Brightness.light
                ? maincolor
                : Color(0xff4F5666),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "Assets/Images/message.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/notification.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/add.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Customtextfield(
              leadingwidget: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.search,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? maincolor
                          : Colors.black,
                ),
                //  SvgPicture.asset(
                //   "Assets/Images/password.svg",
                //   color: AdaptiveTheme.of(context).brightness == Brightness.light
                //       ? maincolor
                //       : Colors.black,
                // ),
              ),
              labeltext: "Search",
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Messages",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "(6)",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(5),
                  //   child: Image.network(
                  //       "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dHJvcGljYWwlMjBiZWFjaHxlbnwwfHwwfHw%3D&w=1000&q=80"),
                  // ),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.dark
                            ? Colors.white
                            : maincolor,
                        width: 3),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dHJvcGljYWwlMjBiZWFjaHxlbnwwfHwwfHw%3D&w=1000&q=80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Clara S",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AdaptiveTheme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Hi, Plans for tomorrow?",
                                maxLines: 1,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "16:15",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              backgroundColor:
                                  AdaptiveTheme.of(context).brightness ==
                                          Brightness.dark
                                      ? maincolordark
                                      : maincolor,
                              radius: 10,
                              child: Text(
                                "3",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
