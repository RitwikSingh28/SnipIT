import 'package:snipit/core/constants/app_string.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:snipit/core/helpers/user_helpers.dart';

//import '../../helpers/user_helpers.dart';

class CustomHttpClient {
  http.Client client = http.Client();
  var token = 'Bearer ${UserHelpers.getAuthToken()}';


  Future<http.Response> get(Uri url) async {
    log(token);
    var response = await client.get(url, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: token
    });
    return response;
  }

  Future<http.Response> post(Uri url, var bodyData) async {
    var response = await client.post(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: token
    });

    return response;
  }

  Future<http.Response> delete(Uri url, var bodyData) async {
    var response = await client.delete(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: token
    });
    return response;
  }

  Future<http.Response> put(Uri url, var bodyData) async {
    var token = 'Bearer ${UserHelpers.getAuthToken()}';
    String tokenData = token;
    print(tokenData);
    var response = await client.put(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: token
    });
    return response;
  }
}
