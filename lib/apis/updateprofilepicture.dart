import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/constants/urls.dart';

Future updatePicture({required String image}) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token")!;
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'api/profile_picture'));
    request.files
        .add(await http.MultipartFile.fromPath('profile_picture', image));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = jsonDecode(await response.stream.bytesToString());

      return result;
    } else {
      var result = jsonDecode(await response.stream.bytesToString());
      return result;
    }
  } catch (e) {
    debugPrint(
        "waleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddddddddddd  ${e.toString()}");
  }
}
