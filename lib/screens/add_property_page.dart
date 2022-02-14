import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dufuna/controllers/property_controller.dart';
import 'package:dufuna/helpers.dart';
import 'package:dufuna/http/http_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components/custom_widgets.dart';
import '../constants.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  //Defining the controllers for the TextFields and variables for the Property
  //type, image(s) and Date selectors
  final TextEditingController _propertyAddressController =
      TextEditingController();
  final TextEditingController _numberOfBedroomController =
      TextEditingController();
  final TextEditingController _numberOfSittingRoomController =
      TextEditingController();
  final TextEditingController _numberOfKitchenController =
      TextEditingController();
  final TextEditingController _numberOfToiletController =
      TextEditingController();
  final TextEditingController _numberOfBathroomController =
      TextEditingController();
  final TextEditingController _propertyOwnerController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _propertyType;
  //This list is populated with the assumption that the below are the property
  //types.
  final List<String> _propertyTypeList = [
    'House',
    'Flat',
    'Bungalow',
    'Duplex',
    'Terrace'
  ];
  DateTime? _startDate;
  DateTime? _endDate;

  List<File>? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.r),
                //Property Images
                InkWell(
                  onTap: () async {
                    //Pick images from the gallery. If user pick some images then
                    //set them to the images variable, otherwise do nothing
                    await pickImages().then((value) {
                      if (value != null) {
                        setState(() {
                          images = value;
                        });
                      }
                    });
                  },
                  //If list of images is still null i.e. no image is selected yet
                  //display a widget to prompt user to select images otherwise,
                  //display the selected images in a carousel slider.
                  child: images == null
                      ? addImagesWidget()
                      : CarouselSlider.builder(
                          itemCount: images!.length,
                          options: CarouselOptions(
                            height: 300.r,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            autoPlay: true,
                          ),
                          itemBuilder: (context, itemIndex, pageIndex) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Image.file(images![itemIndex],
                                  height: 290.r,
                                  width: 240.r,
                                  fit: BoxFit.contain),
                            );
                          }),
                ),
                SizedBox(height: 15.r),
                //Property Address
                Text(
                  'Property address',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  hintText: 'Enter property address',
                  controller: _propertyAddressController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Property address field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Property Type
                Text(
                  'Property Type',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                //Dropdown menu to select a property type
                DropDownMenuWidget(
                  onChanged: (newValue) {
                    setState(() {
                      _propertyType = newValue;
                    });
                  },
                  itemList: _propertyTypeList,
                  initialValue: _propertyType,
                  hint: Text(
                    'Select property type',
                    style: kStyle.copyWith(
                        fontSize: 12.sp,
                        height: 19.12 / 14.0.r,
                        color: const Color(0xFF999999)),
                  ),
                ),
                SizedBox(height: 20.r),
                //Number of bedroom
                Text(
                  'Number of bedroom',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  keyBoardType: TextInputType.number,
                  hintText: 'Enter number of bedroom',
                  controller: _numberOfBedroomController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Number of bedroom field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Number of sitting room
                Text(
                  'Number of sitting room',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  keyBoardType: TextInputType.number,
                  hintText: 'Enter number of sitting room',
                  controller: _numberOfSittingRoomController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Number of sitting room field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Number of kitchen
                Text(
                  'Number of kitchen',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  keyBoardType: TextInputType.number,
                  hintText: 'Enter number of kitchen',
                  controller: _numberOfKitchenController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Number of kitchen field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Number of bathroom
                Text(
                  'Number of bathroom',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  keyBoardType: TextInputType.number,
                  hintText: 'Enter number of bathroom',
                  controller: _numberOfBathroomController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Number of bathroom field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Number of toilet
                Text(
                  'Number of toilet',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  keyBoardType: TextInputType.number,
                  hintText: 'Enter number of toilet',
                  controller: _numberOfToiletController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'toilet field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Property Owner
                Text(
                  'Property owner',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                InputWidget(
                  hintText: 'Enter name of owner',
                  controller: _propertyOwnerController,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Name of owner field cannot be empty'
                      : null,
                ),
                SizedBox(height: 20.r),
                //Description
                Text(
                  'Description',
                  style: kStyle.copyWith(
                    fontSize: 12.0.sp,
                    height: 16 / 12.0.r,
                  ),
                ),
                SizedBox(height: 6.r),
                TextFormField(
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Property description must not be empty'
                      : null,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  style: kStyle,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.r),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color(0xffFFFFFF)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color(0xffFFFFFF)),
                    ),
                  ),
                ),
                SizedBox(height: 20.r),
                //Valid from
                dateTextWidget(
                  context: context,
                  text: 'Valid from:',
                  child: InkWell(
                    onTap: () {
                      DateTime now = DateTime.now();
                      //Open the date picker dialog. User can select a date from
                      //current date to a year after.
                      showDatePicker(
                              context: context,
                              initialDate: _startDate ?? now,
                              firstDate: now,
                              lastDate: DateTime(now.year + 1))
                          .then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _startDate = pickedDate;
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: kDarkShade,
                      ),
                      child: Text(
                        //if date is selected, display selected date in its
                        //formatted form
                        _startDate == null
                            ? '_ _'
                            : _startDate.toString().split(' ')[0],
                        style: kStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0.sp,
                          height: 21 / 16.0.r,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.r),
                //Valid to
                dateTextWidget(
                  context: context,
                  text: 'Valid to:',
                  child: InkWell(
                    onTap: () {
                      //If valid from has not been set, show snackBar and prompt
                      //user to select a valid from date first
                      if (_startDate == null) {
                        Get.snackbar(
                            'Error', 'Please choose Valid from date first',
                            colorText: kRedColor,
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        //otherwise, open date picker dialog to select valid to date
                        //User can select from "valid from" and one year after that
                        showDatePicker(
                                context: context,
                                initialDate: _endDate ?? _startDate!,
                                firstDate: _startDate!,
                                lastDate: DateTime(_startDate!.year + 1))
                            .then((pickedDate) {
                          if (pickedDate != null) {
                            setState(() {
                              _endDate = pickedDate;
                            });
                          }
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: kDarkShade,
                      ),
                      child: Text(
                        //if date is selected, display selected date in its
                        //formatted form
                        _endDate == null
                            ? '_ _'
                            : _endDate.toString().split(' ')[0],
                        style: kStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0.sp,
                          height: 21 / 16.0.r,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.r),
                TextButton(
                  onPressed: () {
                    //If any of the field is not validated, return and show a snackBar
                    //telling the user to fill all data appropriately
                    if (!validate()) {
                      return;
                    }
                    //call addProperty function to add the property the collection
                    addProperty();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: kStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.r, horizontal: 20.r),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
                SizedBox(height: 40.r),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Validate that the input fields are not empty. If any of the field is empty,
  ///no image is selected or dates not set, returns false, otherwise, return true.
  bool validate() {
    //No image has been selected. return false and show a snackBar
    if (images == null) {
      Get.snackbar('Error', 'You need to add pictures', colorText: kRedColor);
      return false;
    }

    if (_propertyOwnerController.text.isEmpty ||
        _propertyAddressController.text.isEmpty ||
        _numberOfToiletController.text.isEmpty ||
        _numberOfBathroomController.text.isEmpty ||
        _numberOfKitchenController.text.isEmpty ||
        _numberOfSittingRoomController.text.isEmpty ||
        _numberOfBedroomController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required', colorText: kRedColor);
      return false;
    }
    if (_propertyType == null) {
      Get.snackbar('Error', 'You need to select property type',
          colorText: kRedColor);
      return false;
    }
    if (_startDate == null || _endDate == null) {
      Get.snackbar('Error', 'You need set the valid from and valid to',
          colorText: kRedColor);
      return false;
    }
    return true;
  }

  ///This makes an http request to add the new property to the collection. If added
  ///successfully, it navigates the user back to the page that displays the list of
  ///properties and adds the new property to the list. Otherwise, it returns an
  ///error. It has a return type of void.
  void addProperty() async {
    //Show circular progress indicator to show that a process is ongoing
    showDialog(
        context: context, builder: (_) => loading(), barrierDismissible: false);

    //Iterate through the images that the user selected and upload them one after
    //the other. Put the response from the http request in to a list of map by
    //mapping the response using the toMap factory of the imageModel. so the image
    //can be added with the property.
    List<Map<String, dynamic>> imageResponses = [];
    for (File i in images!) {
      await HttpRepos.imageRepo.uploadImage(i).then((value) {
        imageResponses.add(value.toMap());
      });
    }
    debugPrint('Images uploaded successfully');
    //Add all fields to a Map to be sent as body of the http request
    Map<String, dynamic> payload = {
      "address": _propertyAddressController.text,
      "type": _propertyType!,
      "bedroom": int.parse(_numberOfBedroomController.text),
      "sittingRoom": int.parse(_numberOfSittingRoomController.text),
      "kitchen": int.parse(_numberOfKitchenController.text),
      "bathroom": int.parse(_numberOfBathroomController.text),
      "toilet": int.parse(_numberOfToiletController.text),
      "propertyOwner": _propertyOwnerController.text,
      "description": _descriptionController.text,
      "validFrom": _startDate!.toUtc().toString().split(' ')[0],
      "validTo": _endDate!.toUtc().toString().split(' ')[0],
      'images': imageResponses
    };

    //Make http request to add the property in to the collection
    await HttpRepos.propertyRepo.addProperty(payload).then((value) {
      //This is called to pop the loading circular indicator of the screen
      Navigator.of(context, rootNavigator: true).pop();
      if (value.status == 201) {
        //Property added successfully, Exit the page
        Get.snackbar('Success!', 'Property created successfully.',
            colorText: kPrimaryColor);
        Navigator.of(context).pop();
      } else {
        //Property not added due to an error. Remain on page so user can try again
        Get.snackbar('Error!', 'An error occurred, please try again.',
            colorText: kRedColor);
      }
    });
  }

  @override
  void dispose() {
    //After adding the property and page is closed, make an http request to
    //update the controller that shows the list of properties.
    PropertiesController propertyController = Get.put(PropertiesController());
    propertyController.getProperties();
    super.dispose();
  }
}
