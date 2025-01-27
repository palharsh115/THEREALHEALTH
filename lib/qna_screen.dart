import 'package:flutter/material.dart';
import 'package:flutter_application_3/qna_screen2.dart';

class MultipleChoiceQuestionScreen extends StatefulWidget {
  const MultipleChoiceQuestionScreen({super.key});

  @override
  State<MultipleChoiceQuestionScreen> createState() =>
      _MultipleChoiceQuestionScreenState();
}

class _MultipleChoiceQuestionScreenState
    extends State<MultipleChoiceQuestionScreen> {
  int? _selectedAnswer;

  void _submitAnswer() {
    if (_selectedAnswer != null) {
      // Any answer selected is correct
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('')),
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MultipleChoiceQuestionScreen1(),
        ), // Navigate to Dashboard
      );
    } else {
      // No answer selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an answer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'What\'s your dietary\n preference?',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RadioListTile<int>(
                value: 0,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Vegan'),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Pure Vegetarian'),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Ovo Vegetarian'),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Non Vegetarian'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}