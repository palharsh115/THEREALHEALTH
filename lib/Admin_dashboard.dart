// File: Admin_dashboard.dart
// Description: This file contains the implementation of the Admin Dashboard screen in a Flutter application. It includes functionalities to fetch and display user statistics, appointments, and health data from a backend server.

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/base_url.dart'; // Import your base URL file here
import 'package:image_picker/image_picker.dart';

void main() => runApp(AdminDashboardApp());

class AdminDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: AdminDashboardScreen(),
    );
  }
}

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String? _token;
  int totalUsers = 0, totalAppointments = 0, totalHealthRecords = 0;
  List users = [], appointments = [], healthData = [], blogs = [];

  final TextEditingController _blogTitleController = TextEditingController();
  final TextEditingController _blogContentController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
    });
    print("Admin Token: $_token"); // Debugging
    if (_token != null) {
      fetchDashboardData(); // Fetch data if the token is valid
    } else {
      print("❌ Token is null. Ensure it is saved during login.");
    }
  }

  Future<void> fetchDashboardData() async {
    await fetchUsers();
    await fetchAppointments();
    await fetchHealthData();
    await fetchStats();
    await fetchBlogs();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/admin/users"), // Backend endpoint
      headers: {
        'Authorization': 'Bearer $_token', // Send the token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      // Parse the response and update the users list
      setState(() {
        users = json.decode(response.body);
      });
      print("✅ Users fetched successfully: $users");
    } else {
      // Handle errors
      print("❌ Error fetching users: ${response.statusCode}");
      print("Response Body: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching users: ${response.statusCode}")),
      );
    }
  }

  Future<void> fetchAppointments() async {
    var response = await _fetchData('/api/admin/appointments');
    if (response != null) setState(() => appointments = response);
  }

  Future<void> fetchHealthData() async {
    var response = await _fetchData('/api/admin/health-data');
    if (response != null) setState(() => healthData = response);
  }

  Future<void> fetchStats() async {
    var response = await _fetchData('/api/admin/stats');
    if (response != null) {
      setState(() {
        totalUsers = response['totalUsers'] ?? 0;
        totalAppointments = response['totalAppointments'] ?? 0;
        totalHealthRecords = response['totalHealthRecords'] ?? 0;
      });
    }
  }

  Future<void> fetchBlogs() async {
    var response = await _fetchData('/api/admin/blogs');
    if (response != null) setState(() => blogs = response);
  }

  Future<dynamic> _fetchData(String endpoint) async {
    if (_token == null) return null;
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'), // Use the endpoint parameter
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error fetching $endpoint: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return null;
    }
  }

  Future<void> createUser(String id, String name, String role) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/admin/users"),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "_id": id,
        "name": name,
        "role": role,
      }),
    );

    if (response.statusCode == 201) {
      fetchUsers(); // Refresh the user list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User created successfully!")),
      );
    } else {
      print("❌ Error creating user: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating user: ${response.statusCode}")),
      );
    }
  }

  Future<void> updateUser(String id, String name, String role) async {
    final response = await http.put(
      Uri.parse("$baseUrl/api/admin/users/$id"),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "_id": id,
        "name": name,
        "role": role,
      }),
    );

    if (response.statusCode == 200) {
      fetchUsers(); // Refresh the user list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User updated successfully!")),
      );
    } else {
      print("❌ Error updating user: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating user: ${response.statusCode}")),
      );
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/api/admin/users/$id"),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      fetchUsers(); // Refresh the user list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User deleted successfully!")),
      );
    } else {
      print("❌ Error deleting user: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting user: ${response.statusCode}")),
      );
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _showEditUserDialog(String id, String name, String role) {
    final TextEditingController idController = TextEditingController(text: id);
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController roleController = TextEditingController(text: role);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id.isEmpty ? "Create User" : "Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Phone Number Field (Used as User ID)
              TextField(
                controller: idController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number (User ID)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Name Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Role Field
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role (user/admin)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (id.isEmpty) {
                  // Create user with phone number as ID
                  createUser(
                    idController.text, // Use phone number as User ID
                    nameController.text,
                    roleController.text,
                  );
                } else {
                  // Update user
                  updateUser(idController.text, nameController.text, roleController.text);
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateAppointmentStatus(String appointmentId, String status, int index) async {
    final response = await http.put(
      Uri.parse("$baseUrl/api/admin/appointments/$appointmentId"),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "status": status,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        // Update the status of the specific appointment in the local list
        appointments[index]['status'] = status;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment status updated to $status!")),
      );
    } else {
      print("❌ Error updating appointment: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating appointment: ${response.statusCode}")),
      );
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> postBlog() async {
    final title = _blogTitleController.text.trim();
    final content = _blogContentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and content cannot be empty")),
      );
      return;
    }

    try {
      // Prepare the request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/blogs/admin/blogs"),
      );
       // Add the Authorization header with the token
    if (_token != null) {
      request.headers['Authorization'] = 'Bearer $_token';
    }

      // Add blog title and content
      request.fields['title'] = title;
      request.fields['content'] = content;

      // Add the image file if selected
      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // Backend field name for the image
            _selectedImage!.path,
          ),
        );
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 201) {
        setState(() {
          _blogTitleController.clear();
          _blogContentController.clear();
          _selectedImage = null;
        });
        fetchBlogs(); // Refresh the blog list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blog posted successfully!")),
        );
      } else {
        print("❌ Error posting blog: ${response.statusCode}");
        print("Response body: ${await response.stream.bytesToString()}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error posting blog: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("❌ Exception posting blog: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred while posting the blog")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _token == null
          ? const Center(child: CircularProgressIndicator()) // Show loader if token is not loaded
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dashboard Statistics Section
                    Text(
                      "Dashboard Statistics",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          "Total Users",
                          totalUsers,
                          Colors.teal,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListScreen(
                                  title: "Users",
                                  data: users,
                                  icon: Icons.person,
                                ),
                              ),
                            );
                          },
                        ),
                        _buildStatCard(
                          "Appointments",
                          totalAppointments,
                          Colors.blue,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListScreen(
                                  title: "Appointments",
                                  data: appointments,
                                  icon: Icons.calendar_today,
                                ),
                              ),
                            );
                          },
                        ),
                        _buildStatCard(
                          "Health Records",
                          totalHealthRecords,
                          Colors.orange,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListScreen(
                                  title: "Health Records",
                                  data: healthData,
                                  icon: Icons.health_and_safety,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Appointments Section
                    Text(
                      "Appointments",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    appointments.isEmpty
                        ? const Center(
                            child: Text(
                              "No Appointments Found",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              final appointment = appointments[index];
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: const Icon(Icons.calendar_today, color: Colors.teal),
                                  title: Text("Name: ${appointment['userName'] ?? 'Unknown'}"),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("ID: ${appointment['_id'] ?? 'N/A'}"),
                                      Text("Date: ${appointment['date']}"),
                                      Text("Time Slot: ${appointment['timeSlot']}"),
                                    ],
                                  ),
                                  trailing: appointment['status'] == "pending"
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Approve Button
                                            IconButton(
                                              icon: const Icon(Icons.check_circle, color: Colors.green),
                                              onPressed: () {
                                                _updateAppointmentStatus(appointment['_id'], "approved", index);
                                              },
                                            ),
                                            // Cancel Button
                                            IconButton(
                                              icon: const Icon(Icons.cancel, color: Colors.red),
                                              onPressed: () {
                                                _updateAppointmentStatus(appointment['_id'], "canceled", index);
                                              },
                                            ),
                                          ],
                                        )
                                      : Text(
                                          "Status: ${appointment['status']}",
                                          style: TextStyle(
                                            color: appointment['status'] == "approved" ? Colors.green : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 24),

                    // Users Section
                    Text(
                      "Users",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    users.isEmpty
                        ? const Center(
                            child: Text(
                              "No Users Found",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: const Icon(Icons.person, color: Colors.teal),
                                  title: Text(user['name'] ?? 'No Name'),
                                  subtitle: Text("Phone: ${user['_id']}"),
                                  onTap: () {
                                    print("User Data: ${user}"); // Debugging: Print the user data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailsScreen(user: user),
                                      ),
                                    );
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () {
                                          // Open a dialog to edit user details
                                          _showEditUserDialog(user['_id'], user['name'], user['role']);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          deleteUser(user['_id']); // Call delete method
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                    const SizedBox(height: 24),

                    // Blog Posting Section
                    Text(
                      "Post a Blog",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _blogTitleController,
                              decoration: const InputDecoration(
                                labelText: "Blog Title",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _blogContentController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                labelText: "Blog Content",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_selectedImage != null)
                              Column(
                                children: [
                                  Image.file(
                                    _selectedImage!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ElevatedButton.icon(
                              onPressed: pickImage,
                              icon: const Icon(Icons.image),
                              label: const Text("Pick Image"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: postBlog,
                              icon: const Icon(Icons.post_add),
                              label: const Text("Post Blog"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditUserDialog("", "", "user"); // Open dialog for creating a new user
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // Updated _buildStatCard Method
  Widget _buildStatCard(String title, int value, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Handle tap
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Center(child: Text('Login Screen - Implement Here')),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final Map user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name'] ?? 'User Details'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Details Section
            _buildSectionCard(
              context,
              title: "User Details",
              icon: Icons.person,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("User ID", user['_id'] ?? 'N/A'),
                  _buildDetailRow("Name", user['name'] ?? 'N/A'),
                  _buildDetailRow("Age", user['age']?.toString() ?? 'N/A'),
                  _buildDetailRow("Gender", user['gender'] ?? 'N/A'),
                  _buildDetailRow("Height", "${user['height']?['value'] ?? 'N/A'} cm"),
                  _buildDetailRow("Weight", "${user['weight'] ?? 'N/A'} kg"),
                  _buildDetailRow("Alternative Phone", user['alternativePhoneNumber'] ?? 'N/A'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Appointments Section
            _buildSectionCard(
              context,
              title: "Appointments",
              icon: Icons.calendar_today,
              content: user['appointments'] != null && user['appointments'].isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: user['appointments'].length,
                      itemBuilder: (context, index) {
                        final appointment = user['appointments'][index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.event, color: Colors.teal),
                            title: Text("Date: ${appointment['date']}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Time Slot: ${appointment['timeSlot']}"),
                                Text(
                                  "Status: ${appointment['status']}",
                                  style: TextStyle(
                                    color: appointment['status'] == "approved"
                                        ? Colors.green
                                        : appointment['status'] == "canceled"
                                            ? Colors.red
                                            : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Text(
                      "No Appointments Found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 16),

            // Health Conditions Section
            _buildSectionCard(
              context,
              title: "Health Conditions",
              icon: Icons.health_and_safety,
              content: user['healthConditions'] != null && user['healthConditions'].isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: user['healthConditions'].length,
                      itemBuilder: (context, index) {
                        final condition = user['healthConditions'][index];
                        return ListTile(
                          leading: const Icon(Icons.local_hospital, color: Colors.teal),
                          title: Text(condition['conditionName']),
                          subtitle: Text("Details: ${condition['details'] ?? 'N/A'}"),
                        );
                      },
                    )
                  : const Text(
                      "No Health Conditions Found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method to Build a Section Card
  Widget _buildSectionCard(BuildContext context, {required String title, required IconData icon, required Widget content}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  // Helper Method to Build a Detail Row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  final String title;
  final List data;
  final IconData icon;

  ListScreen({required this.title, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: data.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(icon, color: Colors.teal),
                    title: Text(
                      title == "Appointments"
                          ? "Name: ${item['userName'] ?? 'Unknown'}"
                          : item['name'] ?? "No Name",
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title == "Users") Text("Phone: ${item['_id']}"),
                        if (title == "Appointments") ...[
                          Text("ID: ${item['_id'] ?? 'N/A'}"),
                          Text("Date: ${item['date']}"),
                          Text("Time Slot: ${item['timeSlot']}"),
                          Text(
                            "Status: ${item['status']}",
                            style: TextStyle(
                              color: item['status'] == "approved"
                                  ? Colors.green
                                  : item['status'] == "canceled"
                                      ? Colors.red
                                      : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        if (title == "Health Records") Text("Condition: ${item['conditionName']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
