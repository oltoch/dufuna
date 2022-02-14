import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dufuna/models/image_model.dart';

import '../http/http_client.dart';

class ImageRepo {
  //Initializing and creating an object of the HttpClient()
  final HttpClient _http = HttpClient();
  //Initializing and creating an object of the Dio() class from the Dio package
  final Dio dio = Dio();

  ///This function uploads an image to the server. it uses the Dio package to execute
  ///a post request that takes the url and the File data to be uploaded.
  ///It returns a body that contains the details of the image that is uploaded.
  Future<ImageModel> uploadImage(File image) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path, filename: fileName),
    });
    Response response =
        await dio.post(_http.getApiUrl('lekki/upload'), data: formData);
    return ImageModel.fromMap(response.data['data']);
  }
}
