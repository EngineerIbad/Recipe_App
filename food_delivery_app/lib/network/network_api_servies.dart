import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/network/api_responses.dart';
import 'package:food_delivery_app/network/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseApiServices {
  Future<dynamic> getCall(
    String url, {
    String token = "",
  });

  Future<dynamic> postCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  });
  Future<dynamic> putCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  });
  Future<dynamic> patchCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  });
  Future<dynamic> deleteCall(
    String url, {
    String token = "",
  });
  Future<Map<String, dynamic>> uploadImage({
    required String url,
    required String key,
    required File file,
    required String token,
    required Map<String, String> headers,
  });
}

class NetworkApiService extends BaseApiServices {
  ApiResponses responseClass = ApiResponses();

  @override
  Future getCall(String url, {String token = ""}) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10), onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future deleteCall(String url, {String token = ""}) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10), onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  }) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: headers ??
                {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
          )
          .timeout(const Duration(seconds: 10), onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    debugPrint(responseJson.toString());
    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> uploadImage({
    required String url,
    required String key,
    required File file,
    required String token,
    required Map<String, String> headers,
  }) async {
    Map<String, dynamic> responseJson = {};
    try {
      // http.MultipartFile multiPort;
      // var request = http.MultipartRequest('POST', Uri.parse(url));
      // var stream = http.ByteStream(file.openRead());
      // stream.cast();
      // var length = await file.length();
      // multiPort = http.MultipartFile(key, stream, length);

      // request.files.add(multiPort);
      // request.headers.addAll(headers);

      // var response = await request.send();
      // var responseBody = await response.stream.bytesToString();
      // dynamic decodedResponse = jsonDecode(responseBody);
      // debugPrint(decodedResponse);
      // responseJson = decodedResponse;

      var stream = http.ByteStream(file.openRead());
      // stream.cast();
      // var stream = http.ByteStream(file.openRead());

      var length = await file.length();

      var uri = Uri.parse(url);

      var request = http.MultipartRequest("POST", uri);
      // var request = http.MultipartRequest('POST', uri)
      //   ..fields['user'] = 'nweiz@google.com'
      //   ..files.add(await http.MultipartFile.fromPath(
      //       'package', 'build/package.tar.gz',
      //       contentType: headers);

      String fileName = file.path.split('/').last;
      List types = fileName.split('.');
      // print(await file.readAsString());

      var multipartFile = http.MultipartFile(
        key,
        stream,
        length,
        filename: fileName,
        contentType: MediaType('image', types.last),
      );

      //add multipart to request
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      debugPrint(responseBody.toString());
      responseJson = jsonDecode(responseBody);
    } on SocketException {
      Response response = await errorResponse();
      responseJson = jsonDecode(response.body);
    }
    return responseJson;
  }

  @override
  Future putCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  }) async {
    dynamic responseJson;
    try {
      var response = await http.put(Uri.parse(url), body: data, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10), onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future patchCall(
    String url,
    dynamic data, {
    String token = "",
    Map<String, String>? headers,
  }) async {
    dynamic responseJson;
    try {
      var response = await http.patch(Uri.parse(url), body: data, headers: {
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 10), onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<Response> errorResponse() async {
    String errorJson = jsonEncode({
      "error": {
        "message": "Internet connection breakdown during communication",
        "internet": true
      }
    });
    return Response(errorJson, 500);
  }
}
