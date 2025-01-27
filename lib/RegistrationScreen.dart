import 'package:flutter/material.dart';
import 'qna_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;  
  String? _alternativePhoneNumber; // Declare the phone number variable

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightFeetController = TextEditingController();
  final _heightCmController = TextEditingController();
  final _weightController = TextEditingController();

  bool isHeightInCm = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MultipleChoiceQuestionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s Know You Better'),
        backgroundColor: const Color(0xFF88D9E6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF6EB5C0)),
                  filled: true,
                  fillColor: const Color(0xFFF4F9F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: const Icon(Icons.wc, color: Color(0xFF6EB5C0)),
                  filled: true,
                  fillColor: const Color(0xFFF4F9F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Age Field
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: const Icon(Icons.cake, color: Color(0xFF6EB5C0)),
                  filled: true,
                  fillColor: const Color(0xFFF4F9F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Height Field
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Enter Height in Centimeters'),
                value: isHeightInCm,
                activeColor: const Color(0xFF6EB5C0),
                onChanged: (value) {
                  setState(() {
                    isHeightInCm = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              if (isHeightInCm)
                TextFormField(
                  controller: _heightCmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
                    filled: true,
                    fillColor: const Color(0xFFF4F9F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter height in cm';
                    }
                    return null;
                  },
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _heightFeetController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Height (ft)',
                          prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
                          filled: true,
                          fillColor: const Color(0xFFF4F9F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter height in feet';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),

              // Weight Field
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: const Icon(Icons.fitness_center, color: Color(0xFF6EB5C0)),
                  filled: true,
                  fillColor: const Color(0xFFF4F9F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Alternative Phone Number Field
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Alternative Phone Number',
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF6EB5C0)),
                  filled: true,
                  fillColor: const Color(0xFFF4F9F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _alternativePhoneNumber = value; // Store the alternative phone number
                  });
                },
                validator: (value) {
                  if (value == null || value.isNotEmpty) {
                    return 'Please enter an alternative phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Next Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE57C23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
