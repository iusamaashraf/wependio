// // ignore_for_file: avoid_single_cascade_in_expression_statements

// import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class ApiServices {
//   Future<Response> postrequests(BuildContext context, dynamic formData,
//       Options options, String endpoint) async {
//     final navigator = Navigator.of(context);
//     CoolAlert.show(
//         context: context,
//         type: CoolAlertType.loading,
//         backgroundColor: Colors.white24);
//     try {
//       print(endpoint);
//       final responsex = await Dio().post(
//         endpoint,
//         // "https://api-dev.worktools.fr/shared/article_pro/add",
//         //signup,
//         data: formData,
//         options: options,
//       );
//       navigator.pop();
//       return responsex;
//     } on SocketException catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: e.message,
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
// //logger.e(e);
//       throw Exception("Not Internet Connection");
//     } on FormatException catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: "Bad response format",
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //    logger.e(e);
//       throw Exception("Bad response format");
//     } on DioError catch (e) {
//       print(e.response!.statusCode);
//       print(e.response!.data["message"]);
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: e.response!.data["message"] == "Unauthorised."
//             ? "Please check your email and password and try again"
//             : e.response!.data["message"],
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //  logger.e(e);
//       throw Exception(e);
//     } catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: "Something went wrong, Please try again",
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //logger.e(e);
//       throw Exception("Something wen't wrong");
//     }
//   }

//   Future<Response> getrequests(
//       BuildContext context, Options options, String endpoint) async {
//     final navigator = Navigator.of(context);
//     CoolAlert.show(
//         context: context,
//         type: CoolAlertType.loading,
//         backgroundColor: Colors.white24);
//     try {
//       print(endpoint);
//       final responsex = await Dio().get(
//         endpoint,
//         options: options,
//       );
//       navigator.pop();
//       return responsex;
//     } on SocketException catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: e.message,
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
// //logger.e(e);
//       throw Exception("Not Internet Connection");
//     } on FormatException catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: "Bad response format",
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //    logger.e(e);
//       throw Exception("Bad response format");
//     } on DioError catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: e.response!.data["message"],
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //  logger.e(e);
//       throw Exception(e);
//     } catch (e) {
//       navigator.pop();
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: "Something went wrong, Please try again",
//         desc: '',
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       //logger.e(e);
//       throw Exception("Something wen't wrong");
//     }
//   }
// }
