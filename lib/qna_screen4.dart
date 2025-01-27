import 'package:flutter/material.dart';
import 'package:flutter_application_3/dashboard_screen.dart';

class MultipleChoiceQuestionScreen3 extends StatefulWidget {
  const MultipleChoiceQuestionScreen3({super.key});

  @override
  State<MultipleChoiceQuestionScreen3> createState() =>
      _MultipleChoiceQuestionScreenState();
}

class _MultipleChoiceQuestionScreenState
    extends State<MultipleChoiceQuestionScreen3> {
  int? _selectedAnswer;

  void _submitAnswer() {
    if (_selectedAnswer != null) {
      // Any answer selected is correct
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Correct answer!')),
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Have you attempt any of the following in the past to lose weight?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                title: const Text('Never tried to lose earlier'),
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Paid diet plans'),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Gym membership'),
              ),
              RadioListTile<int>(
                value: 3,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Green tea'),
              ),
              RadioListTile<int>(
                value: 4,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Yoga/dance/Aerobics'),
              ),
              RadioListTile<int>(
                value: 5,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title:
                    const Text('Slimming pills/Meal replacement kits/Shakes'),
              ),
              RadioListTile<int>(
                value: 6,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
                title: const Text('Others'),
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