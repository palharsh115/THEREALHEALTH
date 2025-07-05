import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Import all required screens
import 'package:flutter_application_3/allergic_screen.dart';
import 'package:flutter_application_3/bloodpressure_screen.dart';
import 'package:flutter_application_3/cholestrol_screen.dart';
import 'package:flutter_application_3/diabetes_questionnaire_screen.dart';
import 'package:flutter_application_3/digestive_screen.dart';
import 'package:flutter_application_3/healthquestionaire_screen.dart';
import 'package:flutter_application_3/pcod_screen.dart';
import 'package:flutter_application_3/thyroid_screen.dart';
import 'package:flutter_application_3/underweightscreen.dart';
import 'package:flutter_application_3/base_url.dart';

class MultipleChoiceQuestionScreen2 extends StatefulWidget {
  final String userName;
  final VoidCallback onContinue;

  const MultipleChoiceQuestionScreen2({
    super.key,
    required this.userName,
    required this.onContinue,
  });

  @override
  State<MultipleChoiceQuestionScreen2> createState() =>
      _MultipleChoiceQuestionScreenState();
}

class _MultipleChoiceQuestionScreenState
    extends State<MultipleChoiceQuestionScreen2> with SingleTickerProviderStateMixin {
  int? _selectedAnswer; // Single selection (checkbox logic fixed)
  String _otherInput = "";
  bool _isLoading = false; // Loading state
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  // Backend API URL
  static final String _apiUrl = "$baseUrl/api/user/submit-health-data"; 

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<String?> _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  void _selectAnswer(int value) {
    setState(() {
      _selectedAnswer = value;
    });
  }

  Future<void> _submitAnswer() async {
    if (_isLoading) return; // Prevent duplicate submissions

    if (_selectedAnswer == null) {
      _showSnackBar("Please select a health condition.");
      return;
    }

    String? token = await _getUserToken(); // Get token from SharedPreferences
    if (token == null) {
      _showSnackBar("User not authenticated.");
      return;
    }

    String selectedCondition = [
      "Thyroid",
      "Diabetes / Pre-Diabetes",
      "PCOD/PCOS",
      "Cholesterol",
      "Blood Pressure",
      "Obesity",
      "Under Weight",
      "Digestive Issues",
      "Allergic Issues",
      "Others",
    ][_selectedAnswer! - 1];

    String otherCondition = _selectedAnswer == 10 ? _otherInput : "";

    setState(() {
      _isLoading = true;
    });

    bool success = await _sendHealthData(
      token: token,
      userName: widget.userName,
      selectedCondition: selectedCondition,
      otherCondition: otherCondition.isNotEmpty ? otherCondition : null,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _navigateToQuestionnaire();
    } else {
      _showSnackBar("Error sending data. Please try again.");
    }
  }

  Future<bool> _sendHealthData({
    required String token,
    required String userName,
    required String selectedCondition,
    String? otherCondition,
  }) async {
    try {
      Map<String, dynamic> requestData = {
        "userName": userName,
        "selectedCondition": selectedCondition,
        if (otherCondition != null) "otherCondition": otherCondition,
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ✅ Added authentication token
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print("✅ Data sent successfully: ${response.body}");
        return true;
      } else {
        print("❌ API Error: ${response.statusCode}, ${response.body}");
        return false;
      }
    } catch (error) {
      print("❌ Network Error: $error");
      return false;
    }
  }

  void _navigateToQuestionnaire() {
    switch (_selectedAnswer) {
      case 1:
        _navigateToScreen(const ThyroidQuestionnaireScreen());
        break;
      case 2:
        _navigateToScreen(const DiabetesQuestionnaireScreen());
        break;
      case 3:
        _navigateToScreen(const PCOSQuestionnaireScreen());
        break;
      case 4:
        _navigateToScreen(const CholesterolQuestionnaireScreen());
        break;
      case 5:
        _navigateToScreen(const BloodPressureQuestionnaireScreen());
        break;
      case 6:
        _navigateToScreen(const HealthQuestionnaireScreen());
        break;
      case 7:
        _navigateToScreen(const UnderweightScreen());
        break;
      case 8:
        _navigateToScreen(const DigestiveQuestionnaireScreen());
        break;
      case 9:
        _navigateToScreen(const AllergicIssuesQuestionnaireScreen());
        break;
      default:
        widget.onContinue();
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Condition Preferences'),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Do you have any of the following health conditions?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Health conditions checkboxes (Single Selection)
            ...List.generate(10, (index) {
              return _buildOptionTile(
                [
                  'Thyroid',
                  'Diabetes / Pre-Diabetes',
                  'PCOD/PCOS',
                  'Cholesterol',
                  'Blood Pressure',
                  'Obesity',
                  'Under Weight',
                  'Digestive Issues',
                  'Allergic Issues',
                  'Others',
                ][index],
                index + 1,
              );
            }),

            if (_selectedAnswer == 10)
              TextField(
                onChanged: (value) => setState(() => _otherInput = value),
                decoration: const InputDecoration(labelText: 'Enter your condition'),
              ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitAnswer,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(String title, int value) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedAnswer == value,
      onChanged: (bool? isChecked) {
        if (isChecked != null && isChecked) {
          _selectAnswer(value);
        }
      },
    );
  }
}

