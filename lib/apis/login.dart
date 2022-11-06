import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wependio/constants/urls.dart';

Future loginUser({required String email, required String password}) async {
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + 'api/login'));
    request.fields.addAll({'email': email, 'password': password});

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
