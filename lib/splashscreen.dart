import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

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

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
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

    // Navigate to LoginScreen after the animation
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 224, 224, 224), // Vibrant Green
              Color.fromARGB(255, 222, 224, 222), // Dark Green
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
                      "The Real\nHealth",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
