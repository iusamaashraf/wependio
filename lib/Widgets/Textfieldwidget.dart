import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants.dart';

class Customtextfield extends StatelessWidget {
  String labeltext;
  bool password;
  TextInputType keyboardtype;
  TextEditingController? controller;
  Widget? leadingwidget;
  Widget? trailingwidget;
  Color? fillcolor;
  bool? enabled;
  int? maxlines;
  TextInputAction? textinputAction;
  VoidCallback? ontap;
  Function(String)? onchange;
  Customtextfield({
    this.fillcolor,
    required this.labeltext,
    this.password = false,
    this.keyboardtype = TextInputType.text,
    this.controller,
    this.leadingwidget,
    this.trailingwidget,
    this.enabled = true,
    this.maxlines = 1,
    this.ontap,
    this.onchange,
    this.textinputAction,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        ontap;
      },
      onChanged: onchange,
      maxLines: maxlines,
      scrollPadding: EdgeInsets.zero,
      keyboardType: keyboardtype,
      cursorColor: maincolor,
      obscureText: password,
      controller: controller ?? TextEditingController(text: ""),
      textInputAction: textinputAction ?? TextInputAction.done,
      style: TextStyle(
          color: AdaptiveTheme.of(context).brightness == Brightness.light
              ? mainTextColor
              : Colors.white,
          fontFamily: workSansSemibold,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Adaptive.h(2.2), horizontal: Adaptive.w(2.2)),
        prefixIcon: leadingwidget ?? null,
        suffixIcon: trailingwidget ?? null,

        hintStyle: TextStyle(
          fontSize: Adaptive.px(13),
          color: hintTextColor,
          fontFamily: workSansRegular,
        ),
        hintText: labeltext,

        enabled: enabled!,
        fillColor: fillcolor ?? Colors.white,
        prefixIconColor: maincolor,
        suffixIconColor: maincolor, //Colors.black.withOpacity(0.08),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Color(0xffD0D0D0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(
              color: AdaptiveTheme.of(context).brightness == Brightness.light
                  ? mainTextColor
                  : Color(0xffD0D0D0),
              width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Color(0xffD0D0D0)),
        ),
      ),
    );
  }
}

class Customtextfieldtransparent extends StatelessWidget {
  String labeltext;
  bool password;
  TextInputType keyboardtype;
  TextEditingController? controller;
  int maxlines;
  Customtextfieldtransparent({
    required this.labeltext,
    this.password = false,
    this.keyboardtype = TextInputType.text,
    this.controller,
    this.maxlines = 1,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.zero,
      keyboardType: keyboardtype,
      cursorColor: maincolor,
      obscureText: password,
      controller: controller ?? TextEditingController(text: ""),
      maxLines: maxlines,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            color: hintTextColor, fontSize: 14, fontFamily: workSansRegular),
        hintText: labeltext,
        fillColor: Color(0xffE8ECF4),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
