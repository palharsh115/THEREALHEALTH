import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/otp_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.cyan.shade100,
//       body: Center(
//         child: AnimatedContainer(
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//           padding: const EdgeInsets.all(16.0),
//           margin: const EdgeInsets.symmetric(horizontal: 24.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyan.shade200,
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/Realhealth_logo.jpg',
//                 height: 250,
//                 width: 300,
//               ),
//               const SizedBox(height: 15),
//               const Text (
//                 'Welcome to Realhealth',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.cyan,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 25),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Icon(Icons.phone, color: Colors.cyan),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.cyan),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const OtpScreen(phoneNumber: ''),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
//                 ),
//                 child: const Text(
//                   'Send OTP',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// __________________________________________________________________________________

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _orbitAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat(reverse: true);

//     _orbitAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Background
//           Container(color: const Color(0xFFE5E3D4)),

//           // Animated Background Waves
//           Positioned.fill(
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: WavePainter(_controller.value),
//                 );
//               },
//             ),
//           ),

//           // Animated Logo Positioned at the Top
//           Positioned(
//             top: screenHeight * 0.12,
//             left: 0,
//             right: 0,
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 final double dx = sin(_orbitAnimation.value) * 20;
//                 final double dy = cos(_orbitAnimation.value) * 20;

//                 return Transform.translate(
//                   offset: Offset(dx, dy),
//                   child: Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Opacity(
//                       opacity: _fadeAnimation.value,
//                       child: Image.asset(
//                         'assets/images/test.jpg',
//                         height: 230,
//                         width: 250,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Heading and Subheading
//           Positioned(
//             top: screenHeight * 0.5,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Empowering wellness naturally",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Caveat',
//                     color: Color(0xFF1C325B),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 FadeTransition(
//                   opacity: _controller,
//                   child: const Text(
//                     "Your journey to real health begins here",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16, color: Color(0xFF6A669D)),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Phone Number Input and Button
//           Positioned(
//             bottom: screenHeight * 0.2,
//             left: 30,
//             right: 30,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Icon(Icons.phone, color: Color(0xFF9ABF80)),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF9ABF80)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OtpScreen(
//                           phoneNumber: '+1234567890',
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1C325B),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 50),
//                   ),
//                   child: const Text(
//                     'Agree & Continue',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter for Animated Waves
// class WavePainter extends CustomPainter {
//   final double progress;

//   WavePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF6A669D).withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const waveHeight = 20.0;
//     final waveLength = size.width / 1.5;

//     for (double i = 0; i < size.width; i++) {
//       final y = size.height -
//           60 +
//           sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
//       if (i == 0) {
//         path.moveTo(i, y);
//       } else {
//         path.lineTo(i, y);
//       }
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }






// ______________________________________________________________________________________



// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _orbitAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat();

//     _orbitAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.linear,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient Rotating Background
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       const Color(0xFFE5E3D4),
//                       const Color(0xFF9ABF80).withOpacity(
//                           (0.5 + 0.5 * sin(_orbitAnimation.value)).abs()),
//                       const Color(0xFF6A669D),
//                       const Color(0xFF1C325B).withOpacity(
//                           (0.5 + 0.5 * cos(_orbitAnimation.value)).abs()),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),

//           // Animated Waves
//           Positioned.fill(
//             child: CustomPaint(
//               painter: WavePainter(_controller.value),
//             ),
//           ),

//           // Logo Animation
//           Positioned(
//             top: screenHeight * 0.12,
//             left: 0,
//             right: 0,
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 final double dx = sin(_orbitAnimation.value) * 15;
//                 final double dy = cos(_orbitAnimation.value) * 15;

//                 return Transform.translate(
//                   offset: Offset(dx, dy),
//                   child: Transform.scale(
//                     scale: 1.2 + 0.1 * sin(_orbitAnimation.value),
//                     child: Image.asset(
//                       'assets/images/test.jpg',
//                       height: 200,
//                       width: 200,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Heading and Subheading
//           Positioned(
//             top: screenHeight * 0.45,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Empowering wellness naturally",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1C325B),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 FadeTransition(
//                   opacity: _controller,
//                   child: const Text(
//                     "Your journey to real health begins here",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6A669D),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Phone Number Input and Button
//           Positioned(
//             bottom: screenHeight * 0.2,
//             left: 30,
//             right: 30,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Icon(Icons.phone, color: Color(0xFF9ABF80)),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF9ABF80)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OtpScreen(
//                           phoneNumber: '+1234567890',
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1C325B),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 50),
//                   ),
//                   child: const Text(
//                     'Agree & Continue',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter for Waves
// class WavePainter extends CustomPainter {
//   final double progress;

//   WavePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF9ABF80).withOpacity(0.4)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const waveHeight = 20.0;
//     final waveLength = size.width / 1.5;

//     for (double i = 0; i < size.width; i++) {
//       final y = size.height - 60 +
//           sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
//       if (i == 0) {
//         path.moveTo(i, y);
//       } else {
//         path.lineTo(i, y);
//       }
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }







// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _orbitAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat(reverse: true);

//     _orbitAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(color: const Color.fromARGB(255, 209, 246, 193)),
//           Positioned.fill(
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: WavePainter(_controller.value),
//                 );
//               },
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.15,
//             left: 0,
//             right: 0,
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 final dx = sin(_orbitAnimation.value) * 20;
//                 final dy = cos(_orbitAnimation.value) * 20;

//                 return Transform.translate(
//                   offset: Offset(dx, dy),
//                   child: Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Opacity(
//                       opacity: _fadeAnimation.value,
//                       child: Image.asset(
//                         'assets/images/test.jpg',
//                         height: 200,
//                         width: 200,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.5,
//             left: 0,
//             right:0,
//             child: const Column(
//               children: [
//                 Text(
//                   "Empowering Wellness Naturally",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF150050),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Your journey to health starts here",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Color(0xFF3F0071)),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: screenHeight * 0.2,
//             left: 30,
//             right: 30,
//             child: Column(
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             "🇮🇳 +91",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                       ],
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OtpScreen(
//                           phoneNumber: '+1234567890',
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 28, 50, 91),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 50),
//                   ),
//                   child: const Text(
//                     'Agree & Continue',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WavePainter extends CustomPainter {
//   final double progress;

//   WavePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color.fromARGB(255, 69, 183, 183).withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const waveHeight = 20.0;
//     final waveLength = size.width / 1.5;

//     for (double i = 0; i < size.width; i++) {
//       final y = size.height - 60 +
//           sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
//       if (i == 0) {
//         path.moveTo(i, y);
//       } else {
//         path.lineTo(i, y);
//       }
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }



//---------------------------------------------------------------------------------

// import 'dart:math'; // For sine wave animation
// import 'dart:async';
// import 'otp_screen.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
//   bool _isButtonPressed = false;

//   late AnimationController _floatingController;
//   late Animation<double> _floatingAnimation;

//   late AnimationController _scalingController;
//   late Animation<double> _scalingAnimation;

//   bool _isFloatingAnimationActive = true;
//   Timer? _floatingPauseTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Floating Animation
//     _floatingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat(reverse: true);

//     _floatingAnimation = Tween<double>(begin: -20.0, end: 20.0).animate(
//       CurvedAnimation(
//         parent: _floatingController,
//         curve: Curves.easeInOut,
//       ),
//     );
  
//     // Scaling Animation
//     _scalingController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _scalingAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _scalingController,
//         curve: Curves.easeInOut,
//       ));

//     // Start "stop-and-go" animation behavior
//     _startFloatingAnimationCycle();
//   }

//   void _startFloatingAnimationCycle() {
//     // Keep animation active for a few seconds, then pause
//     _floatingPauseTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       setState(() {
//         _isFloatingAnimationActive = false;
//       });
//       _floatingController.stop();

//       Future.delayed(const Duration(seconds: 3), () {
//         setState(() {
//           _isFloatingAnimationActive = true;
//         });
//         _floatingController.repeat(reverse: true);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _scalingController.dispose();
//     _floatingPauseTimer?.cancel();
//     super.dispose();
//   }

//   void _onButtonTap() {
//     setState(() {
//       _isButtonPressed = true;
//     });

//     Future.delayed(const Duration(milliseconds: 300), () {
//       setState(() {
//         _isButtonPressed = false;
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const OtpScreen(
//             phoneNumber: '+1234567890',
//           ),
//         ),
//       );
//     });
//   }

//   void _onLogoTap() async {
//     setState(() {
//       _isFloatingAnimationActive = false;
//       _floatingController.stop();
//     });

//     await _scalingController.forward();
//     await _scalingController.reverse();

//     setState(() {
//       _isFloatingAnimationActive = true;
//     });
//     _floatingController.repeat(reverse: true);

//     // Perform additional actions here.
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Background
//           Container(color: const Color(0xFF025464)),

//           // Animated Background Waves
//           Positioned.fill(
//             child: AnimatedBuilder(
//               animation: _floatingController,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: WavePainter(_floatingController.value),
//                 );
//               },
//             ),
//           ),

//           // Animated Logo Positioned at the Top
//           Positioned(
//             top: screenHeight * 0.10 + (_isFloatingAnimationActive ? _floatingAnimation.value : 0),
//             left: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: _onLogoTap,
//               child: ScaleTransition(
//                 scale: _scalingAnimation,
//                 child: Center(
//                   child: Container(
//                     height: 250,
//                     width: 250,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                       image: const DecorationImage(
//                         image: AssetImage('assets/images/test.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Heading and Subheading
//           Positioned(
//             top: screenHeight * 0.5,
//             left: 0,
//             right: 0,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Empowering wellness naturally",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Caveat',
//                     color: Color(0xFFE57C23),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Your journey to real health begins here",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 251, 251, 250)),
//                 ),
//               ],
//             ),
//           ),

//           // Phone Number Input and Button
//           Positioned(
//             bottom: screenHeight * 0.1,
//             left: 30,
//             right: 30,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Icon(Icons.phone, color: Colors.teal),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.teal),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Button
//                 GestureDetector(
//                   onTap: _onButtonTap,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     height: 60,
//                     width: _isButtonPressed ? 220 : 250,
//                     decoration: BoxDecoration(
//                       color: _isButtonPressed
//                           ? const Color(0xFFE57C23).withOpacity(0.7)
//                           : const Color(0xFFE57C23),
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: const [],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 300),
//                           child: _isButtonPressed
//                               ? const Icon(
//                                   Icons.check_circle,
//                                   key: ValueKey('check_icon'),
//                                   color: Colors.white,
//                                 )
//                               : const Icon(
//                                   Icons.arrow_forward,
//                                   key: ValueKey('arrow_icon'),
//                                   color: Colors.white,
//                                 ),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           _isButtonPressed
//                               ? "Please Wait..."
//                               : "Agree & Continue",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter for Static Waves
// class WavePainter extends CustomPainter {
//   final double progress;

//   WavePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFBBDEFB).withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const waveHeight = 19.0;
//     const waveLength = 200.0;

//     for (double i = 0; i <= size.width; i++) {
//       final y = size.height -
//           60 +
//           sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
//       if (i == 0) {
//         path.moveTo(i, y);
//       } else {
//         path.lineTo(i, y);
//       }
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


//----------------------------------------------


//1

// import 'dart:math'; // For sine wave animation
// import 'dart:async';
// import 'otp_screen.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
//   bool _isButtonPressed = false;

//   late AnimationController _floatingController;
//   late Animation<double> _floatingAnimation;

//   late AnimationController _scalingController;
//   late Animation<double> _scalingAnimation;

//   bool _isFloatingAnimationActive = true;
//   Timer? _floatingPauseTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Floating Animation
//     _floatingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat(reverse: true);

//     _floatingAnimation = Tween<double>(begin: -20.0, end: 20.0).animate(
//       CurvedAnimation(
//         parent: _floatingController,
//         curve: Curves.easeInOut,
//       ),
//     );
  
//     // Scaling Animation
//     _scalingController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _scalingAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _scalingController,
//         curve: Curves.easeInOut,
//       ));

//     // Start "stop-and-go" animation behavior
//     _startFloatingAnimationCycle();
//   }

//   void _startFloatingAnimationCycle() {
//     // Keep animation active for a few seconds, then pause
//     _floatingPauseTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       setState(() {
//         _isFloatingAnimationActive = false;
//       });
//       _floatingController.stop();

//       Future.delayed(const Duration(seconds: 3), () {
//         setState(() {
//           _isFloatingAnimationActive = true;
//         });
//         _floatingController.repeat(reverse: true);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _scalingController.dispose();
//     _floatingPauseTimer?.cancel();
//     super.dispose();
//   }

//   void _onButtonTap() {
//     setState(() {
//       _isButtonPressed = true;
//     });

//     Future.delayed(const Duration(milliseconds: 300), () {
//       setState(() {
//         _isButtonPressed = false;
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const OtpScreen(
//             phoneNumber: '+1234567890',
//           ),
//         ),
//       );
//     });
//   }

//   void _onLogoTap() async {
//     setState(() {
//       _isFloatingAnimationActive = false;
//       _floatingController.stop();
//     });

//     await _scalingController.forward();
//     await _scalingController.reverse();

//     setState(() {
//       _isFloatingAnimationActive = true;
//     });
//     _floatingController.repeat(reverse: true);

//     // Perform additional actions here.
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Background
//           Container(color: const Color(0xFF025464)),

//           // Animated Background Waves
//           Positioned.fill(
//             child: AnimatedBuilder(
//               animation: _floatingController,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: WavePainter(_floatingController.value),
//                 );
//               },
//             ),
//           ),

//           // Animated Logo Positioned at the Top
//           Positioned(
//             top: screenHeight * 0.10 + (_isFloatingAnimationActive ? _floatingAnimation.value : 0),
//             left: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: _onLogoTap,
//               child: ScaleTransition(
//                 scale: _scalingAnimation,
//                 child: Center(
//                   child: Container(
//                     height: 250,
//                     width: 250,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                       image: const DecorationImage(
//                         image: AssetImage('assets/images/test.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Heading and Subheading
//           Positioned(
//             top: screenHeight * 0.5,
//             left: 0,
//             right: 0,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Empowering wellness naturally",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Caveat',
//                     color: Color(0xFFE57C23),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Your journey to real health begins here",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 251, 251, 250)),
//                 ),
//               ],
//             ),
//           ),

//           // Phone Number Input and Button
//           Positioned(
//             bottom: screenHeight * 0.1,
//             left: 30,
//             right: 30,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     prefixIcon: const Icon(Icons.phone, color: Colors.teal),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.teal),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Button
//                 GestureDetector(
//                   onTap: _onButtonTap,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     height: 60,
//                     width: _isButtonPressed ? 220 : 250,
//                     decoration: BoxDecoration(
//                       color: _isButtonPressed
//                           ? const Color(0xFFE57C23).withOpacity(0.7)
//                           : const Color(0xFFE57C23),
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: const [],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 300),
//                           child: _isButtonPressed
//                               ? const Icon(
//                                   Icons.check_circle,
//                                   key: ValueKey('check_icon'),
//                                   color: Colors.white,
//                                 )
//                               : const Icon(
//                                   Icons.arrow_forward,
//                                   key: ValueKey('arrow_icon'),
//                                   color: Colors.white,
//                                 ),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           _isButtonPressed
//                               ? "Please Wait..."
//                               : "Agree & Continue",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter for Static Waves
// class WavePainter extends CustomPainter {
//   final double progress;

//   WavePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFBBDEFB).withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const waveHeight = 19.0;
//     const waveLength = 200.0;

//     for (double i = 0; i <= size.width; i++) {
//       final y = size.height -
//           60 +
//           sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
//       if (i == 0) {
//         path.moveTo(i, y);
//       } else {
//         path.lineTo(i, y);
//       }
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

//========================

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otp_screen.dart';

typedef OTPCallback = void Function(String phoneNumber);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  bool _isButtonPressed = false;
  final TextEditingController _phoneController = TextEditingController();

  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  late AnimationController _scalingController;
  late Animation<double> _scalingAnimation;

  bool _isFloatingAnimationActive = true;
  Timer? _floatingPauseTimer;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -20.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );

    _scalingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scalingAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _scalingController,
        curve: Curves.easeInOut,
      ),
    );

    _startFloatingAnimationCycle();
  }

  void _startFloatingAnimationCycle() {
    _floatingPauseTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _isFloatingAnimationActive = false;
      });
      _floatingController.stop();

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isFloatingAnimationActive = true;
        });
        _floatingController.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _scalingController.dispose();
    _floatingPauseTimer?.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    final String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid phone number")),
      );
      return;
    }

    setState(() {
      _isButtonPressed = true;
    });

    final Uri url = Uri.parse("http://10.0.2.2:3000/send-otp?phone=$phoneNumber");
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send OTP. Try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }

    setState(() {
      _isButtonPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF025464)),

          Positioned.fill(
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(_floatingController.value),
                );
              },
            ),
          ),

          Positioned(
            top: screenHeight * 0.10 + (_isFloatingAnimationActive ? _floatingAnimation.value : 0),
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _isFloatingAnimationActive = false;
                  _floatingController.stop();
                });

                await _scalingController.forward();
                await _scalingController.reverse();

                setState(() {
                  _isFloatingAnimationActive = true;
                });
                _floatingController.repeat(reverse: true);
              },
              child: ScaleTransition(
                scale: _scalingAnimation,
                child: Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/test.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),



          
          // Heading and Subheading
          Positioned(
            top: screenHeight * 0.5,
            left: 0,
            right: 0,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Empowering wellness naturally",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Caveat',
                    color: Color(0xFFE57C23),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your journey to real health begins here",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 251, 251, 250)),
                ),
              ],
            ),
          ),


          Positioned(
            bottom: screenHeight * 0.1,
            left: 30,
            right: 30,
            child: Column(
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _sendOTP,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 60,
                    width: _isButtonPressed ? 220 : 250,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE57C23),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        _isButtonPressed ? "Please Wait..." : "Agree & Continue",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 //Custom Painter for Static Waves
class WavePainter extends CustomPainter {
  final double progress;

  WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBBDEFB).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path = Path();
    const waveHeight = 19.0;
    const waveLength = 200.0;

    for (double i = 0; i <= size.width; i++) {
      final y = size.height -
          60 +
          sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
      if (i == 0) {
        path.moveTo(i, y);
      } else {
        path.lineTo(i, y);
      }
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




