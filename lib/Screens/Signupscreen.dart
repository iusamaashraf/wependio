import 'dart:io';
import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wependio/Screens/Signupscreen1.dart';
import 'package:wependio/Screens/Verifyemailscreen.dart';
import 'package:wependio/Widgets/Textfieldwidget.dart';
import 'package:wependio/Widgets/common_button.dart';
import 'package:wependio/apis/checkusername.dart';
import 'package:wependio/apis/getcountries.dart';
import 'package:wependio/apis/signup.dart';
import 'package:wependio/constants.dart';
import 'package:wependio/main.dart';
import 'package:widget_loading/widget_loading.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  _SignupscreenscreenState createState() => _SignupscreenscreenState();
}

int index = 1;
int idx = 0;

class _SignupscreenscreenState extends State<Signupscreen> {
  ////Variables
  bool showpassword = true;
  bool showrepeatpassword = true;
  bool remember = false;

  bool backState = false;
  PageController controller = PageController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController residential = TextEditingController();
  String? country;

  late AnimationController animateController;
  List countries = [];
  List search = [];
  TextEditingController searchController = TextEditingController();
  String? gender;
  String? dateofbirth;
  String? countryid;
  bool alreadyexists = false;
  bool loading = false;
  bool tickState = false;
  String searchString = '';
  List users = [];

  // DateTime dob = DateTime.now();

  ///Functions
  ///Api Calls
  //Getting Countries
  getData() async {
    getCountries().then((value) {
      setState(() {
        countries = value["countries"];
      });
    });
  }

  //Checking Username
  checkusername(BuildContext context) async {
    setState(() {
      loading = true;
    });

    checkName(usernmae: username.text).then((value) async {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
        if (value["exists"] == true) {
          setState(() {
            alreadyexists = true;
          });
        } else {
          controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
          index = 2;

          setState(() {});
        }
      });
    });
    // countries = responsex.data["countries"];
  }

  //Signup
  signingup(BuildContext context) async {
    print(email.text);
    setState(() {
      loading = true;
    });

    signUp(
            name: name.text,
            email: email.text,
            password: password.text,
            cpass: repeatpassword.text,
            username: username.text,
            dob: dateofbirth!,
            country: countryid!,
            zip: zipcode.text,
            address: address.text,
            gender: gender!)
        .then((responsex) async {
      if (responsex['message'] == null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", responsex["token"]);
        prefs.setString("name", responsex["user"]["name"]);
        prefs.setString("email", responsex["user"]["email"]);
        prefs.setString("username", responsex["user"]["username"]);

        token = responsex["token"];
        namev = responsex["user"]["name"];

        emailv = responsex["user"]["email"];

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Verifyemailscreen();
            },
          ),
        );

        setState(() {
          loading = false;
        });
      } else {
        print(responsex['message']);
        setState(() {
          loading = false;
        });

        ValidationBottomSheet(context, responsex['message'].toString());
        // showbar(responsex['message'], context);
      }
    });
  }

  ///Functions
  ///Other Functions

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

  bool validationfirst(BuildContext context) {
    if (username.text.trim().toLowerCase().isEmpty) {
      ValidationBottomSheet(context, "Username is required.");

      return false;
    }
    if (password.text.trim().isEmpty) {
      ValidationBottomSheet(context, "Password is required");
      return false;
    }
    if (password.text.trim().length < 8) {
      ValidationBottomSheet(
          context, "Password should be atleast 8 characters long");
      return false;
    }
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password.text.trim())) {
      // ValidationBottomSheet(context,
      //     "Your password at least 8 characters,\n 1 capital letter and 1 number.");
      PasswordMustContain(context);

      return false;
    }
    if (repeatpassword.text.trim().isEmpty) {
      ValidationBottomSheet(context, "Repeat password is required");
      return false;
    }
    if (password.text.trim().toLowerCase() !=
        repeatpassword.text.trim().toLowerCase()) {
      ValidationBottomSheet(
          context, "Password and confirm password doesnot match");
      return false;
    }
    return true;
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

  Future<dynamic> PasswordMustContain(BuildContext context) {
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
                    child: RichText(
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Your password must contain at least',
                        style: TextStyle(
                            fontFamily: appMainFont,
                            fontWeight: FontWeight.w600,
                            color: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? mainTextColor
                                : Colors.white.withOpacity(.6)),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' 8 characters,\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white,
                                  fontFamily: appMainFont)),
                          TextSpan(
                              text: '1 capital letter,',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white,
                                  fontFamily: appMainFont)),
                          // TextSpan(
                          //     text: ' 1 small letter',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w900,
                          //         fontFamily: appMainFont)),
                          TextSpan(
                              text: ' and',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white,
                                  fontFamily: appMainFont)),
                          TextSpan(
                              text: ' 1 number.',
                              style: TextStyle(
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: appMainFont)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  ///Validation Second
  bool validationsecond(BuildContext context) {
    if (name.text.trim().isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor:
      //         AdaptiveTheme.of(context).brightness == Brightness.dark
      //             ? maincolordark
      //             : maincolor,
      //     content: Text(
      //       "Name is required",
      //       style: TextStyle(
      //           color: AdaptiveTheme.of(context).brightness == Brightness.dark
      //               ? Colors.white
      //               : Colors.black),
      //     ),
      //     behavior: SnackBarBehavior.fixed,
      //   ),
      // );
      ValidationBottomSheet(context, "Name is required");
      return false;
    }
    if (gender == null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor:
      //         AdaptiveTheme.of(context).brightness == Brightness.dark
      //             ? maincolordark
      //             : maincolor,
      //     content: Text(
      //       "Gender is required",
      //       style: TextStyle(
      //           color: AdaptiveTheme.of(context).brightness == Brightness.dark
      //               ? Colors.white
      //               : Colors.black),
      //     ),
      //     behavior: SnackBarBehavior.fixed,
      //   ),
      // );
      ValidationBottomSheet(context, "Gender is required");
      return false;
    }
    if (dateofbirth == null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor:
      //         AdaptiveTheme.of(context).brightness == Brightness.dark
      //             ? maincolordark
      //             : maincolor,
      //     content: Text(
      //       "Date of birth is required",
      //       style: TextStyle(
      //           color: AdaptiveTheme.of(context).brightness == Brightness.dark
      //               ? Colors.white
      //               : Colors.black),
      //     ),
      //     behavior: SnackBarBehavior.fixed,
      //   ),
      // );

      ValidationBottomSheet(context, "Date of birth is required");
      return false;
    }
    return true;
  }

  ///Validationthird

  bool validationthird(BuildContext context) {
    if (country == null) {
      ValidationBottomSheet(context, "Country is required.");
      return false;
    }
    if (zipcode.text.trim().toLowerCase().isEmpty) {
      ValidationBottomSheet(context, "Zipcode is required.");
      return false;
    }

    if (town.text.trim().toLowerCase().isEmpty) {
      ValidationBottomSheet(context, "Town is required.");
      return false;
    }
    if (residential.text.trim().toLowerCase().isEmpty) {
      ValidationBottomSheet(context, "Address is required.");
      return false;
    }
    if (email.text.trim().toLowerCase().isEmpty) {
      ValidationBottomSheet(context, "Email is required.");
      return false;
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text.trim())) {
      ValidationBottomSheet(context, "Email is not valid.");
      return false;
    }
    return true;
  }

  ///Get Date of Birth
  dateofbirthsheet(BuildContext context) async {
    DateTime birthday = DateTime.now();
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            print(DateTime.now().difference(birthday).inDays);
            if (DateTime.now().difference(birthday).inDays < 5840) {
              // showTopSnackBar(
              //   context,
              //   const CustomSnackBar.info(
              //     message: "User must be over 16 years of age",
              //   ),
              // );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  backgroundColor:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff363843),
                  content: Container(
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white.withOpacity(.6)
                                    : Colors.black12),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(
                                Icons.info,
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? mainTextColor
                                    : Colors.white,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "User must be 16 years or older.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: appMainFont,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : mainTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  behavior: SnackBarBehavior.fixed,
                ),
              );
            } else {
              dateofbirth = birthday.toString().split(" ").first;
              setState(() {});
            }
            // dob = birthday;
            Navigator.pop(context);
          },
          child: const Text("Done"),
        ),
        actions: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumYear: 1990,
              //minimumDate: DateTime(1900),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (date) {
                birthday = date;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    //checkusername(context);
    getData();
    // TODO: implement initState
    super.initState();
  }

  FocusNode focusNode = FocusNode();
  bool isFocus = true;
  bool isExpanded = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      //backgroundColor: Color(0xFF0C0D0F),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   shadowColor: Colors.transparent,

      //   leading: IconButton(
      //       // padding: const EdgeInsets.only(top: 20),
      //       onPressed: () {
      //         // index = 1;
      //         controller.previousPage(
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.easeIn);
      //       },
      //       icon: Icon(
      //         Icons.arrow_back_ios_new,
      //         color: AdaptiveTheme.of(context).brightness == Brightness.light
      //             ? mainTextColor
      //             : Colors.white,
      //       )),
      //   // title: Text("Sign Up"),
      //   centerTitle: false,
      // ),
      body: Builder(builder: (context) {
        return CircularWidgetLoading(
          dotColor: AdaptiveTheme.of(context).brightness == Brightness.dark
              ? maincolordark
              : maincolor,
          loading: loading,
          sizeDuration: const Duration(milliseconds: 200),
          child: LayoutBuilder(builder: (context, constraint) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.01 * size.height),
                    child: IconButton(
                        // padding: const EdgeInsets.only(top: 20),
                        onPressed: () {
                          if (idx == 0) {
                            Navigator.pop(context);
                          } else {
                            controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                            setState(() {});
                          }
                          // if (index == 1) {
                          //   Navigator.pop(context);
                          // } else if (index == 2 && index == 3) {

                          //   setState(() {});
                          // }
                        },
                        icon: Icon(
                          size: size.height * 0.04,
                          Icons.arrow_back_ios_new,
                          color: AdaptiveTheme.of(context).brightness ==
                                  Brightness.light
                              ? mainTextColor
                              : Colors.white,
                        )),
                  ),
                ),
                // index == 1
                //     ? ZoomIn(
                //         child: SvgPicture.asset(
                //           "Assets/Images/s1.svg",
                //           height: MediaQuery.of(context).size.height / 4,
                //         ),
                //       )
                //     : index == 2
                //         ? ZoomIn(
                //             // controller: (controller) => animateController = controller,
                //             // manualTrigger: true,
                //             child: SvgPicture.asset(
                //               "Assets/Images/s2.svg",
                //               height:
                //                   MediaQuery.of(context).size.height / 4,
                //             ),
                //           )
                //         : ZoomIn(
                //             // controller: (controller) => animateController = controller,
                //             // manualTrigger: true,
                //             child: SvgPicture.asset(
                //               "Assets/Images/s3.svg",
                //               height:
                //                   MediaQuery.of(context).size.height / 4,
                //             ),
                //           ),
                Positioned(
                    top: Adaptive.h(7.2),
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(13)),
                        child: Column(
                          children: [
                            Container(
                              // padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                width: 180,
                                height: Adaptive.h(15.5),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 160,
                                          height: Adaptive.h(15),
                                          decoration: BoxDecoration(
                                            color: index == 1
                                                ? AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Color(0xffF7F8FD)
                                                    : Color(0xff26272F)
                                                : index == 2
                                                    ? AdaptiveTheme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Color(0xff26272F)
                                                    : index == 3
                                                        ? Color(0xff99AEE2)
                                                        : Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 0)),
                                            ],
                                          )),
                                      Container(
                                          width: 120,
                                          height: Adaptive.h(12),
                                          decoration: BoxDecoration(
                                            color: index == 1
                                                ? AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Color(0xff343640)
                                                : const Color(0xffB5C5EF),
                                            shape: BoxShape.circle,
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 0)),
                                            ],
                                          )),
                                      Container(
                                          height: Adaptive.h(8.5),
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainLightColor
                                                : const Color(0xffBECBEB),
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: index == 1
                                                      ? AdaptiveTheme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Colors.black12
                                                      : index == 2
                                                          ? Colors.black12
                                                          : index == 3
                                                              ? Colors.black12
                                                              : Colors.white,
                                                  blurRadius: 10.0,
                                                  offset: const Offset(0.0, 0)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller,
                                onPageChanged: (index) {
                                  setState(() {
                                    idx = index;
                                  });
                                },
                                children: [
                                  FadeInRight(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // CircleAvatar(
                                          //   child: Image.asset(
                                          //     "Assets/Images/wependiosmall.png",
                                          //     height: 80,
                                          //   ),
                                          //   backgroundColor: Colors.white,
                                          //   radius: 70,
                                          // ),
                                          //  if (index == 1)

                                          // if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(4),
                                          ),
                                          Text(
                                            //"Sign up \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n to get started!",
                                            "Lets begin",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w900,
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : Colors.white,
                                              fontFamily: appMainFont,
                                              fontSize: Adaptive.px(35),
                                            ),
                                          ),
                                          //if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(2.9),
                                          ),
                                          // if (index == 1)
                                          Text(
                                            "Choose your Username and set your Password",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                                fontFamily: appMainFont,
                                                fontSize: Adaptive.px(13),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(5),
                                          ),
                                          // if (index == 1)
                                          Customtextfield(
                                            onchange: (data) {
                                              // search.text = data;
                                              setState(() {});
                                            },
                                            fillcolor: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.transparent,
                                            controller: username,
                                            textinputAction:
                                                TextInputAction.next,
                                            leadingwidget: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: SvgPicture.asset(
                                                "Assets/Images/profile.svg",
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                              ),
                                            ),
                                            labeltext: "Choose Username*",
                                          ),
                                          if (alreadyexists)
                                            const Text(
                                              "Username already taken",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),

                                          //if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(2.3),
                                          ),
                                          // if (index == 1)
                                          Customtextfield(
                                            onchange: (val) {
                                              setState(() {
                                                isExpanded = true;
                                              });
                                            },
                                            ontap: () {
                                              // setState(() {

                                              // });
                                              // print("value is $isExpanded");
                                            },
                                            fillcolor: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.transparent,
                                            controller: password,
                                            password: showpassword,
                                            textinputAction:
                                                TextInputAction.next,
                                            trailingwidget: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showpassword = !showpassword;
                                                });
                                              },
                                              child: Icon(
                                                showpassword
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? hintTextColor
                                                    : Colors.white,
                                              ),
                                            ),
                                            leadingwidget: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: SvgPicture.asset(
                                                "Assets/Images/password.svg",
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                              ),
                                            ),
                                            labeltext: "Password*",
                                          ),
                                          //if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(2.3),
                                          ),
                                          //if (index == 1)
                                          Customtextfield(
                                            onchange: (val) {
                                              setState(() {
                                                isExpanded = true;
                                              });
                                            },
                                            fillcolor: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.transparent,
                                            controller: repeatpassword,
                                            password: showrepeatpassword,
                                            trailingwidget: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showrepeatpassword =
                                                      !showrepeatpassword;
                                                });
                                              },
                                              child: Icon(
                                                showrepeatpassword
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? hintTextColor
                                                    : Colors.white,
                                              ),
                                            ),
                                            leadingwidget: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: SvgPicture.asset(
                                                "Assets/Images/repeatpassword.svg",
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                              ),
                                            ),
                                            labeltext: "Repeat Password*",
                                          ),
                                          // if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(1.1),
                                          ),
                                          Container(
                                            child: Text(
                                              "Password: at least 8 characters,\n"
                                              "1 capital letter and 1 number",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: hintTextColor,
                                                  fontFamily: workSansRegular,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          //if (index == 1)
                                          SizedBox(
                                            height: Adaptive.h(11.4),
                                          ),

                                          // const Spacer(),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    AdaptiveTheme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? mainBtnColor
                                                        : btnDarkBgColor,
                                                side: BorderSide(
                                                  width: 2.0,
                                                  color:
                                                      AdaptiveTheme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? mainTextColor
                                                          : Colors.white,
                                                )),
                                            onPressed: () {
                                              if (!validationfirst(context))
                                                return;
                                              checkusername(context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                "Continue",
                                                style: TextStyle(
                                                  fontFamily: workSansSemibold,
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  FadeInRight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // SvgPicture.asset(
                                        //   "Assets/Images/s2.svg",
                                        //   height:
                                        //       MediaQuery.of(context).size.height / 5,
                                        // ),
                                        SizedBox(
                                          height: Adaptive.h(3.5),
                                        ),
                                        Text(
                                          //"Sign up \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n to get started!",
                                          "Second Step",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: Adaptive.px(35),
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : Colors.white,
                                              fontFamily: appMainFont),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(
                                              top: Adaptive.h(2.6),
                                              bottom: Adaptive.h(5.1)),
                                          child: Text(
                                            "Tell us your Full Name, Gender and Birthday",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white
                                                        .withOpacity(.6),
                                                fontFamily: appMainFont,
                                                fontSize: Adaptive.px(13)),
                                          ),
                                        ),

                                        Customtextfield(
                                          fillcolor: AdaptiveTheme.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : Colors.transparent,
                                          controller: name,
                                          labeltext: "Full Name*",
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2.3),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                      color: AdaptiveTheme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Color(0xff363843),
                                                    ),
                                                    child: IntrinsicHeight(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 50),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 5,
                                                                  width: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AdaptiveTheme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? Colors
                                                                            .black12
                                                                        : Color(
                                                                            0xff575C6C),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () {
                                                                gender = "Male";
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  // CircleAvatar(
                                                                  //   radius: 15,
                                                                  //   backgroundColor:
                                                                  //       Colors.white,
                                                                  //   child: SvgPicture
                                                                  //       .asset(
                                                                  //     "Assets/Images/upload.svg",
                                                                  //   ),
                                                                  // ),
                                                                  // SizedBox(
                                                                  //   width: 20,
                                                                  // ),
                                                                  Text(
                                                                    "Male",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontFamily:
                                                                          appMainFont,
                                                                      fontSize:
                                                                          18,
                                                                      color: AdaptiveTheme.of(context).brightness ==
                                                                              Brightness.light
                                                                          ? mainTextColor
                                                                          : Colors.white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Divider(
                                                              color: AdaptiveTheme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? mainTextColor
                                                                  : Color(
                                                                      0xff596687),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () {
                                                                gender =
                                                                    "Female";
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Female",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontFamily:
                                                                          appMainFont,
                                                                      fontSize:
                                                                          18,
                                                                      color: AdaptiveTheme.of(context).brightness ==
                                                                              Brightness.light
                                                                          ? mainTextColor
                                                                          : Colors.white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Divider(
                                                              color: AdaptiveTheme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? mainTextColor
                                                                  : Color(
                                                                      0xff596687),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () {
                                                                gender =
                                                                    "Others";
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Others",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontFamily:
                                                                          appMainFont,
                                                                      fontSize:
                                                                          18,
                                                                      color: AdaptiveTheme.of(context).brightness ==
                                                                              Brightness.light
                                                                          ? mainTextColor
                                                                          : Colors.white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Adaptive.h(2.2),
                                                horizontal: Adaptive.w(2.2)),
                                            decoration: BoxDecoration(
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffD0D0D0),
                                                  // color: AdaptiveTheme.of(context)
                                                  //             .brightness ==
                                                  //         Brightness.dark
                                                  //     ? Colors.white
                                                  //     : maincolor,
                                                  width: 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  gender ?? "Gender",
                                                  style: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily:
                                                          workSansRegular,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color:
                                                      AdaptiveTheme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? mainTextColor
                                                          : Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Customtextfield(
                                        //   ontap: () {
                                        //     print("hello");
                                        //   },
                                        //   labeltext: "Gender",
                                        //   trailingwidget: Icon(
                                        //     Icons.keyboard_arrow_down,
                                        //     color: AdaptiveTheme.of(context)
                                        //                 .brightness ==
                                        //             Brightness.light
                                        //         ? maincolor
                                        //         : Colors.white,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: Adaptive.h(2.3),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            dateofbirthsheet(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Adaptive.h(2.2),
                                                horizontal: Adaptive.w(2.2)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  dateofbirth ??
                                                      "Set Birthday*",
                                                  style: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily:
                                                          workSansRegular,
                                                      fontSize: 14),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color:
                                                      AdaptiveTheme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? mainTextColor
                                                          : Colors.white,
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              // color: AdaptiveTheme.of(context)
                                              //             .brightness ==
                                              //         Brightness.light
                                              //     ? maincolor
                                              //     : Colors.white,
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffD0D0D0),
                                                  // color: AdaptiveTheme.of(context)
                                                  //             .brightness ==
                                                  //         Brightness.dark
                                                  //     ? Colors.white
                                                  //     : maincolor,
                                                  width: 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(1.2),
                                        ),
                                        Text(
                                          "User must be over 16 years of age",
                                          style: TextStyle(
                                              fontFamily: workSansRegular,
                                              color: hintTextColor,
                                              fontSize: Adaptive.px(12)),
                                          textAlign: TextAlign.end,
                                        ),
                                        // const Spacer(),
                                        SizedBox(
                                          height: Adaptive.h(12.3),
                                        ),

                                        // Expanded(
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       index = 1;
                                        //       controller.previousPage(
                                        //           duration: Duration(
                                        //               milliseconds: 500),
                                        //           curve: Curves.easeIn);
                                        //       setState(() {});
                                        //     },
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(20),
                                        //       child: Text(
                                        //         "Back",
                                        //         style: TextStyle(
                                        //           fontFamily: "greycliffcf",
                                        //           fontWeight: FontWeight.w100,
                                        //           fontSize: 16,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              side: BorderSide(
                                                  color:
                                                      AdaptiveTheme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? mainTextColor
                                                          : Colors.white,
                                                  width: 2)),
                                          onPressed: () {
                                            if (!validationsecond(context))
                                              return;
                                            index = 3;
                                            controller.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeIn);
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              "Continue",
                                              style: TextStyle(
                                                fontFamily: workSansSemibold,
                                                fontSize: Adaptive.px(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInRight(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // SvgPicture.asset(
                                          //   "Assets/Images/s3.svg",
                                          //   height:
                                          //       MediaQuery.of(context).size.height / 5,
                                          // ),
                                          SizedBox(
                                            height: Adaptive.h(3),
                                          ),
                                          Text(
                                            //"Sign up \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n to get started!",
                                            "Last Step",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                // fontWeight: FontWeight.w900,
                                                fontSize: Adaptive.px(35),
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                                fontFamily: appMainFont),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(2.6),
                                          ),
                                          Text(
                                            "Please tell us your Origin and Email Address",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: appMainFont,
                                                fontSize: Adaptive.px(13),
                                                color: AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white
                                                        .withOpacity(.7),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(5),
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // SlideDialog.showSlideDialog(
                                                    //   context: context,
                                                    //   backgroundColor:
                                                    //       AdaptiveTheme.of(context)
                                                    //                   .brightness ==
                                                    //               Brightness.dark
                                                    //           ? maincolordark
                                                    //           : maincolor,
                                                    //   pillColor: Colors.white,
                                                    //   transitionDuration:
                                                    //       const Duration(
                                                    //           milliseconds: 300),
                                                    //   child: Expanded(
                                                    //     child: Column(
                                                    //       mainAxisSize:
                                                    //           MainAxisSize.min,
                                                    //       children: [
                                                    //         Padding(
                                                    //           padding:
                                                    //               EdgeInsets.only(
                                                    //                   bottom: 20),
                                                    //           child: SizedBox(
                                                    //             width: MediaQuery.of(
                                                    //                         context)
                                                    //                     .size
                                                    //                     .height *
                                                    //                 .35,
                                                    //             child: TextField(
                                                    //               cursorColor:
                                                    //                   Colors.white,
                                                    //               cursorWidth: 1,
                                                    //               style: TextStyle(
                                                    //                   color: Colors
                                                    //                       .white,
                                                    //                   fontFamily:
                                                    //                       workSansRegular,
                                                    //                   fontSize: 14),
                                                    //               onChanged:
                                                    //                   (text) {},
                                                    //               controller:
                                                    //                   searchController,
                                                    //               decoration:
                                                    //                   InputDecoration(
                                                    //                       focusedBorder: const OutlineInputBorder(
                                                    //                           borderRadius: BorderRadius.all(Radius.circular(
                                                    //                               10)),
                                                    //                           borderSide: BorderSide(
                                                    //                               color: Colors
                                                    //                                   .white)),
                                                    //                       hintStyle: TextStyle(
                                                    //                           color: Colors
                                                    //                               .white,
                                                    //                           fontFamily:
                                                    //                               workSansRegular,
                                                    //                           fontSize:
                                                    //                               14),
                                                    //                       border: const OutlineInputBorder(
                                                    //                           borderSide: BorderSide(
                                                    //                               color: Colors
                                                    //                                   .white)),
                                                    //                       enabledBorder: const OutlineInputBorder(
                                                    //                           borderRadius: BorderRadius.all(Radius.circular(
                                                    //                               10)),
                                                    //                           borderSide:
                                                    //                               BorderSide(color: Colors.white)),
                                                    //                       hintText: 'Type in your country',
                                                    //                       prefixIcon: const Icon(
                                                    //                         Icons
                                                    //                             .search,
                                                    //                         color: Colors
                                                    //                             .white,
                                                    //                       )),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //         Expanded(
                                                    //           // height: 600,
                                                    //           child: Container(
                                                    //             color: Colors.white,
                                                    //             child:
                                                    // ListView
                                                    //                 .builder(
                                                    //               shrinkWrap: true,
                                                    //               primary: false,
                                                    //               itemCount:
                                                    //                   countries
                                                    //                       .length,
                                                    //               itemBuilder:
                                                    //                   (context,
                                                    //                       index) {
                                                    //                 return ListTile(
                                                    //                   onTap: () {
                                                    //                     country = countries[
                                                    //                             index]
                                                    //                         [
                                                    //                         "country_name"];
                                                    //                     countryid = countries[index]
                                                    //                             [
                                                    //                             "id"]
                                                    //                         .toString();
                                                    //                     setState(
                                                    //                         () {});
                                                    //                     Navigator.pop(
                                                    //                         context);
                                                    //                   },
                                                    //                   title: Text(
                                                    //                     countries[
                                                    //                             index]
                                                    //                         [
                                                    //                         "country_name"],
                                                    //                   ),
                                                    //                   subtitle:
                                                    //                       Text(
                                                    //                     countries[
                                                    //                             index]
                                                    //                         [
                                                    //                         "country_code"],
                                                    //                   ),
                                                    //                 );
                                                    //               },
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // );

                                                    showModalBottomSheet(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            height: isFocus
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .6
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .45,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                              color: AdaptiveTheme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? Colors.white
                                                                  : Color(
                                                                      0xff363843),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 110,
                                                                  // padding: const EdgeInsets
                                                                  //         .symmetric(
                                                                  //     horizontal:
                                                                  //         40,
                                                                  //     vertical: 0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                    color: AdaptiveTheme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? mainTextColor
                                                                        : Color(
                                                                            0xff363843),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            150,
                                                                        decoration: BoxDecoration(
                                                                            color: AdaptiveTheme.of(context).brightness == Brightness.light
                                                                                ? Color(0xffBECBEB)
                                                                                : Color(0xff575C6C),
                                                                            borderRadius: BorderRadius.all(Radius.circular(2))),
                                                                        margin: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                15),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 40),
                                                                        child:
                                                                            TextField(
                                                                          focusNode:
                                                                              focusNode,
                                                                          cursorColor:
                                                                              Colors.white,
                                                                          cursorWidth:
                                                                              1,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: workSansRegular,
                                                                              fontSize: 14),
                                                                          onChanged:
                                                                              (String? value) {
                                                                            searchString =
                                                                                value.toString();
                                                                            setState(() {});
                                                                            print("Node is : ${isFocus}");
                                                                            setState(() {
                                                                              isFocus = focusNode.hasFocus;
                                                                              searchString = value.toString();
                                                                            });
                                                                          },
                                                                          controller:
                                                                              searchController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.white)),
                                                                            hintStyle: TextStyle(
                                                                                color: Colors.white,
                                                                                fontFamily: workSansRegular,
                                                                                fontSize: 14),
                                                                            border:
                                                                                const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                            enabledBorder:
                                                                                const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Color(0xffBECBEB))),
                                                                            hintText:
                                                                                'Type in your country',
                                                                            prefixIcon:
                                                                                const Icon(
                                                                              Icons.search,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            20),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        primary: false,
                                                                        itemCount: countries.length,
                                                                        itemBuilder: (context, index) {
                                                                          if (searchString
                                                                              .isEmpty) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                country = countries[index]["country_name"];
                                                                                countryid = countries[index]["id"].toString();
                                                                                setState(() {});
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          // SvgPicture.network(
                                                                                          //   "https://wependio.maaheytechnologies.com/goal_images/wependio_goal_Patches_WorldTraveler.svg",
                                                                                          //   height: 28,
                                                                                          //   width: 48,
                                                                                          // ),
                                                                                          Image.network(
                                                                                            countries[index]['country_icon'],
                                                                                            width: 48,
                                                                                            height: 28,
                                                                                          ),
                                                                                          Flexible(
                                                                                            child: Text(
                                                                                              countries[index]["country_name"],
                                                                                              style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 18, fontFamily: appMainFont, color: AdaptiveTheme.of(context).brightness == Brightness.light ? mainTextColor : Colors.white, fontWeight: FontWeight.w700),
                                                                                            ),
                                                                                          ),
                                                                                          Container(margin: const EdgeInsets.only(left: 10), child: Text("(${countries[index]["country_code"]})", style: TextStyle(fontSize: 18, fontFamily: appMainFont, color: AdaptiveTheme.of(context).brightness == Brightness.light ? mainTextColor : Colors.white, fontWeight: FontWeight.w700))),
                                                                                        ],
                                                                                      ),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.symmetric(vertical: 20),
                                                                                        child: Divider(
                                                                                          color: Color(0xff7D94CC),
                                                                                          height: 2,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            );
                                                                          } else if (countries[index]["country_name"]
                                                                              .toLowerCase()
                                                                              .contains(searchString.toLowerCase())) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                country = countries[index]["country_name"];
                                                                                countryid = countries[index]["id"].toString();
                                                                                setState(() {});
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          // SvgPicture.network(
                                                                                          //   "https://wependio.maaheytechnologies.com/goal_images/wependio_goal_Patches_WorldTraveler.svg",
                                                                                          //   height: 28,
                                                                                          //   width: 48,
                                                                                          // ),
                                                                                          SizedBox(
                                                                                            width: 80,
                                                                                            height: 30,
                                                                                            child: Image.network("${countries[index]["country_icon"].toString()}"),
                                                                                          ),
                                                                                          Container(
                                                                                              margin: const EdgeInsets.only(left: 20),
                                                                                              child: Text(
                                                                                                countries[index]["country_name"],
                                                                                                style: TextStyle(fontSize: 18, fontFamily: appMainFont, color: mainTextColor, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                          Container(margin: EdgeInsets.only(left: 10), child: Text("(${countries[index]["country_code"]})", style: TextStyle(fontSize: 18, fontFamily: appMainFont, color: mainTextColor, fontWeight: FontWeight.w700))),
                                                                                        ],
                                                                                      ),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.symmetric(vertical: 20),
                                                                                        child: Divider(
                                                                                          color: Color(0xff7D94CC),
                                                                                          height: 2,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            );
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                Adaptive.h(1.6),
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      // color: AdaptiveTheme.of(context)
                                                      //             .brightness ==
                                                      //         Brightness.light
                                                      //     ? maincolor
                                                      //     : Colors.white,
                                                      color: AdaptiveTheme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffD0D0D0),
                                                          // color: AdaptiveTheme.of(context)
                                                          //             .brightness ==
                                                          //         Brightness.dark
                                                          //     ? Colors.white
                                                          //     : maincolor,
                                                          width: 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                          child: Text(
                                                            country ??
                                                                "Country*",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color:
                                                                    hintTextColor,
                                                                fontFamily:
                                                                    workSansRegular,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: AdaptiveTheme.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? mainTextColor
                                                              : Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Customtextfield(
                                                //   labeltext: "Country",
                                                //   trailingwidget: Icon(
                                                //     Icons.keyboard_arrow_down,
                                                //     color: AdaptiveTheme.of(context)
                                                //                 .brightness ==
                                                //             Brightness.light
                                                //         ? maincolor
                                                //         : Colors.black,
                                                //   ),
                                                // ),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(4.5),
                                              ),
                                              Expanded(
                                                child: Customtextfield(
                                                  fillcolor:
                                                      AdaptiveTheme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                  controller: zipcode,
                                                  labeltext: "Zip Code*",
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(2),
                                          ),
                                          Customtextfield(
                                            controller: town,
                                            labeltext: "Town*",
                                            fillcolor: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(1.7),
                                          ),
                                          Container(
                                            child: Customtextfield(
                                              controller: residential,
                                              labeltext: "Residential Address*",
                                              fillcolor:
                                                  AdaptiveTheme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.white
                                                      : Colors.transparent,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(2),
                                          ),
                                          Customtextfield(
                                            controller: email,
                                            labeltext: "Email*",
                                            fillcolor: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(4),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: Adaptive.h(2.6),
                                                  width: Adaptive.w(5.7),
                                                  child: Checkbox(
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(maincolor),
                                                      side: const BorderSide(
                                                        color: Color(
                                                            0xffD0D0D0), //your desire colour here
                                                        width: 1,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      value: remember,
                                                      onChanged: (value) {
                                                        remember = value!;
                                                        setState(() {});
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(2),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Send me updates from wependio with tailored offers and information.",
                                                    style: TextStyle(
                                                        color: hintTextColor,
                                                        fontFamily:
                                                            nunitoSansRegular,
                                                        fontSize:
                                                            Adaptive.px(11.5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(4),
                                          ),
                                          CommonButton(
                                              onTap: () {
                                                debugPrint(
                                                    countries.toString());
                                                if (!validationthird(context))
                                                  return;
                                                signingup(context);
                                              },
                                              title: "Sign Up")
                                          // ElevatedButton(
                                          //   style: ElevatedButton.styleFrom(
                                          //       primary:
                                          //           AdaptiveTheme.of(context)
                                          //                       .brightness ==
                                          //                   Brightness.light
                                          //               ? maincolor
                                          //               : btnDarkBgColor,
                                          //       side: BorderSide(
                                          //           color: AdaptiveTheme.of(
                                          //                           context)
                                          //                       .brightness ==
                                          //                   Brightness.light
                                          //               ? mainTextColor
                                          //               : Colors.white,
                                          //           width: 2)),
                                          //   onPressed: () {

                                          //   },
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(16),
                                          //     child: Text(
                                          //       "Sign Up",
                                          //       style: TextStyle(
                                          //         fontFamily: workSansSemibold,
                                          //         // fontWeight: FontWeight.w600,
                                          //         fontSize: Adaptive.px(14),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          ,
                                          Container(
                                            // margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "By signing up, you agree to our Terms. Learn how we collect, use and share your data in our Privacy Policy and how we use cookies and similar technology in our Cookies Policy. ",
                                              // textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: hintTextColor,
                                                  fontFamily: nunitoSansRegular,
                                                  fontSize: Adaptive.px(11)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            );
          }),
        );
      }),
    );
  }
}
// https://restcountries.com/v2/all
