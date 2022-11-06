import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_hero/local_hero.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Models/Goalsandinterestsmodel.dart';

import 'package:wependio/Screens/connectwependioscreen.dart';
import 'package:wependio/Screens/mainhomescreen.dart';
import 'package:wependio/apis/addinterest.dart';
import 'package:wependio/apis/getinterests.dart';
import 'package:widget_loading/widget_loading.dart';

import '../constants.dart';

class Setyourwependiointerests extends StatefulWidget {
  const Setyourwependiointerests({Key? key}) : super(key: key);

  @override
  _SetyourwependiointerestsState createState() =>
      _SetyourwependiointerestsState();
}

class _SetyourwependiointerestsState extends State<Setyourwependiointerests> {
  List<String> interestsname = [];
  List<String> imgname = [];

  ///Variables
  List<Goalsandinterestsmodel> interests = [];
  List<Goalsandinterestsmodel> selectedinterests = [];
  List interestids = [];
  bool loading = false;

  ///Functions
  getinterests() async {
    setState(
      () {
        loading = true;
      },
    );

    getInterest().then((value) {
      print(value);
      setState(() {
        loading = false;
      });
      List interestsx = value["interests"];
      interests = List<Goalsandinterestsmodel>.from(
        interestsx
            .map((data) => Goalsandinterestsmodel.fromJson(data))
            .toList(),
      );
    });
  }

  settinginterests() async {
    setState(
      () {
        loading = true;
      },
    );
    List data = [];
    int index = 0;
    //print(interestids.length);
    interestids.forEach((element) {
      data.add({
        "interests[$index]": element.toString(),
      });
      index += 1;
    });
    print(data);

    addInterest(data: data).then((value) {
      print(value);
      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Mainhomescreen(isDialogShow: false);
      }));
      // var placesx = responsex.data["places"];
      // places = List<Placesmodel>.from(
      //     placesx.map((data) => Placesmodel.fromJson(data)).toList());
    });
  }

  showbar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AdaptiveTheme.of(context).brightness == Brightness.dark
            ? maincolordark
            : maincolor,
        content: Text(
          text,
          style: TextStyle(
              color: AdaptiveTheme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  @override
  void initState() {
    getinterests();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10),
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
        // ],
      ),
      body: CircularWidgetLoading(
        dotColor: AdaptiveTheme.of(context).brightness == Brightness.dark
            ? maincolordark
            : maincolor,
        loading: loading,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Set your interests",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? mainTextColor
                          : Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You can also change and add more interests in\n your dashboard later.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white.withOpacity(.6),
                    fontFamily: appMainFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: interests.length,
                  itemBuilder: (context, index) {
                    return
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     image: DecorationImage(
                        //         image: NetworkImage(
                        //           interests[index].image!,
                        //         ),
                        //         fit: BoxFit.cover),
                        //   ),
                        // );

                        GestureDetector(
                      onTap: () {
                        if (selectedinterests.length >= 3) {
                          showbar(
                              "You can only select three interests at a time",
                              context);
                        } else {
                          if (!selectedinterests.contains(interests[index])) {
                            selectedinterests.add(interests[index]);
                            interestids.add(interests[index].id);
                            setState(() {});
                          }
                        }
                        ItemsBottomSheetModel(context);

                        interestids.contains(interests[index].id.toString())
                            ? interestids.remove(interests[index].id.toString())
                            : interestids.add(interests[index].id.toString());
                        setState(() {});
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: interests[index].image!,
                              fit: BoxFit.cover,
                              // height: 100,
                              // width: 100,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            child: Chip(
                              backgroundColor: Colors.white.withOpacity(0.5),
                              label: Text(
                                interests[index].name!,
                                style: TextStyle(
                                    fontFamily: sfProFont,
                                    fontSize: 12,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: interestids.contains(
                                          interests[index].id.toString())
                                      ? mainTextColor
                                      : Colors.transparent,
                                  width: 2),
                              color: interestids
                                      .contains(interests[index].id.toString())
                                  ? maincolor.withOpacity(.4)
                                  : Colors.transparent,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(
                                    0.5,
                                  ))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                // child: ListTile(
                                //   onTap: () {
                                //     if (selectedinterests.length >= 3) {
                                //       showbar(
                                //           "You can only select three interests at a time",
                                //           context);
                                //     } else {
                                //       if (!selectedinterests
                                //           .contains(interests[index])) {
                                //         selectedinterests.add(interests[index]);
                                //         interestids.add(interests[index].id);
                                //         setState(() {});
                                //       }
                                //     }
                                //
                                //     // interestsname.add("World Traveler");
                                //     // imgname.add("Assets/Images/worldtraveler.png");
                                //     // setState(() {});
                                //   },
                                //   leading: SvgPicture.network(
                                //     "https://wependio.maahey.com/goal_images/wependio_goal_Patches_MoonWalker.svg",
                                //     // "https://wependio.maahey.com/goal_images/wependio_goal_Patches_WorldTraveler.svg",
                                //     //   interests[index].image!,
                                //     height: 100,
                                //     width: 100,
                                //   ),
                                //   title: Text(
                                //     interests[index].name!,
                                //   ),
                                //   subtitle: Text(interests[index].description!),
                                // ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: Colors.transparent,
                    //         border: Border.all(
                    //             color: Colors.grey.withOpacity(
                    //           0.5,
                    //         ))),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 10,
                    //       ),
                    //       child: ListTile(
                    //         onTap: () {
                    //           if (selectedinterests.length >= 3) {
                    //             showbar(
                    //                 "You can only select three interests at a time",
                    //                 context);
                    //           } else {
                    //             if (!selectedinterests
                    //                 .contains(interests[index])) {
                    //               selectedinterests.add(interests[index]);
                    //               interestids.add(interests[index].id);
                    //               setState(() {});
                    //             }
                    //           }

                    //           // interestsname.add("World Traveler");
                    //           // imgname.add("Assets/Images/worldtraveler.png");
                    //           // setState(() {});
                    //         },
                    //         leading: SvgPicture.network(
                    //           "https://wependio.maahey.com/goal_images/wependio_goal_Patches_MoonWalker.svg",
                    //           // "https://wependio.maahey.com/goal_images/wependio_goal_Patches_WorldTraveler.svg",
                    //           //   interests[index].image!,
                    //           height: 100,
                    //           width: 100,
                    //         ),
                    //         title: Text(
                    //           interests[index].name!,
                    //         ),
                    //         subtitle: Text(interests[index].description!),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Wrap(
              //   spacing: 20,
              //   runSpacing: 20,
              //   alignment: WrapAlignment.center,
              //   children: [
              //     for (var data in selectedinterests)
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.transparent,
              //           borderRadius: BorderRadius.circular(15),
              //           border: Border.all(
              //             color: Colors.grey.withOpacity(0.5),
              //           ),
              //         ),
              //         child: Stack(
              //           alignment: Alignment.topRight,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: SvgPicture.network(
              //                 data.image!,
              //                 height: 60,
              //               ),
              //             ),
              //             GestureDetector(
              //               onTap: () {
              //                 selectedinterests.remove(data);
              //                 interestids.remove(data.id);
              //                 setState(() {});
              //               },
              //               child: Icon(
              //                 Icons.cancel,
              //                 color: maincolor,
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainBtnColor
                            : btnDarkBgColor,
                    side: BorderSide(
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        width: 2)),
                onPressed: () {
                  if (interestids.length == 0) {
                    showbar(
                        "Please select atleast 1 interest to proceed", context);
                  } else {
                    settinginterests();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: workSansSemibold,
                      // fontWeight: FontWeight.w100,
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
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Mainhomescreen(isDialogShow: false);
                    }));
                  },
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> ItemsBottomSheetModel(
      BuildContext context) {
    return showBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AdaptiveTheme.of(context).brightness == Brightness.dark
                    ? const Color(0xff363843)
                    : const Color(0xff99AEE2),
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 150),
                      child: Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black12
                              : const Color(0xffF7F8FD).withOpacity(.26),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              "${selectedinterests.length.toString()} selected",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: workSansRegular,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Text(
                                "Done",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: appMainFont,
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      // spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedinterests.clear();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            child: SvgPicture.asset(
                              "Assets/Images/cancle.svg",
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),

                        for (var data in selectedinterests)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 100,
                                decoration: const BoxDecoration(
                                    // color: Colors.red
                                    ),
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: AdaptiveTheme.of(context)
                                                    .brightness ==
                                                Brightness.dark
                                            ? const Color(0xff1B1B1F)
                                                .withOpacity(.3)
                                            : const Color(0xffBECBEB)
                                                .withOpacity(.40),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 2,
                                        offset: const Offset(0, 55),
                                        spreadRadius: 4),
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    data.name!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: sfProFont,
                                        fontSize: 12,
                                        height: 1),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    selectedinterests.remove(data);
                                    interestids.remove(data.id);
                                    setState(() {});
                                  },
                                  child: Container(
                                      width: 25,
                                      height: 25,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : const Color(0xff45454D)),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AdaptiveTheme.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? mainTextColor
                                              : const Color(0xff363843)),
                                      child: SvgPicture.asset(
                                        "Assets/Images/cancle.svg",
                                      )
                                      //  Icon(
                                      //   Icons.cancel,
                                      //   color: mainTextColor,
                                      //   size: 25,
                                      // ),
                                      ),
                                ),
                              ),
                            ],
                          ),

                        // Container(
                        //   // width: double.infinity,
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 40),
                        //     // width: double.infinity,
                        //     height: 30,
                        //     decoration: BoxDecoration(
                        //       boxShadow: [
                        //         BoxShadow(
                        //             color: Color(0xff1B1B1F).withOpacity(.3),
                        //             blurStyle: BlurStyle.normal,
                        //             blurRadius: 10,
                        //             // offset: Offset(0, 70),
                        //             spreadRadius: 10),
                        //       ],
                        //       border: Border.all(
                        //           width: 0, color: Color(0xff363843)),
                        //       color: Color(0xff363843),
                        //     ),
                        //   ),
                        // ),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: AdaptiveTheme.of(context).brightness ==
                        //             Brightness.light
                        //         ? Colors.white
                        //         : Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color:
                        //             AdaptiveTheme.of(context).brightness ==
                        //                     Brightness.light
                        //                 ? Colors.white
                        //                 : Colors.white,
                        //         boxShadow: const <BoxShadow>[
                        //           BoxShadow(
                        //               color: Color(0xff2D2F38),
                        //               blurRadius: 50,
                        //               spreadRadius: 5,
                        //               blurStyle: BlurStyle.outer,
                        //               offset: Offset(0, 50))
                        //         ],
                        //         borderRadius: BorderRadius.circular(20)),
                        //     width: 100,
                        //     height: 40,
                        //     child: Row(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Expanded(
                        //           child: Container(
                        //             margin: EdgeInsets.only(left: 10),
                        //             child: Text(
                        //               data.name!,
                        //               style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontFamily: sfProFont,
                        //                 fontSize: 12,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             selectedPlaces.remove(data);
                        //             placesid.remove(data.id);
                        //             setState(() {});
                        //           },
                        //           child: Container(
                        //             margin: EdgeInsets.only(right: 5),
                        //             decoration: BoxDecoration(
                        //               borderRadius: const BorderRadius.all(
                        //                   Radius.circular(20)),
                        //               color: AdaptiveTheme.of(context)
                        //                           .brightness ==
                        //                       Brightness.light
                        //                   ? mainTextColor
                        //                   : Color(0xff363843),
                        //             ),
                        //             child: const Icon(
                        //               Icons.cancel_outlined,
                        //               color: Colors.white,
                        //               size: 25,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
