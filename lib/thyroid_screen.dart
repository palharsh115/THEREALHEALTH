import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/base_url.dart';

class ThyroidQuestionnaireScreen extends StatefulWidget {
  const ThyroidQuestionnaireScreen({super.key});

  @override
  State<ThyroidQuestionnaireScreen> createState() =>
      _ThyroidQuestionnaireScreenState();
}

class _ThyroidQuestionnaireScreenState extends State<ThyroidQuestionnaireScreen> {
  final List<String> _questions = [
    "Do you experience unexplained weight changes?",
    "Do you often feel fatigued or tired?",
    "Do you have dry skin or thinning hair?",
    "Do you experience mood swings or depression?",
    "Have you noticed swelling in your neck area?",
  ];

  final Map<int, bool?> _answers = {};
  bool _isLoading = false;
  static final String _apiUrl = "$baseUrl/api/user/submit-health-data";

  Future<String?> _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  Future<void> _submitAnswers() async {
    if (_answers.length != _questions.length || _answers.containsValue(null)) {
      _showSnackBar("Please answer all questions.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String? token = await _getUserToken();
    if (token == null) {
      _showSnackBar("User not authenticated. Please login again.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    List<Map<String, String>> questionnaireResponses = _answers.entries.map((entry) {
      return {
        "question": _questions[entry.key],
        "answer": entry.value! ? "Yes" : "No",
      };
    }).toList();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "selectedCondition": "Thyroid",
          "questionnaireResponses": questionnaireResponses,
        }),
      );

      if (response.statusCode == 200) {
        _showSnackBar("Questionnaire submitted successfully!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        _showSnackBar("Error: ${response.body}");
      }
    } catch (e) {
      _showSnackBar("Network error: $e");
    }

    setState(() {
      _isLoading = false;
    });
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
        title: const Text("Thyroid Questionnaire"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Please answer the following questions:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(_questions[index]),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _answers[index] = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _answers[index] == true
                                  ? Colors.teal
                                  : Colors.grey[300],
                            ),
                            child: const Text("Yes",
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _answers[index] = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _answers[index] == false
                                  ? Colors.teal
                                  : Colors.grey[300],
                            ),
                            child: const Text("No",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitAnswers,
                    child: const Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}
