import 'package:dufuna/api/image_repo.dart';
import 'package:dufuna/api/property_repo.dart';

class HttpRepos {
  static HttpRepos? _instance;

  HttpRepos._internal() {
    _instance = this;
  }

  factory HttpRepos() => _instance ?? HttpRepos._internal();

  //Getting objects of the Repo classes
  static final PropertyRepo propertyRepo = PropertyRepo();
  static final ImageRepo imageRepo = ImageRepo();
}
