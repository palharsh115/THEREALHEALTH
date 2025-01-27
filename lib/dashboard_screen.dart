import 'package:flutter/material.dart';
import 'package:flutter_application_3/Appointment_Screen.dart';
import 'package:flutter_application_3/Blog%20_Screen.dart';
import 'package:flutter_application_3/Settings_Screen.dart';
import 'package:flutter_application_3/Shop_screen.dart';
import 'package:flutter_application_3/aboutUs.dart';

// Import your new screen


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DashboardScreen(),
      
    );
  }
}

// Dashboard Screen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('The Real Health'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 145, 221, 207), // Change to a pastel light blue
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3A3B3C), // Neutral dark color for contrast
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 58, 60, 58)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
      ],
      iconTheme: const IconThemeData(color: Color(0xFF3A3B3C)), // Sidebar icon color
    ),
      drawer: _buildSidebar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            
            _buildFeaturesSection(context),
             _buildServicesSection(context),    
             _buildExpertiseSection(context),
            _buildNutritionTipsSection(context),
            _buildContactUsSection(context),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatSupportScreen()),
          );
        },
        label: const Text('Support'),
        icon: const Icon(Icons.chat),
        backgroundColor: const Color.fromARGB(255, 229, 232, 229),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Vikul Tyagi'),
            accountEmail: Text('0123456789'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255,243,158,96)),
          ),
          _buildDrawerItem(context, Icons.home, 'Home', const DashboardScreen()),
          _buildDrawerItem(context, Icons.health_and_safety, 'Health programs', const HealthProgramsScreen()),
          _buildDrawerItem(context, Icons.calendar_today, 'Appointments', const AppointmentsScreen()),
          _buildDrawerItem(context, Icons.shopping_cart, 'Shop', const ShopScreen()),
          _buildDrawerItem(context, Icons.article, 'Blogs', const BlogScreen()),
          const Divider(),
          _buildDrawerItem(context, Icons.settings, 'Settings', const SettingsScreen()),
          _buildDrawerItem(context, Icons.logout, 'Logout', null),


        ],
      ),
    );
  }

  

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, Widget? destination) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 21, 136, 25)), 
      title: Text(title),
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }

Widget _buildHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFE8F9FD), // Pastel Light Blue
          Color(0xFFFFE7C9), // Pastel Peach
          // Pastel Pink
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Row(
      children: [
        CircleAvatar(
          radius: 37,
          backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/p/AF1QipPpt8BI4I0v7NhP19OaNkAruI7jrBQi4NJhoSU=s1360-w1360-h1020'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A3B3C), // Neutral for contrast
              ),
            ),
            Text(
              'Stay healthy with Real Health.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255,255, 178, 111),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Features',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildFeatureTile(context, 'PRAKRITI PARIKSHA', Icons.save_as, Colors.blueAccent),
              _buildFeatureTile(context, 'Nutrition Plans', Icons.restaurant, Colors.orange),
              _buildFeatureTile(context, 'Wellness Programs & Exercise Routines', Icons.self_improvement, Colors.purple),
              _buildFeatureTile(context, 'Consultations', Icons.medical_services, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective feature screen
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Services',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.spa, color: Colors.green),
            title: const Text('Mental Wellness Programs'),
            subtitle: const Text('Tailored plans for your mental health.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WellnessScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.food_bank, color: Colors.orange),
            title: const Text('Healthy Eating Guides'),
            subtitle: const Text('Nutrition-focused eating plans.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NutritionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseSection(BuildContext context) {
    final List<Map<String, dynamic>> expertiseItems = [
      {
        'title': 'Diabetes & Pre Diabetes',
        'imageUrl': 'https://etimg.etb2bimg.com/thumb/msid-105205469,imgsize-15434,width-1200,height=765,overlay-ethealth/industry/early-detection-of-pre-diabetes-to-prevent-diabetes-need-of-the-hour.jpg',
        'screen': const DiabetesScreen(),
      },
      {
        'title': 'Heart Disease',
        'imageUrl': 'https://bpincontrol.in/wp-content/uploads/2023/08/Heart-Disease.jpg',
        'screen': const HeartDiseaseScreen(),
      },
      {
        'title': 'Weight Management',
        'imageUrl': 'https://www.health.com/thmb/z8T-vu1AVZ9flwXK9P15kcRmr6c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Health-GettyImages-FoodsForWeightLoss-35e70ba668eb4d9783e89e93cabf55a9.jpg',
        'screen': const WeightManagementScreen(),
      },
      {
        'title': 'PCOD and Gynae Problems',
        'imageUrl': 'https://therealhealth.org/wp-content/uploads/2024/04/pcod-p-200x200.png',
        'screen': const PcodScreen(),
      },
      {
        'title': 'Kids Immunity & Nutrition',
        'imageUrl': 'https://therealhealth.org/wp-content/uploads/2024/04/child-diet-200x200.png',
        'screen': const KidsNutritionScreen(),
      },
      {
        'title': 'Nutrition for Cancer Patient',
        'imageUrl': 'https://therealhealth.org/wp-content/uploads/2024/04/can-diet-200x200.png',
        'screen': const CancerNutritionScreen(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Expertise',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: expertiseItems.length,
            itemBuilder: (context, index) {
              final item = expertiseItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item['screen']),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(item['imageUrl']),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Individual Screens
class DiabetesScreen extends StatelessWidget {
  const DiabetesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diabetes & Pre Diabetes')),
      body: const Center(child: Text('Information about Diabetes & Pre Diabetes')),
    );
  }
}

class HeartDiseaseScreen extends StatelessWidget {
  const HeartDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heart Disease')),
      body: const Center(child: Text('Information about Heart Disease')),
    );
  }
}

class WeightManagementScreen extends StatelessWidget {
  const WeightManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weight Management')),
      body: const Center(child: Text('Information about Weight Management')),
    );
  }
}

class PcodScreen extends StatelessWidget {
  const PcodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PCOD and Gynae Problems')),
      body: const Center(child: Text('Information about PCOD and Gynae Problems')),
    );
  }
}

class KidsNutritionScreen extends StatelessWidget {
  const KidsNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kids Immunity & Nutrition')),
      body: const Center(child: Text('Information about Kids Immunity & Nutrition')),
    );
  }
}

class CancerNutritionScreen extends StatelessWidget {
  const CancerNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition for Cancer Patient')),
      body: const Center(child: Text('Information about Nutrition for Cancer Patient')),
    );
  }
}

  Widget _buildNutritionTipsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Nutrition Tips',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(Icons.local_dining, color: Colors.green),
                  title: Text('Tip #$index: Eat More Greens'),
                  subtitle: const Text('Include green vegetables in your meals daily.'),
                ),
              );
            },
          ),
        ],  
      ),
    );
  }

  Widget _buildContactUsSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.email, color: Colors.green),
            title: Text('Email Us'),
            subtitle: Text('support@therealhealth.org'),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.green),
            title: Text('Call Us'),
            subtitle: Text('+1 234 567 890'),
          ),
        ],
      ),
    );
  }
  

// Modify the BottomNavigationBar with onTap handling
Widget _buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    currentIndex: 0, // Default index
    onTap: (index) {
      // Navigate based on the selected index
      switch (index) {
        case 0: // Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
          break;
        case 1: // Tips
          // Handle navigation to tips or any other screen
          break;
        case 2: // Support - Navigate to ChatSupportScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
          break;
        case 3: // Contact - Navigate to Contact Screen
          // Handle contact screen navigation
          break;
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Tips'),
      BottomNavigationBarItem(icon: Icon(Icons.support), label: 'About Us'),
      BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: 'Contact'),
    ],
  );
}

  

// Additional Screens
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('No new notifications')),
    );
  }
}

class ChatSupportScreen extends StatelessWidget {
  const ChatSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Support')),
      body: const Center(child: Text('Live Chat Coming Soon')),
    );
  }
}



class HealthProgramsScreen extends StatelessWidget {
  const HealthProgramsScreen({super.key});

  final List<Map<String, String>> programs = const [
    {
      "title": "Diabetes & Pre Diabetes",
      "content": "Learn how to manage and prevent diabetes with expert advice.",
      "imageUrl": "https://milehighspine.com/wp-content/uploads/Diabetes101A.jpg",
    },
    {
      "title": "Heart Diseases",
      "content": "Explore tips and programs for a healthy heart.",
      "imageUrl": "data:image/svg+xml,%3Csvg%20xmlns%3D%27http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%27%20width%3D%27626%27%20height%3D%27417%27%20viewBox%3D%270%200%20626%20417%27%3E%3Crect%20width%3D%27626%27%20height%3D%27417%27%20fill-opacity%3D%220%22%2F%3E%3C%2Fsvg%3E",
    },
    {
      "title": "Weight Management",
      "content": "Achieve your ideal weight with our comprehensive guidance.",
      "imageUrl": "data:image/svg+xml,%3Csvg%20xmlns%3D%27http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%27%20width%3D%271380%27%20height%3D%27920%27%20viewBox%3D%270%200%201380%20920%27%3E%3Crect%20width%3D%271380%27%20height%3D%27920%27%20fill-opacity%3D%220%22%2F%3E%3C%2Fsvg%3E",
    },
    {
      "title": "Gynae & PCOD",
      "content": "Specialized programs for women's health and PCOD management.",
      "imageUrl": "https://example.com/images/gynae.png",
    },
    {
      "title": "Kids Immunity & Nutrition",
      "content": "Boost your kids' immunity with tailored nutrition plans.",
      "imageUrl": "https://example.com/images/kids.png",
    },
    {
      "title": "Stress Management",
      "content": "Reduce stress with our holistic management programs.",
      "imageUrl": "https://example.com/images/stress.png",
    },
    {
      "title": "Nutrition for Cancer Patients",
      "content": "Nutrition advice tailored for cancer patients.",
      "imageUrl": "https://example.com/images/cancer.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Programs'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: programs.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        programs[index]['imageUrl']!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                            height: 60,
                            width: 60,
                            child: Center(child: CircularProgressIndicator()),
                          ); 
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 60,
                            width: 60,
                            child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            programs[index]['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            programs[index]['content']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wellness Programs')),
      body: const Center(child: Text('Details about Wellness Programs')),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Healthy Eating')),
      body: const Center(child: Text('Details about Healthy Eating Plans')),
    );
  }
}

class SuccessStoryScreen extends StatelessWidget {
  const SuccessStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success Story')),
      body: const Center(child: Text('Detailed Success Story')),
    );
  }
}


