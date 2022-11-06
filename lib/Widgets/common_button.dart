import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wependio/constants.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AdaptiveTheme.of(context).brightness == Brightness.light
              ? maincolor
              : btnDarkBgColor,
          side: BorderSide(
              width: 2,
              color: AdaptiveTheme.of(context).brightness == Brightness.light
                  ? mainTextColor
                  : Colors.white)),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adaptive.w(10), vertical: Adaptive.h(2.8)),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: workSansSemibold,
            // fontWeight: FontWeight.w100,
            fontSize: Adaptive.px(14),
          ),
        ),
      ),
      // style: ButtonStyle(
      //   elevation: MaterialStateProperty.all<double>(0),
      //   shape: MaterialStateProperty.all<OutlinedBorder>(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       // side: BorderSide(
      //       //   width: 1.0,
      //       //   color: Colors.red,

      //       //   borderRadius: BorderRadius.circular(5.0),
      //       // ),
      //     ),
      //   ),
      // ),
    );
  }
}
