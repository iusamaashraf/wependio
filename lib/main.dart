import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/Screens/Signupscreen.dart';
import 'package:wependio/Screens/Splashscreen.dart';
import 'package:wependio/Screens/Verifyemailscreen.dart';
import 'package:wependio/Screens/enterwependioscreen.dart';
import 'package:wependio/Screens/favouriteplaces.dart';
import 'package:wependio/Screens/sendyourwependiosc.dart';
import 'package:wependio/Screens/toggledarkmodescreen.dart';
import 'package:wependio/Screens/uploadprofilepicture.dart';
import 'package:wependio/constants.dart';
import 'package:wependio/testing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  savedThemeMode = await AdaptiveTheme.getThemeMode();
  if (prefs.containsKey("theme")) {
    themex = prefs.getString("theme");
  }
  print(themex);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      //light theme
      light: lighttheme,

      //dark theme
      dark: darktheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      // AdaptiveThemeMode.light,
      // themex == null
      //     ? AdaptiveThemeMode.light
      //     : themex == "light"
      //         ? AdaptiveThemeMode.light
      //         : AdaptiveThemeMode.dark,

      builder: (theme, darkTheme) => ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              home:
                  // Toggledarkmodescreen()
                  Splashscreen());
        },
      ),
    );
  }
}

String? themex;

AdaptiveThemeMode? savedThemeMode;
String? token;
String? emailv;
String? namev;
