import 'package:flutter/material.dart';
import 'package:flutter_application_3/qna_screen4.dart'; // Ensure this import is included

class MultipleChoiceQuestionScreen2 extends StatefulWidget {
  const MultipleChoiceQuestionScreen2({super.key});

  @override
  State<MultipleChoiceQuestionScreen2> createState() =>
      _MultipleChoiceQuestionScreenState();
}

class _MultipleChoiceQuestionScreenState
    extends State<MultipleChoiceQuestionScreen2> {
  // List to track selected answers (for checkboxes)
  final List<int> _selectedAnswers = [];

  // Variable for custom radio button selection (non-medical condition)
  int? _selectedButtonAnswer;

  void _submitAnswer() {
    // Check if at least one answer (either button or checkbox) is selected
    if (_selectedAnswers.isNotEmpty || _selectedButtonAnswer != null) {
      // Proceed if any answer is selected
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MultipleChoiceQuestionScreen3(),
        ), // Navigate to Dashboard
      );
    } else {
      // No answer selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one answer.')),
      );
    }
  }

  // Method to toggle selected answers (checkboxes)
  void _toggleCheckboxAnswer(int value) {
    setState(() {
      if (_selectedAnswers.contains(value)) {
        _selectedAnswers.remove(value); // Deselect
      } else {
        _selectedAnswers.add(value); // Select
      }
    });
  }

  // Method to handle the custom button selection (simulating radio button behavior)
  void _selectButtonAnswer(int value) {
    setState(() {
      if (_selectedButtonAnswer == value) {
        _selectedButtonAnswer =
            null; // Deselect if the same button is tapped again
      } else {
        _selectedButtonAnswer = value; // Select the new button
        _selectedAnswers
            .clear(); // Deselect checkboxes when a button is selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Condition Preferences'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Do you have any of the \n following health conditions?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Non-medical condition custom "raised" button
              ElevatedButton(
                onPressed: () =>
                    _selectButtonAnswer(0), // Simulate radio button selection
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedButtonAnswer == 0
                      ? const Color.fromARGB(0, 237, 239, 241)
                      : const Color.fromARGB(
                          0, 251, 255, 251), // Highlight when selected
                ),
                child: const Text('Non-medical condition'),
              ),

              const SizedBox(height: 20),

              // Thyroid checkbox
              CheckboxListTile(
                value: _selectedAnswers.contains(1),
                onChanged: _selectedButtonAnswer == null
                    ? (bool? value) {
                        _toggleCheckboxAnswer(1);
                      }
                    : null, // Disable checkbox if button is selected
                title: const Text('Thyroid'),
              ),

              // Diabetes / pre-Diabetes checkbox
              CheckboxListTile(
                value: _selectedAnswers.contains(2),
                onChanged: _selectedButtonAnswer == null
                    ? (bool? value) {
                        _toggleCheckboxAnswer(2);
                      }
                    : null, // Disable checkbox if button is selected
                title: const Text('Diabetes / pre-Diabetes'),
              ),

              // Cholesterol checkbox
              CheckboxListTile(
                value: _selectedAnswers.contains(3),
                onChanged: _selectedButtonAnswer == null
                    ? (bool? value) {
                        _toggleCheckboxAnswer(3);
                      }
                    : null, // Disable checkbox if button is selected
                title: const Text('Cholesterol'),
              ),

              // Others checkbox
              CheckboxListTile(
                value: _selectedAnswers.contains(4),
                onChanged: _selectedButtonAnswer == null
                    ? (bool? value) {
                        _toggleCheckboxAnswer(4);
                      }
                    : null, // Disable checkbox if button is selected
                title: const Text('Others'),
              ),

              const SizedBox(height: 30),

              // Continue button
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