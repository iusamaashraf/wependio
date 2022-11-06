import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/constants/urls.dart';

Future addGoal({required dynamic goals}) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token")!;
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'api/user/add_goals'));
    request.fields.addAll(goals);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = jsonDecode(await response.stream.bytesToString());
      return result;
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {}
}
