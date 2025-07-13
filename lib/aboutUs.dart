import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  // 🔗 Reusable URL launcher
  Future<void> _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Section
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.teal.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://therealhealth.org/wp-content/uploads/2024/04/both-removebg-preview.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // About The Real Health Section
            _buildSectionTitle('About The Real Health'),
            const SizedBox(height: 10),
            _buildSectionText(
              'The Real Health is a comprehensive health and wellness platform dedicated to empowering individuals to lead healthier lives. We focus on personalized nutrition plans, mental wellness, and holistic health practices.',
            ),
            const SizedBox(height: 20),

            // Our Mission Section
            _buildSectionTitle('Our Mission'),
            const SizedBox(height: 10),
            _buildSectionText(
              'To inspire and empower individuals to take charge of their health through personalized, accessible, and sustainable solutions.',
            ),
            const SizedBox(height: 20),

            // Our Vision Section
            _buildSectionTitle('Our Vision'),
            const SizedBox(height: 10),
            _buildSectionText(
              'A world where health and wellness are not luxuries but essential rights for everyone.',
            ),
            const SizedBox(height: 20),

            // Meet the Founders Section
            _buildSectionTitle('Meet the Founders'),
            const SizedBox(height: 10),
            _buildFounderCard(
              imageUrl:
                  'https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-2-800x533.jpeg',
              name: 'Dr. Indupreet Kaur',
              role:
                  'Dentist, Nutrition Advisor & Lifestyle Transformation Expert',
            ),
            const SizedBox(height: 10),
            _buildFounderCard(
              imageUrl:
                  'https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-800x534.jpeg',
              name: 'Dr. Suchita Jaswal',
              role: 'Ayurvedic Physician & Naturopathy Expert',
            ),
            const SizedBox(height: 20),

            // Contact Us Section
            _buildSectionTitle('Contact Us'),
            const SizedBox(height: 10),
            _buildContactInfo(
              context: context,
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'therealhealth13@gmail.com',
              url:
                  'mailto:therealhealth13@gmail.com?subject=Support&body=Hello Team',
            ),
            _buildContactInfo(
              context: context,
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+91 9991162741, 90154 09707',
              url: 'tel:+919991162741',
            ),
            _buildContactInfo(
              context: context,
              icon: Icons.location_on,
              title: 'Visit Us',
              subtitle: 'HNo-3448, Sec 35D, Lane 2E, Chandigarh',
              url:
                  'https://www.google.com/maps/search/?api=1&query=HNo-3448%2C%20Sec%2035D%2C%20Lane%202E%2C%20Chandigarh',
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  // 🔹 Paragraph Text
  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Colors.grey.shade700,
      ),
    );
  }

  // 🔹 Founder Card
  Widget _buildFounderCard({
    required String imageUrl,
    required String name,
    required String role,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text(role),
      ),
    );
  }

  // 🔹 Clickable Contact Info
  Widget _buildContactInfo({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _launchURL(context, url),
        child: ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
