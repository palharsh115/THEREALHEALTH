

// library;


// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/qna_screen3.dart';
// import 'package:http/http.dart' as http;
// import 'dashboard_screen.dart'; // Ensure this import is correct
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedGender;
//   String? _alternativePhoneNumber;

//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _heightFeetController = TextEditingController();
//   final _heightCmController = TextEditingController();
//   final _weightController = TextEditingController();

//   bool isHeightInCm = true;
//   late AnimationController _controller;
//   late Animation<double> _buttonScaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller for the "Next" button
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     // Button scale animation
//     _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _nameController.dispose();
//     _ageController.dispose();
//     _heightFeetController.dispose();
//     _heightCmController.dispose();
//     _weightController.dispose();
//     super.dispose();
//   }

//   Future<String?> getUserPhone() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("user_phone");
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       String? phoneNumber = await getUserPhone();
//       if (phoneNumber == null) {
//         print("❌ No phone number found in SharedPreferences");
//         return;
//       }

//       final userData = {
//         "phone": phoneNumber,
//         "name": _nameController.text,
//         "gender": _selectedGender,
//         "age": int.tryParse(_ageController.text) ?? 0,
//         "height": isHeightInCm
//             ? int.tryParse(_heightCmController.text) ?? 0
//             : (int.tryParse(_heightFeetController.text) ?? 0) * 30.48,
//         "weight": int.tryParse(_weightController.text) ?? 0,
//         "alternativePhoneNumber": _alternativePhoneNumber ?? "",
//       };
//     try {
//       final response = await http.post(
//         Uri.parse("http://10.0.2.2:3000/submit-form"),
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(userData),
//       );

//       print("Response Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");

//       if (response.statusCode == 201) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MultipleChoiceQuestionScreen2(
//               userName: _nameController.text,
//               onContinue: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DashboardScreen(userName: _nameController.text),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to register: ${response.body}")),
//         );
//       }
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error connecting to server: $e")),
//       );
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Set background color to white
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 const Text(
//                   'Let\'s Know You Better',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black, // Set text color to black
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Full Name Field
//                 _buildTextField(
//                   controller: _nameController,
//                   labelText: 'Full Name',
//                   icon: Icons.person,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Gender Dropdown
//                 _buildDropdown(
//                   value: _selectedGender,
//                   items: ['Male', 'Female', 'Other'],
//                   labelText: 'Gender',
//                   icon: Icons.wc,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGender = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select your gender';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Age Field
//                 _buildTextField(
//                   controller: _ageController,
//                   labelText: 'Age',
//                   icon: Icons.cake,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your age';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Height Field
//                 _buildHeightField(),
//                 const SizedBox(height: 20),

//                 // Weight Field
//                 _buildTextField(
//                   controller: _weightController,
//                   labelText: 'Weight (kg)',
//                   icon: Icons.fitness_center,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your weight';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Alternative Phone Number Field
//                 _buildTextField(
//                   labelText: 'alternativePhone Number',
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   onChanged: (value) {
//                     setState(() {
//                       _alternativePhoneNumber = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: ScaleTransition(
//         scale: _buttonScaleAnimation,
//         child: FloatingActionButton(
//           onPressed: _submitForm,
//           backgroundColor: Colors.black, // Set button color to black
//           child: const Icon(Icons.arrow_forward, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     TextEditingController? controller,
//     required String labelText,
//     required IconData icon,
//     TextInputType? keyboardType,
//     void Function(String)? onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[200], // Light grey background for input fields
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: const TextStyle(color: Colors.black), // Set text color to black
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: const TextStyle(color: Colors.black54), // Set label color to black54
//           prefixIcon: Icon(icon, color: Colors.black54), // Set icon color to black54
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//         onChanged: onChanged,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String? value,
//     required List<String> items,
//     required String labelText,
//     required IconData icon,
//     void Function(String?)? onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[200], // Light grey background for dropdown
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         items: items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
//         dropdownColor: Colors.grey[200], // Light grey background for dropdown items
//         style: const TextStyle(color: Colors.black), // Set text color to black
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: const TextStyle(color: Colors.black54), // Set label color to black54
//           prefixIcon: Icon(icon, color: Colors.black54), // Set icon color to black54
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//         onChanged: onChanged,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildHeightField() {
//     return Column(
//       children: [
//         SwitchListTile(
//           contentPadding: EdgeInsets.zero,
//           title: const Text(
//             'Enter Height in Centimeters',
//             style: TextStyle(color: Colors.black54), // Set text color to black54
//           ),
//           value: isHeightInCm,
//           activeColor: Colors.black, // Set switch color to black
//           onChanged: (value) {
//             setState(() {
//               isHeightInCm = value;
//             });
//           },
//         ),
//         const SizedBox(height: 8),
//         if (isHeightInCm)
//           _buildTextField(
//             controller: _heightCmController,
//             labelText: 'Height (cm)',
//             icon: Icons.height,
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter height in cm';
//               }
//               return null;
//             },
//           )
//         else
//           _buildTextField(
//             controller: _heightFeetController,
//             labelText: 'Height (ft)',
//             icon: Icons.height,
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter height in feet';
//               }
//               return null;
//             },
//           ),
//       ],
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import 'package:flutter_application_3/qna_screen3.dart';

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
        Uri.parse("http://10.0.2.2:3000/submit-form"),
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
                    builder: (context) => DashboardScreen(userName: _nameController.text),
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
                _buildTextField(_nameController, "Full Name", Icons.person),
                _buildDropdown(),
                _buildTextField(_ageController, "Age", Icons.cake, keyboardType: TextInputType.number),
                _buildHeightField(),
                _buildTextField(_weightController, "Weight (kg)", Icons.fitness_center, keyboardType: TextInputType.number),
                _buildTextField(null, "Alternative Phone Number", Icons.phone, keyboardType: TextInputType.phone, onChanged: (value) => _alternativePhoneNumber = value),
                const SizedBox(height: 30),
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

  Widget _buildTextField(TextEditingController? controller, String labelText, IconData icon, {TextInputType? keyboardType, void Function(String)? onChanged}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: labelText, prefixIcon: Icon(icon)),
      onChanged: onChanged,
      validator: (value) => value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: ["Male", "Female", "Other"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      decoration: const InputDecoration(labelText: "Gender", prefixIcon: Icon(Icons.wc)),
      onChanged: (value) => setState(() => _selectedGender = value),
      validator: (value) => value == null ? 'Please select gender' : null,
    );
  }

  Widget _buildHeightField() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Enter Height in Centimeters"),
          value: isHeightInCm,
          onChanged: (value) => setState(() => isHeightInCm = value),
        ),
        _buildTextField(isHeightInCm ? _heightCmController : _heightFeetController, isHeightInCm ? "Height (cm)" : "Height (ft)", Icons.height, keyboardType: TextInputType.number),
      ],
    );
  }
}
