import 'dart:convert';

import 'package:http/http.dart' as http;

Future getCountries() async {
  try {
    var headers = {
      'Accept': 'application/json',
    };
    var request = http.Request('GET',
        Uri.parse('https://wependio.maaheytechnologies.com/api/countries'));

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
