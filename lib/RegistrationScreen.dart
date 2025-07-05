import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import 'package:flutter_application_3/qna_screen3.dart';
import 'package:flutter_application_3/base_url.dart';

class RegistrationScreen extends StatefulWidget {
  
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _alternativePhoneNumber;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightFeetController = TextEditingController();
  final _heightCmController = TextEditingController();
  final _weightController = TextEditingController();
  bool isHeightInCm = true;
  late AnimationController _controller;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _heightFeetController.dispose();
    _heightCmController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<String?> _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    String? token = await _getUserToken();
    if (token == null) {
      _showSnackBar("User not authenticated.");
      return;
    }
    
    final userData = {
      "name": _nameController.text,
      "gender": _selectedGender,
      "age": int.tryParse(_ageController.text) ?? 0,
      "height": isHeightInCm
          ? int.tryParse(_heightCmController.text) ?? 0
          : (int.tryParse(_heightFeetController.text) ?? 0) * 30.48,
      "weight": int.tryParse(_weightController.text) ?? 0,
      "alternativePhoneNumber": _alternativePhoneNumber ?? "",
    };
    
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/user/submit-form"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(userData),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        _showSnackBar("Registration successful!");
          // Navigate to MultipleChoiceQuestionScreen2 first
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultipleChoiceQuestionScreen2(
              userName: _nameController.text,
              onContinue: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              }, 
            ),
          ),
        );
      } else {
        _showSnackBar("Failed to register: ${data['message']}");
      }
    } catch (e) {
      _showSnackBar("Error connecting to server: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                const Text(
                  "Let’s Get Started",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Fill in the details below to complete your registration.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name Field
                _buildModernTextField(
                  controller: _nameController,
                  labelText: "Full Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                _buildModernDropdown(
                  value: _selectedGender,
                  items: ["Male", "Female", "Other"],
                  labelText: "Gender",
                  icon: Icons.wc,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Age Field
                _buildModernTextField(
                  controller: _ageController,
                  labelText: "Age",
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Height Field
                _buildHeightField(),
                const SizedBox(height: 16),

                // Weight Field
                _buildModernTextField(
                  controller: _weightController,
                  labelText: "Weight (kg)",
                  icon: Icons.fitness_center,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Alternative Phone Number Field
                _buildModernTextField(
                  labelText: "Alternative Phone Number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _alternativePhoneNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 30),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _buttonScaleAnimation,
        child: FloatingActionButton(
          onPressed: _submitForm,
          backgroundColor: Colors.black,
          child: const Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ),
    );
  }

  // Modern Text Field Widget
  Widget _buildModernTextField({
    TextEditingController? controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: onChanged,
        validator: (value) => value == null || value.isEmpty ? 'Please enter $labelText' : null,
      ),
    );
  }

  // Modern Dropdown Widget
  Widget _buildModernDropdown({
    required String? value,
    required List<String> items,
    required String labelText,
    required IconData icon,
    void Function(String?)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        dropdownColor: Colors.grey[200],
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $labelText' : null,
      ),
    );
  }

  // Height Field Widget
  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            "Enter Height in Centimeters",
            style: TextStyle(color: Colors.black54),
          ),
          value: isHeightInCm,
          activeColor: Colors.black,
          onChanged: (value) {
            setState(() {
              isHeightInCm = value;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildModernTextField(
          controller: isHeightInCm ? _heightCmController : _heightFeetController,
          labelText: isHeightInCm ? "Height (cm)" : "Height (ft)",
          icon: Icons.height,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
