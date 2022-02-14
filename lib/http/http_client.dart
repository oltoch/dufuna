import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'generic_http_response.dart';

class HttpClient {
  static const String _host = 'https://sfc-lekki-property.herokuapp.com';
  static const String _apiVersion = '1';

  ///Function to parse the apiUrl into a Uri as well as append query parameters
  ///to the url if required. It takes as arguments a required path to the endpoint
  ///and an optional Map of query parameters.
  static Uri apiUrl(String path, Map<String, dynamic>? queryParams) {
    String uriString = '$_host/api/v$_apiVersion/$path';

    return Uri.parse(uriString).replace(queryParameters: queryParams);
  }

  // Uri getUri(String path, Map<String, dynamic>? queryParams) {
  //   final Uri uri = Uri.https('sfc-lekki-property.herokuapp.com',
  //       '/api/v$_apiVersion/$path', queryParams);
  //   return uri;
  // }

  ///This function returns the apiUrl as a string. It takes a string path as
  ///an argument.
  String getApiUrl(String path) {
    return '$_host/api/v$_apiVersion/$path';
  }

  ///Function to execute HttpRequest.
  ///It takes enum request type (GET, POST, PATCH, etc.), String path to the
  ///endpoint and optional parameters Map queryParams and dynamic body.
  ///It makes the httpRequest and return response from the request as
  ///GenericHttpResponse.
  Future<GenericHttpResponse> _executeHttpRequest(
    HttpRequestType httpRequestType,
    String path,
    Map<String, dynamic>? queryParams, {
    dynamic body,
  }) async {
    http.Response httpResponse;
    GenericHttpResponse response = GenericHttpResponse();
    try {
      switch (httpRequestType) {
        //For Get request
        case HttpRequestType.get:
          httpResponse = await http.get(
            apiUrl(path, queryParams),
          );
          break;
        //For post request
        case HttpRequestType.post:
          httpResponse = await http.post(
            apiUrl(path, queryParams),
            body: body,
            headers: {
              'Accept': 'application/json',
              'content-type': 'application/json',
            },
          );
          break;
        //For patch request
        case HttpRequestType.patch:
          httpResponse = await http.patch(
            apiUrl(path, queryParams),
            body: body,
            headers: {
              'Accept': 'application/json',
              'content-type': 'application/json',
            },
          );
          break;
        //For delete request
        case HttpRequestType.delete:
          httpResponse = await http.delete(apiUrl(path, queryParams));
          break;
        //Case default, perform get request
        default:
          httpResponse = await http.get(
            apiUrl(path, queryParams),
          );
          break;
      }
      //Request was a success
      response.success = true;
      response.body = jsonDecode(httpResponse.body);
      response.status = httpResponse.statusCode;

      return response;
    } on SocketException {
      //When internet connection failed
      response.message = 'Internet connection failed';
      response.success = false;
      return response;
    } on FormatException {
      //When request has a bad format
      response.message = 'Bad format';
      response.status = 400;
      response.success = false;
      return response;
    } catch (e) {
      //Catch any error that occurs and print it to console for debugging purpose
      debugPrint(e.toString());
      response.success = false;
      return response;
    }
  }

  //Make a get request
  Future<GenericHttpResponse> getRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return await _executeHttpRequest(HttpRequestType.get, path, queryParams);
  }

  //Make a post request
  Future<GenericHttpResponse> postRequest(String path,
      {Map<String, dynamic>? queryParams, dynamic body}) async {
    return await _executeHttpRequest(HttpRequestType.post, path, queryParams,
        body: body);
  }

  //Make a patch request
  Future<GenericHttpResponse> patchRequest(String path,
      {Map<String, dynamic>? queryParams, dynamic body}) async {
    return await _executeHttpRequest(HttpRequestType.patch, path, queryParams,
        body: body);
  }

  //Make a delete request
  Future<GenericHttpResponse> deleteRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return await _executeHttpRequest(HttpRequestType.delete, path, queryParams);
  }
}

//enum for type of request to be performed
enum HttpRequestType {
  get,
  post,
  patch,
  delete,
}
