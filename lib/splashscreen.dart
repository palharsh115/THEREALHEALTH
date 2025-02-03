// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideImageAnimation;
//   late Animation<Offset> _slideTextAnimation;
//   late Animation<double> _fadeTextAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..forward();

//     // Define animations
//     _slideImageAnimation = Tween<Offset>(
//       begin: const Offset(0, 0), // Start at the center
//       end: const Offset(-0.23, 0), // Move slightly to the left
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.0, 0.4, curve: Curves.easeInOutCubic),
//     ));

//     _slideTextAnimation = Tween<Offset>(
//       begin: const Offset(-0.5, 0), // Start slightly behind the image
//       end: const Offset(0.55, 0), // Move to the right side
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
//     ));

//     _fadeTextAnimation = Tween<double>(
//       begin: 0.0, // Fully transparent
//       end: 1.0, // Fully visible
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.84, 1.0, curve: Curves.easeInOut),
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.8, // Slightly smaller
//       end: 1.0, // Normal size
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.elasticOut,
//     ));

//     // Navigate to LoginScreen after the animation
//     Timer(const Duration(seconds: 10), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 224, 224, 224), // Vibrant Green
//               Color.fromARGB(255, 222, 224, 222), // Dark Green
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             children: [
//               // Image Animation
//               SlideTransition(
//                 position: _slideImageAnimation,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: Image.asset(
//                       'assets/images/test.jpg', // Replace with your image path
//                       width: 220,
//                       height: 270,
//                     ),
//                   ),
//                 ),
//               ),
//               // Text Animation
//               FadeTransition(
//                 opacity: _fadeTextAnimation,
//                 child: SlideTransition(
//                   position: _slideTextAnimation,
//                   child: const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "The Real\nHealth",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


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
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Color?> _gradientColorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Text slide animation
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // Start below the screen
      end: Offset.zero, // Move to the center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Text fade animation
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Gradient color animation
    _gradientColorAnimation = ColorTween(
      begin: const Color(0xFF6A11CB), // Deep Purple
      end: const Color(0xFF2575FC), // Bright Blue
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Navigate to LoginScreen after the animation
    Timer(const Duration(seconds: 5), () {
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
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _gradientColorAnimation.value!,
                  _gradientColorAnimation.value!.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  // Glowing Background Effect
                  Positioned.fill(
                    child: GlowingBackground(controller: _controller),
                  ),

                  // Particle Animation
                  Positioned.fill(
                    child: AnimatedParticles(controller: _controller),
                  ),

                  // Logo Animation
                  Center(
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: Image.asset(
                          'assets/images/Realhealth_logo.jpg', // Replace with your logo path
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),

                  // Text Animation
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _textSlideAnimation,
                      child: FadeTransition(
                        opacity: _textFadeAnimation,
                        child: const Center(
                          child: Text(
                            "The Real Health",
                            style: TextStyle(
                              fontFamily: 'Shrikhand', // Apply Shrikhand font
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
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

// Glowing Background Effect
class GlowingBackground extends StatelessWidget {
  final AnimationController controller;

  const GlowingBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.1 * controller.value),
                Colors.transparent,
              ],
              radius: 1.5 * controller.value,
            ),
          ),
        );
      },
    );
  }
}

// Particle Animation Widget
class AnimatedParticles extends StatelessWidget {
  final AnimationController controller;

  const AnimatedParticles({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            progress: controller.value,
          ),
        );
      },
    );
  }
}

// Particle Painter
class ParticlePainter extends CustomPainter {
  final double progress;

  ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    const particleCount = 50;
    for (var i = 0; i < particleCount; i++) {
      final x = size.width * (0.2 + 0.6 * (i / particleCount));
      final y = size.height * (0.1 + 0.8 * progress);
      final radius = 2.0 + 3.0 * (i / particleCount);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}