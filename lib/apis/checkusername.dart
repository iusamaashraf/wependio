import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wependio/constants/urls.dart';

Future checkName({required String usernmae}) async {
  try {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'api/username_exists'));
    request.fields.addAll({'username': usernmae});

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
    return e;
  }
}
