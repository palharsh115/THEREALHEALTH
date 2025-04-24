

import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideImageAnimation;
  late Animation<Offset> _slideTextAnimation;
  late Animation<double> _fadeTextAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();

    // Define animations
    _slideImageAnimation = Tween<Offset>(
      begin: const Offset(0, 0), // Start at the center
      end: const Offset(-0.23, 0), // Move slightly to the left
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeInOutCubic),
    ));

    _slideTextAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0), // Start slightly behind the image
      end: const Offset(0.55, 0), // Move to the right side
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
    ));

    _fadeTextAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.84, 1.0, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8, // Slightly smaller
      end: 1.0, // Normal size
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _backgroundColorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 86, 174, 182), // Light gray
      end: const Color.fromARGB(255, 85, 174, 182), // White
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

     checkUserAuth();
  }
  
  Future<void> checkUserAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    // Wait for animation to finish
    await Future.delayed(const Duration(seconds: 8));

    if (token != null && token.isNotEmpty) {
      // If token exists, navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()), // Change to your actual screen
      );
    } else {
      // If no token, navigate to Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _backgroundColorAnimation.value!,
                  _backgroundColorAnimation.value!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  // Image Animation
                  SlideTransition(
                    position: _slideImageAnimation,
                    child: Align(
                      alignment: Alignment.center,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'assets/images/test.jpg', // Replace with your image path
                          width: 220,
                          height: 270,
                        ),
                      ),
                    ),
                  ),
                  // Text Animation
                  FadeTransition(
                    opacity: _fadeTextAnimation,
                    child: SlideTransition(
                      position: _slideTextAnimation,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "THE REAL\nHEALTH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontFamily: 'Shrikhand',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Additional Text or Logo
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: _fadeTextAnimation,
                      child: const Center(
                        child: Text(
                          "Your Health, Our Priority",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}