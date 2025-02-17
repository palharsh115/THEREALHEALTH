import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProSectionScreen extends StatelessWidget {
  const ProSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            _buildHeaderSection(),
            const SizedBox(height: 50),
            _buildChatButton(),
            const SizedBox(height: 50),
            _buildPlansSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      children: [
        Text(
          'GET PREMIUM TODAY!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Subscribe today to gain unlimited access.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildChatButton() {
    return GestureDetector(
      onTap: _launchURL,
      child: ElevatedButton.icon(
        onPressed: _launchURL,
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text(
          'Chat on WhatsApp',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    const String phoneNumber = "919917668808"; // Organization's WhatsApp number
    final String message = Uri.encodeComponent("Hello, I need support");
    final String url = "https://wa.me/$phoneNumber?text=$message";

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildPlansSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Your Plan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlanCard('Weight Management', Icons.local_fire_department),
              _buildPlanCard('Disease Management', Icons.health_and_safety),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String title, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.teal[700]),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}