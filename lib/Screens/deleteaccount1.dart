import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wependio/Screens/deleteaccount2screen.dart';

import '../constants.dart';

class Deleteaccount extends StatefulWidget {
  const Deleteaccount({Key? key}) : super(key: key);

  @override
  _DeleteaccountState createState() => _DeleteaccountState();
}

class _DeleteaccountState extends State<Deleteaccount> {
  String issuetype = "Too many advertisements";
  int group = 1;
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
          "Delete Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 1,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Too Many Advertisements";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Too Many Advertisements",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 2,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Initial Difficulties";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Initial Difficulties",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 3,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Second Account";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Second Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 4,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Cannot find anyone to follow";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Cannot find anyone to follow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 5,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "I need a break";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "I need a break",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 6,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Too busy/too much distraction";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Too busy/too much distraction",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 7,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Privacy Concerns";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Privacy Concerns",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 8,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "I would like to remove something";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "I would like to remove something",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: maincolor,
                  ),
                  child: Radio(
                    value: 9,
                    groupValue: group,
                    onChanged: (int? value) {
                      setState(() {
                        group = value!;
                        issuetype = "Other";
                      });
                    },
                    activeColor: maincolor,
                  ),
                ),
                title: Text(
                  "Other",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        AdaptiveTheme.of(context).brightness == Brightness.light
                            ? maincolor
                            : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Deleteaccount2();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "greycliffcf",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(
                      //   width: 1.0,
                      //   color: Colors.red,

                      //   borderRadius: BorderRadius.circular(5.0),
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
