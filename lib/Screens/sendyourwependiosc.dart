import 'dart:ffi';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_hero/local_hero.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Models/Goalsandinterestsmodel.dart';
import 'package:wependio/Screens/connectwependioscreen.dart';
import 'package:wependio/Screens/setyourinterests.dart';
import 'package:wependio/apis/addgoals.dart';
import 'package:wependio/apis/getgoals.dart';
import 'package:widget_loading/widget_loading.dart';

import '../constants.dart';

class Setyourwependiogoals extends StatefulWidget {
  const Setyourwependiogoals({Key? key}) : super(key: key);

  @override
  _SetyourwependiogoalsState createState() => _SetyourwependiogoalsState();
}

class _SetyourwependiogoalsState extends State<Setyourwependiogoals> {
  List<String> goalsname = [];
  List<String> imgname = [];

  ///Variables
  List<Goalsandinterestsmodel> goals = [];
  List<Goalsandinterestsmodel> selectedgoals = [];

  List goalids = [];
  bool loading = false;
  bool remeber = false;
  bool didIt = false;

  List checkBoxList = [];

  static int _len = 16;
  List<bool> isChecked = List.generate(_len, (index) => false);

  // String _getTitle() =>
  //     "Checkbox Demo : Checked = ${isChecked.where((check) => check == true).length}, Unchecked = ${isChecked.where((check) => check == false).length}";
  // String _title = "Checkbox Demo";

  late PersistentBottomSheetController _controller;
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();

  bool _open = false;

  ///Functions
  getgoals() async {
    setState(
      () {
        loading = true;
      },
    );

    getGoal().then((value) async {
      print(value);
      var goalsx = value["goals"];
      goals = List<Goalsandinterestsmodel>.from(
          goalsx.map((data) => Goalsandinterestsmodel.fromJson(data)).toList());

      debugPrint(goalsx.toString());
      setState(() {
        loading = false;
      });
    });
  }

  settinggoals() async {
    setState(
      () {
        loading = true;
      },
    );

    // We are adding Golas
    int index = 0;
    Map<String, String> data = {};
    await Future.forEach(goalids, (element) {
      data.addAll({
        "goals[$index]": element.toString(),
      });
      index += 1;
    });

    addGoal(goals: data).then((value) async {
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Setyourwependiointerests();
          },
        ),
      );
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
    getgoals();

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
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: AdaptiveTheme.of(context).brightness == Brightness.light
                    ? mainTextColor
                    : Colors.white,
              ),
            )),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Navigator.push(context,
        //           //     MaterialPageRoute(builder: (context) {
        //           //   return Loginscreen();
        //           // }));
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.all(8),
        //           child: Text(
        //             "Skip",
        //             style: TextStyle(
        //                 fontFamily: "greycliffcf",
        //                 fontWeight: FontWeight.w600,
        //                 color: Colors.white),
        //           ),
        //         ),
        //         style: ButtonStyle(
        //           elevation: MaterialStateProperty.all<double>(0),
        //           backgroundColor: MaterialStateProperty.all<Color>(
        //               AdaptiveTheme.of(context).brightness == Brightness.light
        //                   ? maincolor
        //                   : Colors.transparent),
        //           shape: MaterialStateProperty.all<OutlinedBorder>(
        //             RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10),
        //               side: BorderSide(
        //                 width: 1.0,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
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
                "Set your\n wependio goals",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontFamily: appMainFont,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "You will gain more informations about your goals\n in your dashboard.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainTextColor
                            : Colors.white.withOpacity(.7),
                    fontSize: 14,
                    fontFamily: appMainFont),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: Color(0xffBECBEB),
                  height: 2,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  // margin: const EdgeInsets.symmetric(vertical: 20),

                  decoration: BoxDecoration(
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? const Color(0xffffffff)
                            : const Color(0xff2A2A31),
                    border: Border.all(
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? const Color(0xffF7F8FD)
                            : const Color(0xff363843),
                        width: 5),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 0)),
                    ],
                  ),

                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // SvgPicture.network(@)
                          GestureDetector(
                            onTap: () {
                              ItemsBottomSheetModel(context);
                              if (selectedgoals.length >= 3) {
                                ValidationBottomSheet(context,
                                    "You can only select three goals at a time");
                              } else {
                                if (!selectedgoals.contains(goals[index])) {
                                  selectedgoals.add(goals[index]);
                                  goalids.add(goals[index].id);
                                }
                              }
                            },
                            child: Container(
                              color: isChecked[index]
                                  ? AdaptiveTheme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color(0xff39393E)
                                      : Color(0xffF7F8FD)
                                  : Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Transform.scale(
                                      scale: 1.5,
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .all(AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? maincolor
                                                    : const Color(0xff2A2A31)),
                                            side: BorderSide(
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? maincolor
                                                  : Colors
                                                      .white, //your desire colour here
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                    color: AdaptiveTheme.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? maincolor
                                                        : Colors.white)),
                                            value: isChecked[index],
                                            onChanged: (checked) {
                                              ItemsBottomSheetModel(context);
                                              if (selectedgoals.length >= 3) {
                                                ValidationBottomSheet(context,
                                                    "You can only select three goals at a time");
                                              } else {
                                                if (!selectedgoals
                                                    .contains(goals[index])) {
                                                  selectedgoals
                                                      .add(goals[index]);
                                                  goalids.add(goals[index].id);
                                                }
                                              }

                                              setState(() {
                                                isChecked[index] = checked!;
                                                for (var data
                                                    in selectedgoals) {
                                                  if (checked == false) {
                                                    selectedgoals.remove(data);
                                                    goalids.remove(data.id);
                                                  }
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: AdaptiveTheme.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? const Color(0xffBECBEB)
                                          : const Color(0xff363843),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 15,
                                            color: Colors.black12,
                                            spreadRadius: 5)
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AdaptiveTheme.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : const Color(0xff45454D),
                                          width: 5),
                                    ),
                                    child: Image.network(
                                      // "https://wependio.maahey.com/goal_images/wependio_goal_Patches_MoonWalker.svg",
                                      // 'Assets/Images/hey.svg'
                                      goals[index].image!,
                                      height: 30,

                                      // height: 20,
                                      // width: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        goals[index].name!,
                                        style: TextStyle(
                                            fontFamily: appMainFont,
                                            fontSize: 20,
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      subtitle: Text(
                                        goals[index].description!,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: appMainFont,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white.withOpacity(.6)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color: Color(0xffBECBEB),
                                height: 3,
                              ))
                        ],
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     color: Colors.transparent,
                        //     border: Border.all(
                        //         color: Colors.grey.withOpacity(
                        //       0.5,
                        //     ))),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Wrap(
              //   spacing: 20,
              //   runSpacing: 20,
              //   alignment: WrapAlignment.center,
              //   children: [
              //     for (var data in selectedgoals)
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
              //                 selectedgoals.remove(data);
              //                 goalids.remove(data.id);
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AdaptiveTheme.of(context).brightness ==
                              Brightness.light
                          ? mainBtnColor
                          : btnDarkBgColor,
                      side: BorderSide(
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? mainTextColor
                              : Colors.white,
                          width: 2)),
                  onPressed: () {
                    debugPrint(getGoal().toString());
                    if (selectedgoals.length < 3) {
                      ValidationBottomSheet(
                          context, "Please select atleast 3 goals to proceed");
                    } else {
                      settinggoals();
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
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Setyourwependiointerests();
                    }));
                  },
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                        fontFamily: appMainFont,
                        fontSize: 14,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontWeight: FontWeight.w900),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              "${selectedgoals.length.toString()} selected",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Wrap(
                        // spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedgoals.clear();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              child: SvgPicture.asset(
                                "Assets/Images/cancle.svg",
                                width: 20,
                                height: 20,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          for (var data in selectedgoals)
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      // color: Colors.red
                                      ),
                                ),
                                Container(
                                  width: 65,
                                  height: 65,
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
                                          offset: const Offset(0, 90),
                                          spreadRadius: 4),
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
                                          // offset: const Offset(0, 90),
                                          spreadRadius: 4),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 2,
                                        color: AdaptiveTheme.of(context)
                                                    .brightness ==
                                                Brightness.dark
                                            ? const Color(0xff45454D)
                                            : Colors.white),
                                    color:
                                        AdaptiveTheme.of(context).brightness ==
                                                Brightness.light
                                            ? const Color(0xffBECBEB)
                                            : const Color(0xff353743),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.network(
                                        data.image!,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedgoals.remove(data);
                                      goalids.remove(data.id);
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
                          //   decoration: BoxDecoration(
                          //     color: AdaptiveTheme.of(context).brightness ==
                          //             Brightness.light
                          //         ? Color(0xffBECBEB)
                          //         : Color(0xff353843),
                          //     borderRadius: BorderRadius.circular(15),
                          //     border: Border.all(
                          //         color:
                          //             AdaptiveTheme.of(context).brightness ==
                          //                     Brightness.light
                          //                 ? Colors.white
                          //                 : Color(0xff45454D),
                          //         width: 3),
                          //   ),
                          //   child: Stack(
                          //     alignment: Alignment.topRight,
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.all(4.0),
                          //         child: Image.network(
                          //           data.image!,
                          //           height: 60,
                          //         ),
                          //       ),
                          //       GestureDetector(
                          //         onTap: () {
                          //           selectedgoals.remove(data);
                          //           goalids.remove(data.id);
                          //           setState(() {});
                          //         },
                          //         child: Positioned(
                          //           top: -20,
                          //           left: 20,
                          //           child: Container(
                          //             width: 25,
                          //             height: 25,
                          //             child: Icon(
                          //               Icons.cancel_outlined,
                          //               color: Colors.white,
                          //               size: 25,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

            //  Container(
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.only(
            //       topLeft: Radius.circular(20),
            //       topRight: Radius.circular(20),
            //     ),
            //     color: AdaptiveTheme.of(context)
            //                 .brightness ==
            //             Brightness.dark
            //         ? maincolordark
            //         : Colors.white,
            //   ),
            //   child: ListView.builder(
            //       itemCount: selectedgoals.length,
            //       itemBuilder: (context, index) {
            //         return ListTile(
            //             title: Text(
            //                 selectedgoals[index]
            //                     .name!),
            //             trailing: GestureDetector(
            //                 onTap: () {
            //                   goalids.remove(
            //                       selectedgoals[index]
            //                           .id);
            //                   setState(() {
            //                     selectedgoals
            //                         .removeAt(index);

            //                     if (selectedgoals
            //                         .isEmpty) {
            //                       Navigator.pop(
            //                           context);
            //                     }
            //                   });
            //                 },
            //                 child: const Icon(Icons
            //                     .remove_circle)));
            //       }),
            // );
          });
        });
  }

  Future<dynamic> ValidationBottomSheet(BuildContext context, String title) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: AdaptiveTheme.of(context).brightness == Brightness.dark
                  ? const Color(0xff363843)
                  : Colors.white,
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
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
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
                        "Got it",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: appMainFont,
                            fontSize: 14,
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? maincolor
                                : Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.info_rounded,
                    size: 30,
                    color: maincolor,
                  ),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: greyCliffMedium,
                          fontSize: 14,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? mainTextColor
                              : Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
