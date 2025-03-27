




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_application_3/RegistrationScreen.dart';
import 'dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with SingleTickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  Timer? _timer;
  int _remainingTime = 30;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Save token in SharedPreferences
  Future<void> _saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
    print("✅ Token saved successfully: $token");
  }

Future<void> _verifyOTP() async {
  String otp = _otpControllers.map((controller) => controller.text).join();
  if (otp.length != 6) {
    _showSnackBar('Please enter a valid 6-digit OTP.');
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:3000/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": widget.phoneNumber, "otp": otp}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      bool isNewUser = data['isNewUser'] ?? true; // Default to true if not provided
      String? token = data['token']; 

      if (token != null) {
        await _saveUserToken(token); // ✅ Save token for both new & existing users
      }

      if (!isNewUser) {
        _showSnackBar('Login successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        _showSnackBar('Proceed to registration.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      }
    } else {
      _showSnackBar(data['message'] ?? 'Invalid OTP, please try again!');
    }
  } catch (e) {
    _showSnackBar('Server error, please try again later.');
    print("Error verifying OTP: $e");
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  // Resend OTP API call
  Future<void> _resendOTP() async {
    setState(() {
      _remainingTime = 30;
      _startTimer();
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/resend-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": widget.phoneNumber}),
      );

      if (response.statusCode == 200) {
        _showSnackBar('OTP resent successfully!');
      } else {
        _showSnackBar('Failed to resend OTP, please try again!');
      }
    } catch (e) {
      _showSnackBar('Server error, please try again later.');
      print("Error resending OTP: $e");
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _moveToNextField(int index) {
    if (index < 5 && _otpControllers[index].text.isNotEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.teal,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OTP has been sent to ${widget.phoneNumber}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: const InputDecoration(counterText: '', border: InputBorder.none),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        onChanged: (value) => _moveToNextField(index),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verify', style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _remainingTime == 0 ? _resendOTP : null,
                  child: Text(_remainingTime == 0 ? 'Resend OTP' : 'Resend in $_remainingTime s'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
