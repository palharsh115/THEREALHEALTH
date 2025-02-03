import 'package:flutter/material.dart';
import 'package:flutter_application_3/dashboard_screen.dart'; // Ensure correct import path

class underweightscreen extends StatefulWidget {
  const underweightscreen({super.key});

  @override
  State<underweightscreen> createState() =>
      _HealthQuestionnaireScreenState();
}

class _HealthQuestionnaireScreenState
    extends State<underweightscreen> {
  // Updated questions for underweight
  final List<String> _questions = [
    "Do you often feel fatigued or lack energy?",
    "Have you experienced unintentional weight loss?",
    "Do you have a low body mass index (BMI)?",
    "Do you have a poor appetite or difficulty eating?",
    "Have you had any recent illnesses or infections?",
    "Do you experience dizziness or lightheadedness frequently?",
    "Do you have trouble concentrating?",
    "Do you experience hair thinning or loss?",
    "Do you have a history of eating disorders (e.g., anorexia, bulimia)?",
    "Have you noticed changes in your menstrual cycle (for women)?",
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
        title: const Text("Health Questionnaire"),
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
                              backgroundColor: _answers[index] == true
                                  ? Colors.teal
                                  : Colors.grey[300],
                            ),
                            child: const Text("Yes",
                                style: TextStyle(color: Colors.white)),
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

            // Submit Button
            ElevatedButton(
              onPressed: _submitAnswers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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