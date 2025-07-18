

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/dashboard_screen.dart';
import 'package:flutter_application_3/base_url.dart';

// PCOS Questionnaire Screen
class PCOSQuestionnaireScreen extends StatefulWidget {
  const PCOSQuestionnaireScreen({super.key});

  @override
  State<PCOSQuestionnaireScreen> createState() => _PCOSQuestionnaireScreenState();
}

class _PCOSQuestionnaireScreenState extends State<PCOSQuestionnaireScreen> {
  final List<String> _questions = [
    "Do you have irregular menstrual cycles?",
    "Do you experience excessive hair growth (hirsutism)?",
    "Have you noticed significant weight gain recently?",
    "Do you have acne or oily skin issues?",
    "Do you experience frequent mood swings or depression?",
    "Have you experienced difficulty in conceiving?",
  ];

  final Map<int, bool?> _answers = {};
  bool _isLoading = false;

  Future<String?> _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  Future<void> _submitAnswers() async {
    if (_answers.length != _questions.length || _answers.containsValue(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String? token = await _getUserToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
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

    final url = Uri.parse("$baseUrl/api/user/submit-health-data");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "selectedCondition": "PCOS",
          "questionnaireResponses": questionnaireResponses,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Health data submitted successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PCOD/PCOS Questionnaire"),
        backgroundColor: Colors.pinkAccent,
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
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _answers[index] = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: _answers[index] == true
                                  ? Colors.pinkAccent
                                  : Colors.grey[300],
                            ),
                            child: const Text("Yes", style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _answers[index] = false;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: _answers[index] == false
                                  ? Colors.pinkAccent
                                  : Colors.grey[300],
                            ),
                            child: const Text("No", style: TextStyle(color: Colors.white)),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
