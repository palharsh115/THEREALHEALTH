import 'package:flutter/material.dart';
import 'package:flutter_application_3/dashboard_screen.dart'; // Ensure correct import path

class DigestiveQuestionnaireScreen extends StatefulWidget {
  const DigestiveQuestionnaireScreen({super.key});

  @override
  State<DigestiveQuestionnaireScreen> createState() => _DigestiveQuestionnaireScreenState();
}

class _DigestiveQuestionnaireScreenState extends State<DigestiveQuestionnaireScreen> {
  // Digestive issues-related questions
  final List<String> _questions = [
    "Do you frequently experience bloating?",
    "Do you often suffer from constipation or diarrhea?",
    "Do you have acid reflux or heartburn regularly?",
    "Do you feel discomfort or pain after eating?",
    "Do you have difficulty digesting certain foods?",
  ];

  // Tracking answers (Yes/No) for each question
  final Map<int, bool?> _answers = {};

  void _submitAnswers() {
    // Check if all questions are answered
    if (_answers.length == _questions.length && !_answers.containsValue(null)) {
      // Navigate to DashboardScreen after submitting answers
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      // Show an error if any question is unanswered
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Digestive Health Questionnaire"),
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

            // Questions list
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
                              backgroundColor: _answers[index] == true ? Colors.teal : Colors.grey[300],
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
                              backgroundColor: _answers[index] == false ? Colors.teal : Colors.grey[300],
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

            // Submit Button
            ElevatedButton(
              onPressed: _submitAnswers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
