import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/services/localization_service.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
        translations: LocalizationService(),
        locale: const Locale("en"),
        title: title,
        home: const SplashScreen(),
      ),
    );
  }
}
