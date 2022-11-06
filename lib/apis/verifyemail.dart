import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/constants/urls.dart';

Future verifyUser({required String code}) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token")!;
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + 'api/verify_email'));
    request.fields.addAll({'code': code});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = jsonDecode(await response.stream.bytesToString());
      return result;
    } else {
      var result = jsonDecode(await response.stream.bytesToString());
      return result;
    }
  } catch (e) {}
}
