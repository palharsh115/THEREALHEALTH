import 'package:flutter/material.dart';
import 'package:flutter_application_3/splashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load theme preference from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(const MyApp());
}

// Notifier to toggle between light and dark mode
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, mode, _) {
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
              darkTheme: ThemeData.dark(),
              themeMode: mode,
              home:
                  const SplashScreen(), // Or use OtpScreen(phoneNumber: '') if needed
            );
          },
        );
      },
    );
  }
}
