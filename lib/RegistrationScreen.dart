// import 'package:flutter/material.dart';
// import 'qna_screen3.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedGender;
//   String? _alternativePhoneNumber; // Declare the phone number variable

//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _heightFeetController = TextEditingController();
//   final _heightCmController = TextEditingController();
//   final _weightController = TextEditingController();

//   bool isHeightInCm = false;

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const MultipleChoiceQuestionScreen2()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Let\'s Know You Better'),
//         backgroundColor: const Color(0xFF88D9E6),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Full Name Field
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                   prefixIcon: const Icon(Icons.person, color: Color(0xFF6EB5C0)),
//                   filled: true,
//                   fillColor: const Color(0xFFF4F9F9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Gender Dropdown
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ['Male', 'Female', 'Other']
//                     .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                     .toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                   prefixIcon: const Icon(Icons.wc, color: Color(0xFF6EB5C0)),
//                   filled: true,
//                   fillColor: const Color(0xFFF4F9F9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select your gender';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Age Field
//               TextFormField(
//                 controller: _ageController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Age',
//                   prefixIcon: const Icon(Icons.cake, color: Color(0xFF6EB5C0)),
//                   filled: true,
//                   fillColor: const Color(0xFFF4F9F9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your age';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Height Field
//               SwitchListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: const Text('Enter Height in Centimeters'),
//                 value: isHeightInCm,
//                 activeColor: const Color(0xFF6EB5C0),
//                 onChanged: (value) {
//                   setState(() {
//                     isHeightInCm = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               if (isHeightInCm)
//                 TextFormField(
//                   controller: _heightCmController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Height (cm)',
//                     prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
//                     filled: true,
//                     fillColor: const Color(0xFFF4F9F9),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter height in cm';
//                     }
//                     return null;
//                   },
//                 )
//               else
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _heightFeetController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Height (ft)',
//                           prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: const Color(0xFFF4F9F9),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter height in feet';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 16),

//               // Weight Field
//               TextFormField(
//                 controller: _weightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Weight (kg)',
//                   prefixIcon: const Icon(Icons.fitness_center, color: Color(0xFF6EB5C0)),
//                   filled: true,
//                   fillColor: const Color(0xFFF4F9F9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your weight';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Alternative Phone Number Field
//               TextFormField(
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Alternative Phone Number',
//                   prefixIcon: const Icon(Icons.phone, color: Color(0xFF6EB5C0)),
//                   filled: true,
//                   fillColor: const Color(0xFFF4F9F9),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _alternativePhoneNumber = value; // Store the alternative phone number
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isNotEmpty) {
//                     return 'Please enter an alternative phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Next Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFE57C23),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                   ),
//                   child: const Text(
//                     'Next',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'qna_screen3.dart';

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

//   bool isHeightInCm = false;
//   late AnimationController _controller;
//   late Animation<Color?> _backgroundColorAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 10),
//     )..repeat(reverse: true);

//     // Background color animation
//     _backgroundColorAnimation = ColorTween(
//       begin: const Color(0xFF88D9E6),
//       end: const Color(0xFF6EB5C0),
//     ).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const MultipleChoiceQuestionScreen2()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Let\'s Know You Better',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF88D9E6),
//         elevation: 0,
//       ),
//       body: AnimatedBuilder(
//         animation: _backgroundColorAnimation,
//         builder: (context, child) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [_backgroundColorAnimation.value!, Colors.white],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Full Name Field
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                           labelText: 'Full Name',
//                           prefixIcon: const Icon(Icons.person, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Gender Dropdown
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: DropdownButtonFormField<String>(
//                         value: _selectedGender,
//                         items: ['Male', 'Female', 'Other']
//                             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//                             .toList(),
//                         decoration: InputDecoration(
//                           labelText: 'Gender',
//                           prefixIcon: const Icon(Icons.wc, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedGender = value;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null) {
//                             return 'Please select your gender';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Age Field
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _ageController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Age',
//                           prefixIcon: const Icon(Icons.cake, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your age';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Height Field
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           SwitchListTile(
//                             contentPadding: EdgeInsets.zero,
//                             title: const Text('Enter Height in Centimeters'),
//                             value: isHeightInCm,
//                             activeColor: const Color(0xFF6EB5C0),
//                             onChanged: (value) {
//                               setState(() {
//                                 isHeightInCm = value;
//                               });
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           if (isHeightInCm)
//                             TextFormField(
//                               controller: _heightCmController,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 labelText: 'Height (cm)',
//                                 prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter height in cm';
//                                 }
//                                 return null;
//                               },
//                             )
//                           else
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: _heightFeetController,
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       labelText: 'Height (ft)',
//                                       prefixIcon: const Icon(Icons.height, color: Color(0xFF6EB5C0)),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter height in feet';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Weight Field
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         controller: _weightController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Weight (kg)',
//                           prefixIcon: const Icon(Icons.fitness_center, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your weight';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Alternative Phone Number Field
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: TextFormField(
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           labelText: 'Alternative Phone Number',
//                           prefixIcon: const Icon(Icons.phone, color: Color(0xFF6EB5C0)),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             _alternativePhoneNumber = value;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isNotEmpty) {
//                             return 'Please enter an alternative phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 30),

//                     // Next Button
//                     Center(
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         transform: Matrix4.identity()..scale(_controller.value * 0.1 + 1),
//                         child: ElevatedButton(
//                           onPressed: _submitForm,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE57C23),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                             elevation: 5,
//                           ),
//                           child: const Text(
//                             'Next',
//                             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'qna_screen3.dart'; // Ensure this import is correct for your project

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

//   bool isHeightInCm = false;
//   late AnimationController _controller;
//   late Animation<Color?> _backgroundColorAnimation;
//   late Animation<double> _buttonScaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     // Background color animation
//     _backgroundColorAnimation = ColorTween(
//       begin: const Color(0xFF6A1B9A),
//       end: const Color(0xFFAB47BC),
//     ).animate(_controller);

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

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const MultipleChoiceQuestionScreen2()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Let\'s Know You Better',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: AnimatedBuilder(
//         animation: _backgroundColorAnimation,
//         builder: (context, child) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [_backgroundColorAnimation.value!, Colors.white],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Full Name Field
//                     _buildAnimatedTextField(
//                       controller: _nameController,
//                       labelText: 'Full Name',
//                       icon: Icons.person,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),

//                     // Gender Dropdown
//                     _buildAnimatedDropdown(
//                       value: _selectedGender,
//                       items: ['Male', 'Female', 'Other'],
//                       labelText: 'Gender',
//                       icon: Icons.wc,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedGender = value;
//                         });
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select your gender';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),

//                     // Age Field
//                     _buildAnimatedTextField(
//                       controller: _ageController,
//                       labelText: 'Age',
//                       icon: Icons.cake,
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your age';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),

//                     // Height Field
//                     _buildHeightField(),
//                     const SizedBox(height: 20),

//                     // Weight Field
//                     _buildAnimatedTextField(
//                       controller: _weightController,
//                       labelText: 'Weight (kg)',
//                       icon: Icons.fitness_center,
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your weight';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),

//                     // Alternative Phone Number Field
//                     _buildAnimatedTextField(
//                       labelText: 'Alternative Phone Number',
//                       icon: Icons.phone,
//                       keyboardType: TextInputType.phone,
//                       onChanged: (value) {
//                         setState(() {
//                           _alternativePhoneNumber = value;
//                         });
//                       },
//                       validator: (value) {
//                         if (value == null || value.isNotEmpty) {
//                           return 'Please enter an alternative phone number';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 30),

//                     // Next Button
//                     Center(
//                       child: ScaleTransition(
//                         scale: _buttonScaleAnimation,
//                         child: ElevatedButton(
//                           onPressed: _submitForm,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE91E63),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                             elevation: 5,
//                           ),
//                           child: const Text(
//                             'Next',
//                             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAnimatedTextField({
//     TextEditingController? controller,
//     required String labelText,
//     required IconData icon,
//     TextInputType? keyboardType,
//     void Function(String)? onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Icon(icon, color: const Color(0xFF6A1B9A)),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         onChanged: onChanged,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildAnimatedDropdown({
//     required String? value,
//     required List<String> items,
//     required String labelText,
//     required IconData icon,
//     void Function(String?)? onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         items: items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Icon(icon, color: const Color(0xFF6A1B9A)),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         onChanged: onChanged,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildHeightField() {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           SwitchListTile(
//             contentPadding: EdgeInsets.zero,
//             title: const Text('Enter Height in Centimeters'),
//             value: isHeightInCm,
//             activeColor: const Color(0xFF6A1B9A),
//             onChanged: (value) {
//               setState(() {
//                 isHeightInCm = value;
//               });
//             },
//           ),
//           const SizedBox(height: 8),
//           if (isHeightInCm)
//             _buildAnimatedTextField(
//               controller: _heightCmController,
//               labelText: 'Height (cm)',
//               icon: Icons.height,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter height in cm';
//                 }
//                 return null;
//               },
//             )
//           else
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAnimatedTextField(
//                     controller: _heightFeetController,
//                     labelText: 'Height (ft)',
//                     icon: Icons.height,
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter height in feet';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'qna_screen3.dart'; // Ensure this import is correct for your project

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

  bool isHeightInCm = false;
  late AnimationController _controller;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for the "Next" button
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Button scale animation
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MultipleChoiceQuestionScreen2()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Let\'s Know You Better',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Set text color to black
                  ),
                ),
                const SizedBox(height: 20),

                // Full Name Field
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Gender Dropdown
                _buildDropdown(
                  value: _selectedGender,
                  items: ['Male', 'Female', 'Other'],
                  labelText: 'Gender',
                  icon: Icons.wc,
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
                const SizedBox(height: 20),

                // Age Field
                _buildTextField(
                  controller: _ageController,
                  labelText: 'Age',
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Height Field
                _buildHeightField(),
                const SizedBox(height: 20),

                // Weight Field
                _buildTextField(
                  controller: _weightController,
                  labelText: 'Weight (kg)',
                  icon: Icons.fitness_center,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Alternative Phone Number Field
                _buildTextField(
                  labelText: 'Alternative Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _alternativePhoneNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isNotEmpty) {
                      return 'Please enter an alternative phone number';
                    }
                    return null;
                  },
                ),
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
          backgroundColor: Colors.black, // Set button color to black
          child: const Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light grey background for input fields
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black), // Set text color to black
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black54), // Set label color to black54
          prefixIcon: Icon(icon, color: Colors.black54), // Set icon color to black54
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String labelText,
    required IconData icon,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light grey background for dropdown
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
        dropdownColor: Colors.grey[200], // Light grey background for dropdown items
        style: const TextStyle(color: Colors.black), // Set text color to black
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black54), // Set label color to black54
          prefixIcon: Icon(icon, color: Colors.black54), // Set icon color to black54
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildHeightField() {
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Enter Height in Centimeters',
            style: TextStyle(color: Colors.black54), // Set text color to black54
          ),
          value: isHeightInCm,
          activeColor: Colors.black, // Set switch color to black
          onChanged: (value) {
            setState(() {
              isHeightInCm = value;
            });
          },
        ),
        const SizedBox(height: 8),
        if (isHeightInCm)
          _buildTextField(
            controller: _heightCmController,
            labelText: 'Height (cm)',
            icon: Icons.height,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter height in cm';
              }
              return null;
            },
          )
        else
          _buildTextField(
            controller: _heightFeetController,
            labelText: 'Height (ft)',
            icon: Icons.height,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter height in feet';
              }
              return null;
            },
          ),
      ],
    );
  }
}