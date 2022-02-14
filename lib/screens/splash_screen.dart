import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dufuna/constants.dart';
import 'package:dufuna/screens/list_property_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Animated Text to display the title name
        child: TextLiquidFill(
          text: 'Lekki\nProperty',
          waveColor: kPrimaryColor,
          loadDuration: const Duration(seconds: 3),
          waveDuration: const Duration(seconds: 1),
          textAlign: TextAlign.center,
          boxBackgroundColor: kBackgroundColor,
          textStyle: GoogleFonts.pacifico(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 60,
                color: kDefaultWhite),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //Uses the timer to execute a function after a set time.
    //After initialization, go to the next page after 6 seconds and remove the
    //current page from the stack.
    _timer = Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ListProperty()),
          (route) => false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
