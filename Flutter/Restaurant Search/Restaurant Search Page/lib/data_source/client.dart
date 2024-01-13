import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';

class ApiClient {
  Client _client = Client();

  dynamic post(
    String path, {
    Map<dynamic, dynamic>? bodyParams,
  }) async {
    final response = await _client.post(
      Uri.parse("${ApiConstants.apiUrl}${path}"),
      body: jsonEncode(bodyParams),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //for success

      print(
          "post response is ${response.statusCode} here is reponse ${response}");
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      //unauthorized access

      print("unauthorized accesss");
      throw Exception("Unauthorized Access exception");
    } else {
      //uncategorized

      print(
          "something went wrong while making post request. reponse phrase:${response.reasonPhrase}");
      throw Exception(response.body);
    }
  }
}
