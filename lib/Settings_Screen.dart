import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text('Profile'),
            subtitle: Text('Manage your profile and personal information'),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.green),
            title: Text('Notifications'),
            subtitle: Text('Manage notification preferences'),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.green),
            title: Text('Privacy'),
            subtitle: Text('Manage privacy settings'),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.green),
            title: Text('About Us'),
            subtitle: Text('Learn more about The Real Health'),
          ),
        ],
      ),
    );
  }
}
