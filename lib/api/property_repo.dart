import 'dart:convert';

import 'package:dufuna/http/generic_http_response.dart';
import 'package:dufuna/http/http_client.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:flutter/material.dart';

class PropertyRepo {
  //Initializing and creating an object of the HttpClient()
  final HttpClient _http = HttpClient();

  ///Get all properties present in the database. This function executes a get
  ///http request and returns a list of properties that are present from the api
  Future<List<PropertyModel>> getProperties() async {
    final response = await _http.getRequest('lekki/property');
    return (response.body['data'] as List)
        .map((property) => PropertyModel.fromMap(property))
        .toList()
        .cast<PropertyModel>();
  }

  ///Filters properties present in the database based on the given query parameters.
  ///This function executes a get http request and returns a list of properties
  ///that satisfy the query and that are present from the api.
  Future<List<PropertyModel>> getFilteredProperties(
      {required Map<String, dynamic> queryParams}) async {
    final response =
        await _http.getRequest('lekki/property', queryParams: queryParams);
    return (response.body['data'] as List)
        .map((property) => PropertyModel.fromMap(property))
        .toList()
        .cast<PropertyModel>();
  }

  ///Get a particular property by its ID from the database. This function executes a get
  ///http request and returns a property whose ID is passed and that is present from the api
  Future<PropertyModel> getPropertyById(String id) async {
    final response = await _http.getRequest('lekki/property/$id');
    debugPrint(response.body['data'].toString());
    return PropertyModel.fromMap(response.body['data']);
  }

  ///This function adds a new property to the collection. It takes an argument
  ///payload which is a Map containing details of the property to be added.
  Future<GenericHttpResponse> addProperty(Map<String, dynamic> payload) async {
    final response =
        await _http.postRequest('lekki/property', body: json.encode(payload));
    debugPrint(response.body.toString());
    return response;
  }

  ///This function updates an existing property in the collection. It takes a required
  ///String id of the property and other details that are to be updated. It executes a
  ///patch request to update only certain details.
  Future<GenericHttpResponse> updateProperty(
      {required String id,
      String? description,
      int? bedroom,
      int? sittingRoom,
      int? kitchen,
      int? toilet,
      int? bathroom,
      String? validTo}) async {
    Map<String, dynamic> payload = {};
    if (description != null) payload['description'] = description;
    if (bedroom != null) payload['bedroom'] = bedroom;
    if (sittingRoom != null) payload['sittingRoom'] = sittingRoom;
    if (kitchen != null) payload['kitchen'] = kitchen;
    if (bathroom != null) payload['bathroom'] = bathroom;
    if (toilet != null) payload['toilet'] = toilet;
    if (validTo != null) payload['validTo'] = validTo;
    final response = await _http.patchRequest('lekki/property/$id',
        body: json.encode(payload));
    return response;
  }
}
