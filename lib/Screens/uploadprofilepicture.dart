// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/favouriteplaces.dart';
import 'package:wependio/apis/updateprofilepicture.dart';
import 'package:wependio/constants.dart';
import 'package:widget_loading/widget_loading.dart';

import '../main.dart';

class Uploadpicture extends StatefulWidget {
  const Uploadpicture({Key? key}) : super(key: key);

  @override
  _UploadpictureState createState() => _UploadpictureState();
}

class _UploadpictureState extends State<Uploadpicture> {
  ///Variables
  File? imagex;
  String name = '';
  String username = '';
  bool loading = false;

  @override
  void initState() {
    getName();
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        loading = false;
      });
    });
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    username = prefs.getString('username')!;
  }

  ///Functions
  Future getimage(bool camera) async {
    final image = await ImagePicker().pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    //var length = await videox.d
    //print(length);
    if (image == null) {
      print("error");
    } else {
      setState(() {
        imagex = File(image.path);

        debugPrint(imagex.toString());
      });
    }
  }

  uploadprofilepicture(BuildContext context) async {
    setState(() {
      loading = true;
    });

    updatePicture(image: imagex!.path).then((value) async {
      print(value);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('picture', value['profile_picture']);

      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Favouriteplaces();
      }));
    });
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: AdaptiveTheme.of(context).brightness == Brightness.light
                    ? mainTextColor
                    : Colors.white,
              ),
            )),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) {
        //               return Favouriteplaces();
        //             },
        //           ),
        //         );
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
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagex == null
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          color: AdaptiveTheme.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : const Color(0xff363843),
                                        ),
                                        child: IntrinsicHeight(
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
                                                      color: hintTextColor
                                                          .withOpacity(.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getimage(true);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            AdaptiveTheme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? mainTextColor
                                                                : Colors.white,
                                                        child: SvgPicture.asset(
                                                          "Assets/Images/camera.svg",
                                                          color: AdaptiveTheme.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "Take Profile picutre now",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontFamily:
                                                                appMainFont,
                                                            color: AdaptiveTheme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? mainTextColor
                                                                : Colors.white,
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: maincolor,
                                                height: 1,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getimage(false);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            AdaptiveTheme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? mainTextColor
                                                                : Colors.white,
                                                        child: SvgPicture.asset(
                                                          "Assets/Images/gallery1.svg",
                                                          color: AdaptiveTheme.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "Choose from your gallery",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 18,
                                                            color: AdaptiveTheme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? mainTextColor
                                                                : Colors.white,
                                                            fontFamily:
                                                                appMainFont),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: 170,
                                height: 170,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 7,
                                                    color: AdaptiveTheme.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : const Color(
                                                            0xff1B1B1F),
                                                    spreadRadius: 5)
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AdaptiveTheme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? maincolor
                                                      : const Color(0xff353742),
                                              radius: 40,
                                              child: const Icon(
                                                CupertinoIcons.camera,
                                                size: 40,
                                                color: Colors.white,
                                                // color: AdaptiveTheme.of(context).brightness ==
                                                //         Brightness.light
                                                //     ? Colors.white
                                                //     : Color(0xff333339),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 10.0,
                                                      offset: Offset(0.0, 0))
                                                ]),
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 12,
                                              child: Icon(
                                                Icons.add,
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? maincolordark
                                                    : maincolor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Icon(
                                      //   CupertinoIcons.add_circled_solid,
                                      //   color: AdaptiveTheme.of(context).brightness ==
                                      //           Brightness.dark
                                      //       ? Colors.white
                                      //
                                      //       : maincolor,
                                      // ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  // backgroundBlendMode: BlendMode.overlay,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color(0xff353742),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color:
                                        AdaptiveTheme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : mainTextColor,
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 102,
                                  width: 102,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(imagex!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    right: 5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      imagex = null;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AdaptiveTheme.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "@${username.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : const Color(0xffBECBEB),
                        fontFamily: workSansSemibold,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Upload your\n profile picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: appMainFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    "We know you are pretty!. Time to show the\n world who you are.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white,
                        fontFamily: appMainFont),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? mainBtnColor
                            : btnDarkBgColor,
                    side: BorderSide(
                        width: 2,
                        color: AdaptiveTheme.of(context).brightness ==
                                Brightness.light
                            ? mainTextColor
                            : Colors.white)),
                onPressed: () {
                  if (imagex == null) {
                    ValidationBottomSheet(context,
                        "Please select an image to continue or skip this step");
                  } else {
                    uploadprofilepicture(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Upload Profile Picture",
                    style: TextStyle(
                      fontFamily: workSansSemibold,
                      // fontWeight: FontWeight.w100,
                      fontSize: 16,
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
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Favouriteplaces();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                        fontFamily: appMainFont,
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
                  ? Color(0xff363843)
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
