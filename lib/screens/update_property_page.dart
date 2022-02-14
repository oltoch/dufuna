import 'package:dufuna/components/custom_widgets.dart';
import 'package:dufuna/constants.dart';
import 'package:dufuna/controllers/property_controller.dart';
import 'package:dufuna/http/http_repos.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateProperty extends StatefulWidget {
  final PropertyModel property;

  //Creating the constructor of the class and initializing its fields
  const UpdateProperty({Key? key, required this.property}) : super(key: key);

  @override
  _UpdatePropertyState createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends State<UpdateProperty> {
  //Defining the controllers for the TextFields
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
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r),
          child: Form(
            child: Column(
              children: [
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
                  style: kStyle,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.r),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color(0xffFFFFFF)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color(0xffFFFFFF)),
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
                      //Open the date picker dialog. User can select a date from
                      //current date to a year after.
                      showDatePicker(
                              context: context,
                              initialDate: _endDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1))
                          .then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _endDate = pickedDate;
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
                        _endDate == null
                            //if date is selected, display selected date in its
                            //formatted form
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
                    //Call updateProperty function to update the property in the collection
                    updateProperty();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Update',
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

  @override
  void initState() {
    super.initState();
    //When the state is initialized,
    //Set the value of the input fields to the value of the property to be updated
    _numberOfBedroomController.text = widget.property.bedroom.toString();
    _numberOfSittingRoomController.text =
        widget.property.sittingRoom.toString();
    _numberOfToiletController.text = widget.property.toilet.toString();
    _numberOfKitchenController.text = widget.property.kitchen.toString();
    _numberOfBathroomController.text = widget.property.bathroom.toString();
    String date = widget.property.validTo;
    int year = int.parse(date.split('-')[0]);
    int month = int.parse(date.split('-')[1]);
    int day = int.parse(date.split('-')[2]);
    _endDate = DateTime(year, month, day);
    _descriptionController.text = widget.property.description;
  }

  ///Validate that the input fields are not empty. If any of the field is empty
  ///or valid to not set, returns false, otherwise, return true.
  bool validate() {
    if (_numberOfToiletController.text.isEmpty ||
        _numberOfBathroomController.text.isEmpty ||
        _numberOfKitchenController.text.isEmpty ||
        _numberOfSittingRoomController.text.isEmpty ||
        _numberOfBedroomController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required', colorText: kRedColor);
      return false;
    }
    if (_endDate == null) {
      Get.snackbar('Error', 'You need set the valid from and valid to',
          colorText: kRedColor);
      return false;
    }
    return true;
  }

  ///This makes an http request to update the value of the property. If updated
  ///successfully, it navigates the user back to the page that displays the details,
  ///otherwise, it returns an error. It has a return type of void.
  void updateProperty() async {
    //Show circular progress indicator to show that a process is ongoing
    showDialog(
        context: context, builder: (_) => loading(), barrierDismissible: false);
    //Make http request to update the property with the filled in data
    await HttpRepos.propertyRepo
        .updateProperty(
            id: widget.property.id!,
            description: _descriptionController.text,
            bedroom: int.parse(_numberOfBedroomController.text),
            sittingRoom: int.parse(_numberOfSittingRoomController.text),
            bathroom: int.parse(_numberOfBathroomController.text),
            kitchen: int.parse(_numberOfKitchenController.text),
            toilet: int.parse(_numberOfToiletController.text),
            validTo: _endDate!.toUtc().toString().split(' ')[0])
        .then((value) {
      //This is called to pop the loading circular indicator off the screen
      Navigator.of(context, rootNavigator: true).pop();
      if (value.success) {
        //Property updated successfully, Exit the page
        Get.snackbar('Success!', 'Property updated successfully.',
            colorText: kPrimaryColor);
        Navigator.of(context).pop();
      } else {
        //Property not updated due to an error. Remain on page so user can try again
        Get.snackbar('Error!', 'An error occurred, please try again.',
            colorText: kRedColor);
      }
    });
  }

  @override
  void dispose() {
    //After updating the property and page is closed, make an http request to
    // update the controller that shows the property details.
    PropertyController propertyController =
        Get.put(PropertyController(widget.property.id!));
    propertyController.getProperty(widget.property.id!);
    super.dispose();
  }
}
