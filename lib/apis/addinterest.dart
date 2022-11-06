import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wependio/constants/urls.dart';

Future addInterest({required List data}) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token")!;
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'api/user/add_interests'));
    data.forEach((element) {
      request.fields.addAll(element);
    });

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
