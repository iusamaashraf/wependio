import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_stack/image_stack.dart';

import '../constants.dart';

class Postsmainscreen extends StatelessWidget {
  Postsmainscreen({Key? key}) : super(key: key);
  List images = [
    "https://assets1.cbsnewsstatic.com/hub/i/2018/11/06/0c1af1b8-155a-458e-b105-78f1e7344bf4/2018-11-06t054310z-1334124005-rc1be15a8050-rtrmadp-3-people-sexiest-man.jpg",
    "https://img.etimg.com/thumb/msid-48770845,width-650,imgsize-204137,,resizemode-4,quality-100/.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: [
            Container(
              height: 90,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Me")
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
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
                            height: 5,
                          ),
                          Text("Fetch")
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
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
                            height: 5,
                          ),
                          Text("Fetch")
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
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
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Paul_lander",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Total Travelled: 2,900 Km",
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20),
                                      right: Radius.circular(20),
                                    ),
                                    color: maincolor,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 5,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 120,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    "Assets/Images/globe.svg",
                                                    height: 24,
                                                    width: 24,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "World Map",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 120,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    "Assets/Images/share.svg",
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "Share",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: 120,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    "Assets/Images/report.svg",
                                                    // color: Colors.transparent,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "Report",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          "https://media.istockphoto.com/photos/maldivian-water-villas-at-night-picture-id472301038?k=20&m=472301038&s=612x612&w=0&h=hu-kCZl5AGi1nNclkr6tdDv4muPRT10o1ZvgeHYrt_E=",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "Assets/Images/location.svg",
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Pipa Beach,",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Brazil",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : maincolor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Nice Shot!",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "Assets/Images/share.svg",
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : maincolor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SvgPicture.asset(
                            "Assets/Images/save.svg",
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : maincolor,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: WidgetStack(
                            stackedWidgets: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white,
                                      // color: AdaptiveTheme.of(context).brightness ==
                                      //         Brightness.dark
                                      //     ? Colors.white
                                      //     : maincolor,
                                      width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage(images[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white,
                                      // AdaptiveTheme.of(context).brightness ==
                                      //         Brightness.dark
                                      //     ? Colors.white
                                      //     : maincolor,
                                      width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage(images[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                            positions: RestrictedPositions(
                              maxCoverage: 0.5,
                              minCoverage: 0.4,
                              align: StackAlign.left,
                            ),
                            buildInfoWidget: (surplus) {
                              return Center(
                                  child: Text(
                                '+\$surplus',
                                style: Theme.of(context).textTheme.headline5,
                              ));
                            },
                          ),
                        ),
                      ),
                      Text("Like by Paul Lander and 10K more"),
                    ],
                  ),
                  // ImageStack(
                  //   imageBorderColor:
                  //       AdaptiveTheme.of(context).brightness == Brightness.dark
                  //           ? Colors.white
                  //           : maincolor,
                  //   imageList:
                  //   totalCount:
                  //       2, // If larger than images.length, will show extra empty circle
                  //   imageRadius: 30, // Radius of each images
                  //   imageCount:
                  //       5, // Maximum number of images to be shown in stack
                  //   imageBorderWidth: 1, // Border width around the images
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(MediaQuery.of(context).size.width, 10)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ImageIcon(
            AssetImage("Assets/Images/wependiosmall.png"),
            size: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        title: ImageIcon(
          AssetImage("Assets/Images/wependiologo2.png"),
          size: 100,
          color: Colors.white,
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
    );
  }
}
