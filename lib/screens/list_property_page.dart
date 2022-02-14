import 'package:dufuna/components/custom_widgets.dart';
import 'package:dufuna/constants.dart';
import 'package:dufuna/controllers/property_controller.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:dufuna/screens/add_property_page.dart';
import 'package:dufuna/screens/show_property_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListProperty extends StatefulWidget {
  const ListProperty({Key? key}) : super(key: key);

  @override
  State<ListProperty> createState() => _ListPropertyState();
}

class _ListPropertyState extends State<ListProperty> {
  //A Map to track whether to display a particular filter field or not. Uses
  //int to track which field is selected
  Map<int, bool> filterVisibility = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false
  };
  //A map to hold the query parameter entered by the user.
  Map<String, dynamic> query = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Lekki Properties'),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: [
              //Go to add property page
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddProperty()));
                },
                child: Text(
                  'Add new',
                  style: kStyle.copyWith(
                      fontSize: 12.sp, color: const Color(0xFFCCCCCC)),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.r)
        ],
      ),
      //initializing the PropertiesController class
      body: GetBuilder<PropertiesController>(
        init: PropertiesController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 10.r),
          child: controller.properties == null
              //If properties is null i.e. the http request to get properties is not
              //completed, show a circular progress indicator
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : controller.properties!.isEmpty
                  //If properties is empty, display a text widget to inform user there that
                  //there is no property yet
                  ? Center(
                      child: Text(
                        'No Properties',
                        style: kStyle.copyWith(fontSize: 24.sp),
                      ),
                    )
                  //A pull down to refresh widget to reload the properties
                  : RefreshIndicator(
                      color: kPrimaryColor,
                      onRefresh: () {
                        //After one second, make the http request to refresh the list
                        return Future.delayed(const Duration(seconds: 1), () {
                          if (query.isNotEmpty) {
                            controller.filterProperties(query);
                            return;
                          }
                          controller.getProperties();
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Widget to find by address
                          searchField(
                              hint: 'Find by address',
                              onChanged: (newValue) {
                                //When user inputs a new character, check the list
                                //and return the properties whose address contain the
                                //user input
                                controller.findByAddress(newValue);
                              }),
                          SizedBox(height: 10.r),
                          //Button to display the list of filter options available
                          PopupMenuButton<int>(
                            //When an option is selected, call the onFilterSelected
                            //function by passing the item (int)
                            //to enable the option selected
                            onSelected: (item) => onFilterItemSelected(item),
                            color: kDarkShade,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Image.asset('images/filter.png',
                                color: kPrimaryColor,
                                width: 120.r,
                                height: 50.r),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Text(
                                  'Bedrooms',
                                  style: kStyle,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text(
                                  'Sitting rooms',
                                  style: kStyle,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: Text(
                                  'Kitchens',
                                  style: kStyle,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 3,
                                child: Text(
                                  'Toilets',
                                  style: kStyle,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 4,
                                child: Text(
                                  'Bathrooms',
                                  style: kStyle,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 5,
                                child: Text(
                                  'Property Owner',
                                  style: kStyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.r),
                          //When an option is selected, visible is set to true and
                          //the option is displayed to the user.
                          //When the user enters a value, it assigns the value to
                          //the index associated with the option in the query Map. When
                          //user clears the input or close the option, the value is
                          //removed from the query Map. When user closes the option,
                          //the query is removed from the query parameter.
                          Column(
                            children: [
                              Visibility(
                                  visible: filterVisibility[0]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[0]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['bedroom'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('bedroom');
                                      });
                                    }
                                  },
                                  hint: 'Number of Bedrooms',
                                  hasIcon: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[0] = false;
                                        query.remove('bedroom');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: filterVisibility[1]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[1]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['sittingRoom'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('sittingRoom');
                                      });
                                    }
                                  },
                                  hint: 'Number of Sitting Rooms',
                                  hasIcon: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[1] = false;
                                        query.remove('sittingRoom');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: filterVisibility[2]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[2]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['kitchen'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('kitchen');
                                      });
                                    }
                                  },
                                  hint: 'Number of Kitchens',
                                  hasIcon: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[2] = false;
                                        query.remove('kitchen');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: filterVisibility[3]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[3]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['toilet'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('toilet');
                                      });
                                    }
                                  },
                                  hint: 'Number of Toilets',
                                  hasIcon: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[3] = false;
                                        query.remove('toilet');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: filterVisibility[4]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[4]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['bathroom'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('bathroom');
                                      });
                                    }
                                  },
                                  hint: 'Number of Bathrooms',
                                  hasIcon: false,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[4] = false;
                                        query.remove('bathroom');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: filterVisibility[5]!,
                                  child: SizedBox(height: 5.r)),
                              Visibility(
                                visible: filterVisibility[5]!,
                                child: searchField(
                                  onChanged: (newValue) {
                                    if (newValue.isNotEmpty) {
                                      setState(() {
                                        query['propertyOwner'] = newValue;
                                      });
                                    } else {
                                      setState(() {
                                        query.remove('propertyOwner');
                                      });
                                    }
                                  },
                                  hint: 'Property Owner',
                                  hasIcon: false,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        filterVisibility[5] = false;
                                        query.remove('propertyOwner');
                                      });
                                    },
                                    child: const Icon(Icons.clear,
                                        color: kDefaultWhite),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (query.isNotEmpty)
                            //When user enters at least one query parameter,
                            //show the filter button and filter the properties
                            //based on the query parameters
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  controller.filterProperties(query);
                                },
                                child: Text(
                                  'filter',
                                  style: kStyle,
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: kPrimaryColor),
                              ),
                            ),
                          SizedBox(height: 20.r),
                          //Display the properties in a list view
                          Expanded(
                            child: ListView.builder(
                              //Setting the pageStorageKey to keep scroll state
                              //when user navigates away
                              key: const PageStorageKey<String>('list_page'),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: controller.properties!.length,
                              itemBuilder: (context, index) {
                                PropertyModel property =
                                    controller.properties![index];
                                return InkWell(
                                    onTap: () {
                                      //Show the details of the property selected
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowProperty(
                                                      property: property)));
                                    },
                                    //Call buildCard to display the property in a list
                                    child: buildCard(context, property));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  ///A function to select a filter item. It takes as argument which is an int of
  ///the filter item selected. When an item is selected, it sets the visibility
  ///of the item to true.
  void onFilterItemSelected(int item) {
    switch (item) {
      case 0:
        setState(() {
          filterVisibility[0] = true;
        });
        break;
      case 1:
        setState(() {
          filterVisibility[1] = true;
        });
        break;
      case 2:
        setState(() {
          filterVisibility[2] = true;
        });
        break;
      case 3:
        setState(() {
          filterVisibility[3] = true;
        });
        break;
      case 4:
        setState(() {
          filterVisibility[4] = true;
        });
        break;
      default:
        setState(() {
          filterVisibility[5] = true;
        });
        break;
    }
  }
}
