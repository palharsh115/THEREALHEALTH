// import 'package:flutter/material.dart';

// class AboutUsScreen extends StatelessWidget {
//   const AboutUsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Us'),
//         backgroundColor: Colors.teal,
//       ),
//       body: const SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 70,
//                 backgroundImage: NetworkImage(
//                   'https://therealhealth.org/wp-content/uploads/2024/04/both-removebg-preview.png',  // Replace with the logo URL
//                 ),
//               ),
//             ),
//             SizedBox(height: 25),
//             Text(
//               'About The Real Health',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'The Real Health is a comprehensive health and wellness platform dedicated to empowering individuals to lead healthier lives. We focus on personalized nutrition plans, mental wellness, and holistic health practices.',
//               style: TextStyle(fontSize: 16, height: 1.5),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Our Mission',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'To inspire and empower individuals to take charge of their health through personalized, accessible, and sustainable solutions.',
//               style: TextStyle(fontSize: 16, height: 1.5),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Our Vision',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'A world where health and wellness are not luxuries but essential rights for everyone.',
//               style: TextStyle(fontSize: 16, height: 1.5),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Meet the Founders',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//             SizedBox(height: 10),
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 26,
//                 backgroundImage: NetworkImage('https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-2-800x533.jpeg'), // Replace with Dr. Indupreet Kaur's image
//               ),
//               title: Text('Dr. Indupreet Kaur'),
//               subtitle: Text('Dentist, Nutrition Advisor & Lifestyle Transformation Expert'),
//             ),
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 26,
//                 backgroundImage: NetworkImage('https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-800x534.jpeg'), // Replace with Dr. Suchita Jaswal's image
//               ),
//               title: Text('Dr. Suchita Jaswal'),
//               subtitle: Text('Ayurvedic Physician & Naturopathy Expert'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Contact Us',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//             SizedBox(height: 10),
//             ListTile(
//               leading: Icon(Icons.email, color: Colors.teal),
//               title: Text('Email Us'),
//               subtitle: Text('info@therealhealth.org'),
//             ),
//             ListTile(
//               leading: Icon(Icons.phone, color: Colors.teal),
//               title: Text('Call Us'),
//               subtitle: Text('+91 9991162741, 90154 09707'),
//             ),
//             ListTile(
//               leading: Icon(Icons.location_on, color: Colors.teal),
//               title: Text('Visit Us'),
//               subtitle: Text('HNo-3448, Sec 35D, Lane 2E, Chandigarh'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
              imageUrl: 'https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-2-800x533.jpeg',
              name: 'Dr. Indupreet Kaur',
              role: 'Dentist, Nutrition Advisor & Lifestyle Transformation Expert',
            ),
            const SizedBox(height: 10),
            _buildFounderCard(
              imageUrl: 'https://therealhealth.org/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-26-at-3.16.39-PM-800x534.jpeg',
              name: 'Dr. Suchita Jaswal',
              role: 'Ayurvedic Physician & Naturopathy Expert',
            ),
            const SizedBox(height: 20),

            // Contact Us Section
            _buildSectionTitle('Contact Us'),
            const SizedBox(height: 10),
            _buildContactInfo(
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'info@therealhealth.org',
            ),
            _buildContactInfo(
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+91 9991162741, 90154 09707',
            ),
            _buildContactInfo(
              icon: Icons.location_on,
              title: 'Visit Us',
              subtitle: 'HNo-3448, Sec 35D, Lane 2E, Chandigarh',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build section titles
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

  // Helper method to build section text
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

  // Helper method to build founder cards
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

  // Helper method to build contact info
  Widget _buildContactInfo({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
    );
  }
}