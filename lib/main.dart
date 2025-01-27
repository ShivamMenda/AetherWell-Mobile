import 'package:aetherwell/bindings/splash_binding.dart';
import 'package:aetherwell/routes/app_pages.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: "AetherWell",
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueAccent,
              elevation: 0,
              toolbarHeight: 8.h,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            primarySwatch: Colors.blue,
            primaryColor: Colors.blueAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          getPages: AppPages.pages,
          initialBinding: SplashBinding(),
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
