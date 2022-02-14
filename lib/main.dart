import 'package:dufuna/constants.dart';
import 'package:dufuna/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Initializing flutter_screen_util package to ensure better adaptation to
    //screen sizes
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        //returning GetMaterialApp instead of MaterialApp to initialize GetMaterial
        //controller
        debugShowCheckedModeBanner: false,
        title: 'Lekki Properties',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121213),
          ),
          canvasColor: kBackgroundColor,
          scaffoldBackgroundColor: kBackgroundColor,
          dialogBackgroundColor: kDarkShade,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
