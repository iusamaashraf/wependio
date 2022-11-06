import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wependio/constants/urls.dart';

Future signUp(
    {required String name,
    required String email,
    required String password,
    required String cpass,
    required String username,
    required String dob,
    required String country,
    required String zip,
    required String address,
    required String gender}) async {
  try {
    var headers = {'Accept': 'application/json'};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + 'api/sign_up'));
    request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': cpass,
      'username': username,
      'dob': dob,
      'country_id': country,
      'zip_code': zip,
      'residential_address': address,
      'gender': gender
    });

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
