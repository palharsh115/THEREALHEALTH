import 'package:flutter/material.dart';
import 'package:flutter_application_3/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 42, 131, 36),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Information
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile Information'),
            subtitle: const Text('Manage your profile details'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileInformationScreen()),
              );
            },
          ),
          const Divider(),

          // Privacy & Security
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.black),
            title: const Text('Privacy & Security'),
            subtitle: const Text('Manage your privacy settings'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
              );
            },
          ),
          const Divider(),

          // App Settings
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black),
            title: const Text('App Settings'),
            subtitle: const Text('Customize your app experience'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppSettingsScreen()),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// Profile Information Screen
class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _userId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("Retrieved Token: $token");
    return token;
  }

  Future<void> _loadUserDetails() async {
    setState(() => _isLoading = true);
    try {
      String? token = await _getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token not found')),
        );
        return;
      }

      final url = '$baseUrl/api/user/user/details';
      print("Request URL: $url");
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['user'];

        // Save user ID and token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user['_id']);
        await prefs.setString('auth_token', token);

        setState(() {
          _userId = user['_id'];
          _nameController.text = user['name'] ?? '';
          _ageController.text = user['age']?.toString() ?? '';
          _weightController.text = user['weight']?.toString() ?? '';
          _heightController.text = user['height']?.toString() ?? '';
        });

        print("User ID: $_userId");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User details loaded')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user details: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error fetching user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching user details')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateUserDetails() async {
    setState(() => _isLoading = true);
    try {
      String? token = await _getToken();
      if (token == null || _userId == null) {
        print("Error: Authentication token or user ID not found.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token or user ID not found')),
        );
        return;
      }

      final url = '$baseUrl/api/user/user/update/$_userId';
      final userData = {
        'name': _nameController.text,
        'age': int.tryParse(_ageController.text),
        'weight': double.tryParse(_weightController.text),
        'height': double.tryParse(_heightController.text),
      };

      print("Request URL: $url");
      print("Request Headers: {Authorization: Bearer $token, Content-Type: application/json}");
      print("Request Body: ${json.encode(userData)}");

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("User details updated successfully: ${data['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Profile updated successfully')),
        );
      } else {
        print("Failed to update user details: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      print('Error updating user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating user details')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
        backgroundColor: const Color.fromRGBO(81, 132, 53, 1),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _updateUserDetails,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadUserDetails,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Reload', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

// Privacy & Security Screen
class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  _PrivacySecurityScreenState createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _isLoading = false;

  Future<void> _manageDataSharing(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isDataSharingEnabled = prefs.getBool('data_sharing') ?? true;
      isDataSharingEnabled = !isDataSharingEnabled;
      await prefs.setBool('data_sharing', isDataSharingEnabled);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isDataSharingEnabled
                ? 'Data sharing enabled'
                : 'Data sharing disabled',
          ),
        ),
      );
    } catch (e) {
      print('Error managing data sharing: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update data sharing preference')),
      );
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userId = prefs.getString('user_id');

      if (token == null || userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token or user ID not found')),
        );
        return;
      }

      final url = '$baseUrl/api/user/user/delete/$userId';
      print("Request URL: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
        await prefs.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        print("❌ Error deleting account: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error deleting account: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error deleting account')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _viewTermsAndPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TermsAndPrivacyPolicyScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: const Color.fromARGB(255, 49, 125, 50),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Manage Data Sharing'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _manageDataSharing(context),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Delete My Account'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _deleteAccount(context),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Terms and Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _viewTermsAndPrivacyPolicy(context),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

// App Settings Screen
class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: const Color.fromRGBO(61, 128, 48, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: false,
              onChanged: (value) {
                // Handle Dark Mode toggle
              },
            ),
            const Divider(),
            const ListTile(
              title: Text('App Version'),
              subtitle: Text('1.0.0'),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsAndPrivacyPolicyScreen extends StatelessWidget {
  const TermsAndPrivacyPolicyScreen({super.key});
  
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Privacy Policy'),
        backgroundColor: const Color.fromARGB(255, 55, 155, 73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Privacy Policy',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last updated: May 12, 2025',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Terms Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. By using this app, you agree to our terms of service.\n'
                    '2. You are responsible for maintaining the confidentiality of your account.\n'
                    '3. Misuse of the app may result in account suspension or termination.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Privacy Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Your data will be handled securely and responsibly.\n'
                    '2. We do not share your personal information without your consent.\n'
                    '3. You can delete your account at any time.\n'
                    '4. For more details, contact info@therealhealth.org',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contact Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'If you have any questions or concerns, feel free to reach out to us at:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email: info@therealhealth.org',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _launchURL('https://therealhealth.org/'),
                    child: const Text(
                      'Visit our website: www.therealhealth.org',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
