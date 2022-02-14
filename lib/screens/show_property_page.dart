import 'package:carousel_slider/carousel_slider.dart';
import 'package:dufuna/constants.dart';
import 'package:dufuna/controllers/property_controller.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:dufuna/screens/update_property_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components/custom_widgets.dart';

class ShowProperty extends StatefulWidget {
  final PropertyModel property;

  //Creating the constructor of the class and initializing its fields
  const ShowProperty({Key? key, required this.property}) : super(key: key);

  @override
  State<ShowProperty> createState() => _ShowPropertyState();
}

class _ShowPropertyState extends State<ShowProperty> {
  @override
  Widget build(BuildContext context) {
    //initializing the PropertyController class
    return GetBuilder<PropertyController>(
      init: PropertyController(widget.property.id!),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            //If property has been loaded, display the property name as title
            //otherwise, display Property
            controller.property == null
                ? 'Property'
                : widget.property.description,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (controller.property != null)
                  //if there is a property to update, display the update text widget
                  //and navigate to it
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              UpdateProperty(property: controller.property!)));
                    },
                    child: Text(
                      'Update',
                      style: kStyle.copyWith(
                          fontSize: 12.sp, color: const Color(0xFFCCCCCC)),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.r)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
            child: controller.property == null
                //Display progress indicator while getting the property from the api
                //Otherwise, display the property details
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.property!.images.isNotEmpty)
                        //If there are images to be displayed, display them
                        //using the carouselSlider
                        CarouselSlider.builder(
                          itemCount: controller.property!.images.length,
                          options: CarouselOptions(
                            height: 400.r,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            autoPlay: true,
                          ),
                          itemBuilder: (context, itemIndex, pageIndex) {
                            return ClipRRect(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Image.network(
                                    controller
                                            .property!.images[itemIndex].path ??
                                        ' ',
                                    height: 290.r,
                                    width: double.infinity,
                                    fit: BoxFit.contain),
                              ),
                            );
                          },
                        ),
                      SizedBox(height: 20.r),
                      //Description of property
                      Center(
                        child: Text(
                          controller.property!.description,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: kStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0.sp,
                              height: 24.0 / 17.0.r,
                              letterSpacing: -0.3.sp),
                        ),
                      ),
                      //Address of property
                      Center(
                        child: Text(
                          'Address: \t${controller.property!.address}',
                          textAlign: TextAlign.center,
                          style: kStyle.copyWith(fontSize: 18.r),
                        ),
                      ),
                      SizedBox(height: 20.r),
                      Text(
                        'Details',
                        style: kStyle.copyWith(
                            fontSize: 14.sp,
                            height: 19.12 / 14.0.r,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 10.r),
                      //Other details of the property
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kDarkShade,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Column(
                            children: [
                              propertyDetail(
                                  property: 'Owner',
                                  value: controller.property!.propertyOwner),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Bedrooms',
                                  value:
                                      controller.property!.bedroom.toString()),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Sitting rooms',
                                  value: controller.property!.sittingRoom
                                      .toString()),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Kitchen',
                                  value:
                                      controller.property!.kitchen.toString()),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Bathroom',
                                  value:
                                      controller.property!.bathroom.toString()),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Toilet',
                                  value:
                                      controller.property!.toilet.toString()),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Valid from',
                                  value: controller.property!.validFrom),
                              SizedBox(height: 5.r),
                              propertyDetail(
                                  property: 'Valid to',
                                  value: controller.property!.validTo),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
