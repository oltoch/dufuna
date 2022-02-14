import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Defining the constants used in the app. It consists mainly colors that are used
//in multiple places as well as the style with custom font used in the app
const Color kBackgroundColor = Color(0xFF171717);
const Color kDarkShade = Color(0xFF00313D);
const Color kDefaultWhite = Color(0xFFFFFFFF);
const Color kRedColor = Color(0xFFE12A2A);
const MaterialColor kPrimaryColor = MaterialColor(
    0xFF00C1F2, <int, Color>{50: Color(0xFF99E6FA), 700: Color(0xFF4cd3f6)});
final kStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
);
