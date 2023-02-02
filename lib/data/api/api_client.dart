import 'package:get/get.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' as Foundation;
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  String? token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = AppConstants.BASE_URL;
    //timeout = const Duration(seconds: 30);
    //token = AppConstants.TOKEN;

    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }



  Future getData(String uri,
      { Map<String, dynamic>? query, String? contentType,
        Map<String, String>? headers, Function(dynamic)? decoder,}) async {
    try {
      http.Response response = await http.get(
        Uri.parse(uri),
        headers: headers??_mainHeaders,

      );

      return response;
    } catch (e) {
      return http.Response(e.toString(), 500);
    }
  }

  Future getData2(
      String uri,
      { Map<String, dynamic>? query, String? contentType,
        Map<String, String>? headers, Function(dynamic)? decoder,}) async {
    try {
      Response response = await get(
          uri,
          contentType: contentType,
          query: query,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', //carrier
        },
        decoder: decoder,
      );
      response = handleResponse(response);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> postData2(String uri, dynamic body) async {
    print(body.toString());
    try{
      Response response = await post(
        uri,
        body,
        headers: _mainHeaders,
      );
      print(response.toString());
      print(uri.toString());
      print(_mainHeaders.toString());
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }

      return response;
    } catch (e) {
      print("not connect");
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future postData(String uri, dynamic body) async {
    print(body.toString());
    try{
      http.Response response = await http.post(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: _mainHeaders,
      );
      print(response.toString());
      print(uri.toString());
      print(_mainHeaders.toString());
      //response = handleResponse(response);
      if(Foundation.kDebugMode) {
        log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }

      return response;
    } catch (e) {
      print("not connect");
      print(e.toString());
      return http.Response(e.toString(), 500);
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: "Error");

      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);

      }
    }else if(_response.hasError && _response.body == null) {
      print("The status code is "+_response.statusCode.toString());
      _response = Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }

}