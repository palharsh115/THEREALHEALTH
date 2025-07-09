import 'package:flutter/material.dart';
import 'package:flutter_application_3/splashscreen.dart';
import 'otp_screen.dart';
import 'splashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(390, 844), // Your Figma/mockup size (e.g., iPhone 12)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'The Real Health',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.teal.shade50,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black87),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.teal,
              elevation: 5,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const OtpScreen(phoneNumber: ""), // Start with OtpScreen
  );
}
