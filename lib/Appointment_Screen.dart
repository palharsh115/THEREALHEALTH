import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime _selectedDate = DateTime.now();
  List<String> _timeSlots = [];
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
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
      '4:30 PM - 5:00PM'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Pastel colors
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            _buildCalendar(),
            const SizedBox(height: 20),
            const Text(
              'Available Time Slots',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
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
          selectedDecoration: const BoxDecoration(
            color: Colors.teal, // Selection color
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.teal[100], // Today's color
            shape: BoxShape.circle,
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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey[300]!,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10),
              ],
            ),
            child: Text(
              slot,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal, // Modern pastel green
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _selectedTimeSlot != null
            ? () {
                _showConfirmationDialog();
              }
            : null,
        child: const Text(
          'Confirm Appointment',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Appointment Confirmed', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
            'Your appointment is confirmed for\n\n'
            'Date: ${_selectedDate.toLocal().toShortDateString()}\n'
            'Time: $_selectedTimeSlot',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }
}

extension DateFormatExtension on DateTime {
  String toShortDateString() {
    return '$day/$month/$year';
  }
}
