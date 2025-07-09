import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/base_url.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  List<dynamic> consultations = [];
  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchConsultations();
  }

  Future<void> _fetchConsultations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print("All keys in SharedPreferences: ${prefs.getKeys()}");
      final userId = prefs.getString('user_id');
      final token = prefs.getString('auth_token');
      print("Fetched userId: $userId");
      print("Fetched token: $token");

      if (userId == null || token == null) {
        throw Exception("User ID or token not found in SharedPreferences.");
      }

      final url = '$baseUrl/api/user/consultation/$userId';
      print("Fetching consultations from: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("Consultation response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          if (decoded is List) {
            consultations = decoded;
          } else if (decoded is Map) {
            consultations = [decoded];
          } else {
            consultations = [];
          }
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load consultations: ${response.body}");
      }
    } catch (e) {
      print("Error fetching consultations: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultations'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : consultations.isEmpty
              ? const Center(child: Text('No consultations found.'))
              : ListView.builder(
                  itemCount: consultations.length,
                  itemBuilder: (context, index) {
                    final consultation = consultations[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Show user name and phone number
                            Text(
                              "User: ${consultation['userName'] ?? 'Unknown'} (${consultation['userPhone'] ?? ''})",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Date: ${DateTime.parse(consultation['date']).toLocal()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text("Notes: ${consultation['notes']}"),
                            const SizedBox(height: 8),
                            const Text("Prescription:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ...List<Widget>.from(consultation['prescription']
                                .map((prescription) {
                              return Text(
                                "- ${prescription['medicineName']} (${prescription['dosage']} for ${prescription['duration']})",
                              );
                            })),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
