import 'dart:io';

import 'package:dufuna/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

///A function to select images from the gallery of the device. It uses the
///image_picker package. It is a Future function that returns a list of files when
///user selects one or more images. It returns null when no image is selected.
Future<List<File>?> pickImages() async {
  List<File>? file;
  try {
    final images = await ImagePicker().pickMultiImage();
    if (images != null) {
      file = [];
      for (XFile i in images) {
        //Converting XFile that is returned by image_picker to File that is to be used
        file.add(File(i.path));
      }
    }
  } on PlatformException catch (e) {
    debugPrint(e.message);
    Get.snackbar(
        'Error', 'You need to provide permission to use camera and gallery',
        colorText: kRedColor);
  }
  return file;
}
