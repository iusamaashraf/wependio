import 'dart:convert';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Models/Placesmodel.dart';
import 'package:wependio/Screens/enterwependioscreen.dart';
import 'package:wependio/Screens/sendyourwependiosc.dart';
import 'package:wependio/apis/addfavoriteplace.dart';
import 'package:wependio/apis/favoriteplaces.dart';
import 'package:wependio/apis/searchplaces.dart';
import 'package:wependio/constants.dart';
import 'package:widget_loading/widget_loading.dart';

import '../Widgets/Textfieldwidget.dart';

class Favouriteplaces extends StatefulWidget {
  const Favouriteplaces({Key? key}) : super(key: key);

  @override
  _FavouriteplacesState createState() => _FavouriteplacesState();
}

class _FavouriteplacesState extends State<Favouriteplaces> {
  ///Variables
  List<Placesmodel> cities = [];
  List<Placesmodel> selectedCites = [];
  List city = [];

  bool loading = false;
  List places = [];
  List selectedPlaces = [];

  TextEditingController search = TextEditingController();
  List placesid = [];
  ////Functions
  getfavourites() async {
    setState(() {
      loading = true;
    });

    getFaoritePlace().then((responsex) async {
      List placess = responsex["places"];
      // print(placess);
      Future.delayed(const Duration(seconds: 1), () {
        placess.forEach((element) {
          cities.add(Placesmodel.fromJson(element));
        });
        // print(cities);
        setState(() {
          loading = false;
        });
      });
    });
  }

  gettingplaces(String text) async {
    places.clear();

    // setState(
    //   () {
    //     loading = true;
    //   },
    // );
    searchPlace(search: search.text).then((responsex) {
      var placesx = responsex["places"];
      places = List<Placesmodel>.from(
          placesx.map((data) => Placesmodel.fromJson(data)).toList());
    });
    setState(() {
      loading = false;
    });
  }

  settingfavourites() async {
    setState(
      () {
        loading = true;
      },
    );
    List data = [];
    city.forEach((element) {
      data.add({
        "places[]": element.id.toString(),
      });
    });
    print(data);
    if (data.isNotEmpty && data.length == 6) {
      addPlace(data: data).then((value) {
        // print(value);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Setyourwependiogoals();
        }));
        setState(() {
          loading = false;
        });
      });
    } else {
      setState(() {
        loading = false;
      });

      ValidationBottomSheet(context, "Select 6 places.");
    }
    // var placesx = responsex.data["places"];
    // places = List<Placesmodel>.from(
    //     placesx.map((data) => Placesmodel.fromJson(data)).toList());
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

  @override
  void initState() {
    getfavourites();
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color:
                      AdaptiveTheme.of(context).brightness == Brightness.light
                          ? mainTextColor
                          : Colors.white,
                ))),
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
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.width / 9,
                      // ),

                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Set your\n favorite places",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                fontFamily: appMainFont,
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? mainTextColor
                                    : Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "We know everyone has them",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? mainTextColor
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: appMainFont),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // CustomDropdownButton2(
                          //   hint: 'Select Item',
                          //   dropdownItems: items,
                          //   value: selectedValue,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedValue = value;
                          //     });
                          //   },
                          // ),

                          Customtextfield(
                            onchange: (data) {
                              // search.text = data;
                              if (data.trim().toLowerCase().length < 4) {
                                places.clear();
                                setState(() {});
                              } else {
                                gettingplaces(data);
                              }
                              setState(() {});
                            },
                            controller: search,
                            fillcolor: AdaptiveTheme.of(context).brightness ==
                                    Brightness.light
                                ? Colors.white
                                : Colors.transparent,
                            leadingwidget: Icon(
                              Icons.search,
                              color: AdaptiveTheme.of(context).brightness ==
                                      Brightness.light
                                  ? mainTextColor
                                  : Colors.white,
                            ),
                            labeltext: "Search for destinations",
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: AdaptiveTheme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : const Color(0xff2B2B2F),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            margin: const EdgeInsets.only(top: 20),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: search.text.trim().length < 4
                                      ? 0
                                      : places.isEmpty
                                          ? 0
                                          : 180,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffD0D0D0),
                                        width: 1),
                                  ),
                                  child: Column(
                                    children: [
                                      // const SizedBox(
                                      //   height: 60,
                                      // ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: places.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    trailing: Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration: BoxDecoration(
                                                              color: AdaptiveTheme.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? mainTextColor
                                                                  : const Color(
                                                                      0xff38383E),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              if (selectedPlaces
                                                                      .length >=
                                                                  3) {
                                                                ValidationBottomSheet(
                                                                    context,
                                                                    "You can only select three interests at a time");
                                                              } else {
                                                                if (!selectedPlaces
                                                                    .contains(
                                                                        places[
                                                                            index])) {
                                                                  selectedPlaces
                                                                      .add(places[
                                                                          index]);
                                                                  placesid.add(
                                                                      places[index]
                                                                          .id
                                                                          .to);
                                                                  setState(
                                                                      () {});
                                                                }
                                                              }
                                                              ItemsBottomSheetModel(
                                                                  context);
                                                              placesid.contains(
                                                                      places[index]
                                                                          .id
                                                                          .toString())
                                                                  // ignore: list_remove_unrelated_type
                                                                  ? placesid.remove(
                                                                      places[index]
                                                                          .id
                                                                          .toString())
                                                                  : places.add(
                                                                      places[index]
                                                                          .id);
                                                              setState(() {});
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                    title: Text(
                                                      places[index].name!,
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xffABB3BB),
                                                          fontFamily:
                                                              workSansSemibold,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    height: 3,
                                                    color: Color(0xffD8D8D8),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          if (cities.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        ItemsBottomSheetModel(context);
                                        city.contains(cities[0])
                                            ? city.remove(cities[0])
                                            : city.add(cities[0]);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: city.contains(cities[0])
                                              ? AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : const Color(0xff333339)
                                              : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            cities[0].name ?? "",
                                            style: TextStyle(
                                              fontFamily: workSansRegular,
                                              fontSize: 14,
                                              color: city.contains(cities[0])
                                                  ? Colors.white
                                                  : AdaptiveTheme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? mainTextColor
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        city.contains(cities[1])
                                            ? city.remove(cities[1])
                                            : city.add(cities[1]);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Center(
                                          child: Text(
                                            cities[1].name ?? "",
                                            style: TextStyle(
                                              fontFamily: workSansRegular,
                                              fontSize: 14,
                                              color: city.contains(cities[1])
                                                  ? Colors.white
                                                  : AdaptiveTheme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? mainTextColor
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: city.contains(cities[1])
                                              ? AdaptiveTheme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? mainTextColor
                                                  : const Color(0xff333339)
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (cities.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      city.contains(cities[2])
                                          ? city.remove(cities[2])
                                          : city.add(cities[2]);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Center(
                                        child: Text(
                                          cities[2].name ?? "",
                                          style: TextStyle(
                                            fontFamily: workSansRegular,
                                            fontSize: 14,
                                            color: city.contains(cities[2])
                                                ? Colors.white
                                                : AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: city.contains(cities[2])
                                            ? AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : const Color(0xff333339)
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      city.contains(cities[3])
                                          ? city.remove(cities[3])
                                          : city.add(cities[3]);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: city.contains(cities[3])
                                            ? AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : const Color(0xff333339)
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          cities[3].name ?? "",
                                          style: TextStyle(
                                            fontFamily: workSansRegular,
                                            fontSize: 14,
                                            color: city.contains(cities[3])
                                                ? Colors.white
                                                : AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (cities.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      city.contains(cities[4])
                                          ? city.remove(cities[4])
                                          : city.add(cities[4]);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Center(
                                        child: Text(
                                          cities[4].name ?? "",
                                          style: TextStyle(
                                            fontFamily: workSansRegular,
                                            fontSize: 14,
                                            color: city.contains(cities[4])
                                                ? Colors.white
                                                : AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: city.contains(cities[4])
                                            ? AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : const Color(0xff333339)
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      city.contains(cities[5])
                                          ? city.remove(cities[5])
                                          : city.add(cities[5]);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Center(
                                        child: Text(
                                          cities[5].name ?? "",
                                          style: TextStyle(
                                            fontFamily: workSansRegular,
                                            fontSize: 14,
                                            color: city.contains(cities[5])
                                                ? Colors.white
                                                : AdaptiveTheme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? mainTextColor
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: city.contains(cities[5])
                                            ? AdaptiveTheme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? mainTextColor
                                                : const Color(0xff333339)
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          // Wrap(
                          //   alignment: WrapAlignment.spaceAround,
                          //   spacing: 20,
                          //   runSpacing: 20,
                          //   // runAlignment: WrapAlignment.spaceAround,
                          //   // crossAxisAlignment: WrapCrossAlignment.center,
                          //   children: [
                          //     for (var data in cities)

                          //   ],
                          // ),
                          const SizedBox(
                            height: 30,
                          ),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Select a maximum of 6 places.',
                              style: TextStyle(
                                  fontFamily: appMainFont,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white.withOpacity(.5)),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'You can also do\n that later in your account.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AdaptiveTheme.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? mainTextColor
                                            : Colors.white.withOpacity(.5),
                                        fontFamily: appMainFont)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
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
                          settingfavourites();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return Setyourwependiogoals();
                          // }));
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

                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Setyourwependiogoals();
                              }));
                            },
                            child: Text(
                              'Skip for Now',
                              style: TextStyle(
                                  fontFamily: appMainFont,
                                  fontWeight: FontWeight.w900,
                                  color: AdaptiveTheme.of(context).brightness ==
                                          Brightness.light
                                      ? mainTextColor
                                      : Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
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
                              "${selectedPlaces.length.toString()} selected",
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
                              selectedPlaces.clear();
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

                        for (var data in selectedPlaces)
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
                                    selectedPlaces.remove(data);
                                    placesid.remove(data.id);
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
