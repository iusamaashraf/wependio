import 'package:flutter/material.dart';
import 'package:wependio/Screens/Splashscreen.dart';

import '../Screens/enterwependioscreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ('/'):
      return MaterialPageRoute(
          settings: settings, builder: (context) => Splashscreen());
    default:
      return MaterialPageRoute(
          settings: settings, builder: (context) => Splashscreen());
  }
}
