import 'package:dufuna/constants.dart';
import 'package:dufuna/models/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom TextFormField to accept user input
class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyBoardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const InputWidget(
      {Key? key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.validator,
      this.keyBoardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      child: TextFormField(
        autocorrect: false,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: keyBoardType,
        controller: controller,
        style: kStyle,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 19.0),
            hintText: hintText,
            hintStyle: kStyle.copyWith(
                fontWeight: FontWeight.w200,
                fontSize: 12.0.sp,
                height: 19.12 / 14.0.r,
                color: const Color(0xFF999999)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(10.0))),
        onChanged: (String value) => onChanged?.call(value),
        validator: (value) => validator?.call(value),
      ),
    );
  }
}

///A custom DropDownMenuWidget. It has three required parameters - itemList(A list
///of items to display of type String), initialValue(A string which holds the selected
///value) and a Function(String?) onChanged that sets the new value when it changes.
class DropDownMenuWidget extends StatefulWidget {
  final List<String> itemList;
  final String? initialValue;
  final Function(String?) onChanged;
  final Widget? hint;
  const DropDownMenuWidget(
      {Key? key,
      required this.itemList,
      required this.initialValue,
      required this.onChanged,
      this.hint})
      : super(key: key);

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultWhite, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 8.r),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: widget.initialValue,
            icon: Image.asset(
              'images/down_arrow.png',
              width: 20.r,
              height: 20.r,
            ),
            menuMaxHeight: MediaQuery.of(context).size.height / 2.r,
            isDense: true,
            hint: widget.hint,
            isExpanded: true,
            style: kStyle.copyWith(fontSize: 16.sp),
            onChanged: widget.onChanged,
            items:
                widget.itemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

///A custom widget with a predefined theme. It sets the theme
///for the child widget that is passed into it.
Widget dateTextWidget(
    {required BuildContext context,
    required String text,
    required Widget child}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: kStyle.copyWith(
          fontWeight: FontWeight.w200,
          fontSize: 16.0.sp,
          height: 21 / 16.0.r,
        ),
      ),
      Theme(
        data: Theme.of(context).copyWith(
          primaryColor: kPrimaryColor,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith((states) =>
                      kStyle.copyWith(color: kPrimaryColor, fontSize: 16.sp)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (state) => kBackgroundColor))),
        ),
        child: Builder(builder: (context) {
          return child;
        }),
      ),
    ],
  );
}

///A custom input widget
Widget searchField(
    {Function(String)? onChanged,
    TextEditingController? controller,
    bool hasIcon = true,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    required String hint}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    showCursor: true,
    cursorColor: kPrimaryColor,
    style: TextStyle(
        color: const Color(0xffcccccc),
        fontSize: 18.sp,
        height: 22 / 18.r,
        letterSpacing: -0.041.sp),
    textCapitalization: TextCapitalization.sentences,
    keyboardType: keyboardType ?? TextInputType.text,
    decoration: InputDecoration(
      constraints: BoxConstraints(maxHeight: 40.r),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: 0, horizontal: hasIcon ? 0 : 12),
      filled: true,
      fillColor: const Color(0xff001014),
      prefixIcon: hasIcon
          ? Image.asset('images/search.png', color: kDefaultWhite)
          : null,
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: TextStyle(
          color: const Color(0xffcccccc),
          fontSize: 14.sp,
          letterSpacing: -0.041.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: kDarkShade, width: 0.5.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: kDarkShade, width: 0.5.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: kDarkShade, width: 0.5.r),
      ),
    ),
  );
}

///A custom placeholder for images
Widget addImagesWidget() {
  return Column(
    children: [
      Center(
        child: Container(
          height: 170,
          width: 239,
          decoration: BoxDecoration(
            color: kDarkShade,
            border: Border.all(
              color: kPrimaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/gallery_icon.png',
                  width: 82,
                  height: 65,
                ),
                SizedBox(height: 18.r),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  child: Text(
                    'Add Images/Videos',
                    style: kStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      height: 18 / 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10.r),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/info_icon.png',
            width: 16,
            height: 16,
          ),
          SizedBox(width: 18.r),
          Container(
            width: 200,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(
              child: Text(
                'Select one or more images from you device to add to this property.'
                'Select only jpeg, png or jpg format',
                softWrap: true,
                maxLines: 4,
                style: kStyle.copyWith(
                  fontSize: 9.0,
                  height: 15 / 9.0,
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

///A circular progress loading indicator to show when a process is ongoing.
///To be shown as a dialog.
///Example: showDialog(
///         context: context, builder: (context) => loading());
///Pop the dialog by setting routeNavigator to true in Navigator.pop()
Widget loading() {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      height: 100.r,
      width: 50.r,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
    ),
  );
}

///A custom widget to display a property in a listView.
///It takes BuildContext and the Property model to display.
///The first image in the list of images of the property is displayed on the
///card, if there's no image in the list, it simply renders blank to the screen
Widget buildCard(BuildContext context, PropertyModel property) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.r),
    height: 230,
    width: MediaQuery.of(context).size.width - 60.r,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
                image: NetworkImage(property.images.isNotEmpty
                    ? property.images[0].path ?? ' '
                    : ' '),
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 12.r),
                decoration: const BoxDecoration(color: Color(0x99000000)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.r,
                            child: Text(
                              property.description,
                              overflow: TextOverflow.ellipsis,
                              style: kStyle.copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 20.49 / 15.0.r,
                                  letterSpacing: -0.03.sp),
                            ),
                          ),
                          Text(
                            property.address,
                            overflow: TextOverflow.ellipsis,
                            style: kStyle.copyWith(
                                fontSize: 11.sp,
                                height: 15.03 / 11.0.r,
                                color: const Color(0xFFF1F1F1),
                                letterSpacing: -0.03.sp),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property.type,
                            style: kStyle.copyWith(
                                fontSize: 13.sp,
                                color: const Color(0xFFF1F1F1),
                                height: 17.76 / 13.0.r,
                                letterSpacing: -0.03.sp),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0.r, vertical: 8.0.r),
                              child: Text(
                                'View',
                                style: kStyle.copyWith(
                                    fontSize: 11.sp,
                                    height: 15.03 / 11.0.r,
                                    letterSpacing: -0.03.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

///Custom widget to display property's field and its value
Widget propertyDetail({required String property, required String value}) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          property,
          softWrap: true,
          style: kStyle.copyWith(
              fontSize: 14.sp,
              height: 19.12 / 14.0.r,
              fontWeight: FontWeight.w300),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          value,
          softWrap: true,
          style: kStyle.copyWith(
            fontSize: 14.sp,
            height: 19.12 / 14.0.r,
          ),
        ),
      ),
    ],
  );
}
