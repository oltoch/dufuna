import 'package:dufuna/http/http_repos.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:get/get.dart';

//Controller class for getting list of properties from the api
class PropertiesController extends GetxController {
  List<PropertyModel>? properties;
  List<PropertyModel> list = [];

  //Called after the controller is initialized. It executes the async request
  //of getting data from the api
  @override
  void onReady() {
    super.onReady();
    //Get properties and put in the already defined fields
    HttpRepos.propertyRepo.getProperties().then((value) {
      properties = value;
      list = value;
      update();
    });
  }

  ///This function get all properties in the collection and update the controller.
  Future<void> getProperties() async {
    await HttpRepos.propertyRepo.getProperties().then((value) {
      properties = value;
      list = value;
      update();
    });
  }

  ///This function get properties in the collection based on query parameters
  ///and then update the controller.
  Future<void> filterProperties(Map<String, dynamic> queryParams) async {
    await HttpRepos.propertyRepo
        .getFilteredProperties(queryParams: queryParams)
        .then((value) {
      properties = value;
      list = value;
      update();
    });
  }

  ///This function goes through the list of properties and check for properties
  ///that have their address match the parameter passed to it. It updates the controller.
  void findByAddress(String val) {
    List<PropertyModel> list = [];
    if (val.isEmpty) {
      properties = this.list;
      update();
      return;
    }
    if (properties != null && properties!.isNotEmpty) {
      for (PropertyModel i in properties!) {
        if (i.address.contains(val)) {
          list.add(i);
        }
      }
    }
    properties = list;
    update();
  }
}

//Controller class for getting a property from the api
class PropertyController extends GetxController {
  final String id;
  PropertyController(this.id);
  PropertyModel? property;
  @override
  //Called after the controller is initialized. It executes the async request
  //of getting data from the api
  void onReady() {
    super.onReady();
    //Get the property whose ID was passed in the constructor of the controller
    HttpRepos.propertyRepo.getPropertyById(id).then((value) {
      property = value;
      update();
    });
  }

  ///This function get the property whose ID was passed in from the collection
  ///and update the controller.
  Future<void> getProperty(String id) async {
    await HttpRepos.propertyRepo.getPropertyById(id).then((value) {
      property = value;
      update();
    });
  }
}
