


// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AppointmentsScreen extends StatefulWidget {
//   const AppointmentsScreen({super.key});

//   @override
//   State<AppointmentsScreen> createState() => _AppointmentsScreenState();
// }

// class _AppointmentsScreenState extends State<AppointmentsScreen>
//     with SingleTickerProviderStateMixin {
//   DateTime _selectedDate = DateTime.now();
//   List<String> _timeSlots = [];
//   String? _selectedTimeSlot;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   bool _isLoading = false; // To handle loading state

//   @override
//   void initState() {
//     super.initState();
//     _generateTimeSlots();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _generateTimeSlots() {
//     _timeSlots = [
//       '9:00 AM - 9:30 AM',
//       '10:00 AM - 10:30 AM',
//       '11:00 AM - 11:30 AM',
//       '1:00 PM - 1:30 PM',
//       '2:00 PM - 2:30 PM',
//       '3:00 PM - 3:30 PM',
//       '4:00 PM - 4:30 PM',
//       '4:30 PM - 5:00 PM',
//     ];
//   }

//   Future<void> _bookAppointment() async {
//     if (_selectedTimeSlot == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a time slot")),
//       );
//       return;
//     }

//     final formattedDate =
//         "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}"; // ✅ YYYY-MM-DD format for backend

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:3000/book-appointment'), // Ensure correct backend URL
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'date': formattedDate,
//           'timeSlot': _selectedTimeSlot,
//         }),
//       );

//       if (response.statusCode == 200) {
//         _showConfirmationDialog();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: ${response.body}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Network Error: $e")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Text(
//             'Appointment Confirmed',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.teal,
//             ),
//           ),
//           content: Text(
//             'Your appointment is confirmed for\n\n'
//             'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}\n'
//             'Time: $_selectedTimeSlot',
//             style: const TextStyle(fontSize: 16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'OK',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Book Appointment',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCalendar(),
//             const SizedBox(height: 20),
//             _buildTimeSlots(),
//             const SizedBox(height: 30),
//             _buildConfirmButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalendar() {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       color: Colors.teal[50],
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: TableCalendar(
//           firstDay: DateTime.utc(2023, 1, 1),
//           lastDay: DateTime.utc(2030, 12, 31),
//           focusedDay: _selectedDate,
//           calendarFormat: CalendarFormat.month,
//           selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
//           onDaySelected: (selectedDay, focusedDay) {
//             setState(() {
//               _selectedDate = selectedDay;
//             });
//           },
//           calendarStyle: CalendarStyle(
//             selectedDecoration: BoxDecoration(
//               color: Colors.teal,
//               shape: BoxShape.circle,
//             ),
//             todayDecoration: BoxDecoration(
//               color: Colors.teal[100],
//               shape: BoxShape.circle,
//             ),
//           ),
//           headerStyle: const HeaderStyle(
//             formatButtonVisible: false,
//             titleCentered: true,
//             titleTextStyle: TextStyle(
//               color: Colors.teal,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeSlots() {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: _timeSlots.map((slot) {
//         final isSelected = _selectedTimeSlot == slot;
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedTimeSlot = slot;
//             });
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.teal : Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isSelected ? Colors.teal : Colors.grey[300]!,
//                 width: 1.5,
//               ),
//             ),
//             child: Text(
//               slot,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildConfirmButton() {
//     return Center(
//       child: _isLoading
//           ? const CircularProgressIndicator(color: Colors.teal)
//           : ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
//               ),
//               onPressed: _selectedTimeSlot != null ? _bookAppointment : null,
//               child: const Text(
//                 'Confirm Appointment',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  List<String> _timeSlots = [];
  String? _selectedTimeSlot;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateTimeSlots() {
    _timeSlots = [
      '9:00 AM - 9:30 AM',
      '10:00 AM - 10:30 AM',
      '11:00 AM - 11:30 AM',
      '1:00 PM - 1:30 PM',
      '2:00 PM - 2:30 PM',
      '3:00 PM - 3:30 PM',
      '4:00 PM - 4:30 PM',
      '4:30 PM - 5:00 PM',
    ];
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  Future<void> _bookAppointment() async {
    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a time slot")),
      );
      return;
    }

    String? token = await _getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication token not found!")),
      );
      return;
    }

    final formattedDate = "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/book-appointment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'date': formattedDate,
          'timeSlot': _selectedTimeSlot,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showConfirmationDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${data['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Appointment Confirmed',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          content: Text(
            'Your appointment is confirmed for\n\n'
            'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}\n'
            'Time: $_selectedTimeSlot',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildTimeSlots(),
            const SizedBox(height: 30),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.teal[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _selectedDate,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
            });
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.teal[100],
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _timeSlots.map((slot) {
        final isSelected = _selectedTimeSlot == slot;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeSlot = slot;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: Text(
              slot,
              style: TextStyle(fontSize: 16, color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: _selectedTimeSlot != null ? _bookAppointment : null,
        child: _isLoading ? CircularProgressIndicator() : Text("Confirm Appointment"),
      ),
    );
  }
}
