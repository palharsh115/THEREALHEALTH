import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.teal,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://therealhealth.org/wp-content/uploads/2024/04/both-removebg-preview.png',  // Replace with the logo URL
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              'About The Real Health',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The Real Health is a comprehensive health and wellness platform dedicated to empowering individuals to lead healthier lives. We focus on personalized nutrition plans, mental wellness, and holistic health practices.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'To inspire and empower individuals to take charge of their health through personalized, accessible, and sustainable solutions.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A world where health and wellness are not luxuries but essential rights for everyone.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Meet the Founders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage('https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-2-800x533.jpeg'), // Replace with Dr. Indupreet Kaur's image
              ),
              title: Text('Dr. Indupreet Kaur'),
              subtitle: Text('Dentist, Nutrition Advisor & Lifestyle Transformation Expert'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage('https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-800x534.jpeg'), // Replace with Dr. Suchita Jaswal's image
              ),
              title: Text('Dr. Suchita Jaswal'),
              subtitle: Text('Ayurvedic Physician & Naturopathy Expert'),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.teal),
              title: Text('Email Us'),
              subtitle: Text('info@therealhealth.org'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.teal),
              title: Text('Call Us'),
              subtitle: Text('+91 9991162741, 90154 09707'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.teal),
              title: Text('Visit Us'),
              subtitle: Text('HNo-3448, Sec 35D, Lane 2E, Chandigarh'),
            ),
          ],
        ),
      ),
    );
  }
}
