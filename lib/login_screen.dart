// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/otp_screen.dart';



// import 'dart:math';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'otp_screen.dart';

// typedef OTPCallback = void Function(String phoneNumber);

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
//   bool _isButtonPressed = false;
//   final TextEditingController _phoneController = TextEditingController();

//   late AnimationController _floatingController;
//   late Animation<double> _floatingAnimation;

//   late AnimationController _scalingController;
//   late Animation<double> _scalingAnimation;

//   bool _isFloatingAnimationActive = true;
//   Timer? _floatingPauseTimer;

//   @override
//   void initState() {
//     super.initState();

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

//     _scalingController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _scalingAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _scalingController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _startFloatingAnimationCycle();
//   }

//   void _startFloatingAnimationCycle() {
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
//     _phoneController.dispose();
//     super.dispose();
//   }

//   Future<void> _sendOTP() async {
//     final String phoneNumber = _phoneController.text.trim();
//     if (phoneNumber.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a valid phone number")),
//       );
//       return;
//     }

//     setState(() {
//       _isButtonPressed = true;
//     });

//     final Uri url = Uri.parse("http://10.0.2.2:3000/send-otp?phone=$phoneNumber");
//     try {
//       final response = await http.post(url);
//       if (response.statusCode == 200) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreen(phoneNumber: phoneNumber),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Failed to send OTP. Try again.")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }

//     setState(() {
//       _isButtonPressed = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(color: const Color(0xFF025464)),

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

//           Positioned(
//             top: screenHeight * 0.10 + (_isFloatingAnimationActive ? _floatingAnimation.value : 0),
//             left: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () async {
//                 setState(() {
//                   _isFloatingAnimationActive = false;
//                   _floatingController.stop();
//                 });

//                 await _scalingController.forward();
//                 await _scalingController.reverse();

//                 setState(() {
//                   _isFloatingAnimationActive = true;
//                 });
//                 _floatingController.repeat(reverse: true);
//               },
//               child: ScaleTransition(
//                 scale: _scalingAnimation,
//                 child: Center(
//                   child: Container(
//                     height: 250,
//                     width: 250,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       image: DecorationImage(
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


//           Positioned(
//             bottom: screenHeight * 0.1,
//             left: 30,
//             right: 30,
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _phoneController,
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
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 GestureDetector(
//                   onTap: _sendOTP,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     height: 60,
//                     width: _isButtonPressed ? 220 : 250,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFE57C23),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Center(
//                       child: Text(
//                         _isButtonPressed ? "Please Wait..." : "Agree & Continue",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
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

//  //Custom Painter for Static Waves
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



import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/base_url.dart';
import 'package:http/http.dart' as http;
import 'otp_screen.dart';
import 'base_url.dart';

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

  Future<void> sendOTP(String phone) async {
    final url = Uri.parse("$baseUrl/send-otp");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Response: ${data['message']}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phoneNumber: phone),
          ),
        );
      } else {
        final data = jsonDecode(response.body);
        _showSnackBar(data['message'] ?? "Failed to send OTP. Try again.");
      }
    } catch (error) {
      _showSnackBar("Error: $error");
    }

    setState(() {
      _isButtonPressed = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleSendOTP() {
    final String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      _showSnackBar("Please enter a valid phone number");
      return;
    }

    setState(() {
      _isButtonPressed = true;
    });

    sendOTP(phoneNumber);
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/test.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

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
                  onTap: _handleSendOTP,
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
      final y = size.height - 60 + sin((i / waveLength * 2 * pi) + (progress * 2 * pi)) * waveHeight;
      path.lineTo(i, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

