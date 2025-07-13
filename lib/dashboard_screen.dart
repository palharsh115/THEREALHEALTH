import 'dart:convert'; // For JSON decoding
import 'package:flutter_application_3/CancerNutritionScreen%20.dart';
import 'package:flutter_application_3/CardioScreen.dart';
import 'package:flutter_application_3/FemaleHealthScreen.dart';
import 'package:flutter_application_3/KidsImmunityNutritionScreen.dart';
import 'package:flutter_application_3/StressManagementScreen.dart';
import 'package:flutter_application_3/WeightManagementScreen%20.dart';
import 'package:flutter_application_3/base_url.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Appointment_Screen.dart';
import 'package:flutter_application_3/Settings_Screen.dart';
import 'package:flutter_application_3/Shop_screen.dart';
import 'package:flutter_application_3/aboutUs.dart';
// ignore: unused_import
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_3/Prosection_screen.dart';
import 'Explore_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'package:flutter_application_3/base_url.dart';
import 'package:flutter_application_3/consultation_screen.dart';
import 'package:flutter_application_3/Blog _Screen.dart';
import 'package:flutter_application_3/DiabetesScreen.dart';

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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  // Fetch user details
  Future<void> _fetchUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    if (token == null) {
      print("No auth token found");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            "$baseUrl/api/user/user/details"), // Replace with your backend URL
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data["user"]["name"];
        });
        print("User name fetched: $userName");
      } else {
        print("Failed to fetch user details: ${response.body}");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Real Health'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 221, 207),
      ),
      drawer: const Sidebar(), // Add the Sidebar here
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, userName),
            const SizedBox(height: 4),
            _buildAdSlider(),
            const SizedBox(height: 10),
            _buildFeaturesSection(context),
            _buildServicesSection(context),
            _buildExpertiseSection(context),
            _buildNutritionTipsSection(context),
            buildContactUsSection(context), // Add Contact Us section
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // Add this line
    );
  }

  Widget _buildHeader(BuildContext context, String? userName) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.teal, Colors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 0),
          const SizedBox(width: 19),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName != null ? 'Welcome  $userName!' : 'Welcome back!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Stay healthy with Real Health.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdSlider() {
    final List<Map<String, String>> adData = [
      {
        'image': 'assets/images/heart.jpg',
        'url': 'https://example.com/diabetes'
      },
      {'image': 'assets/images/kids.jpg', 'url': 'https://example.com/heart'},
      {
        'image': 'assets/images/stress.jpg',
        'url': 'https://example.com/kids-nutrition'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 140.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 20 / 10,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 4),
        ),
        items: adData.map((ad) {
          return GestureDetector(
            onTap: () async {
              final url = Uri.parse(ad['url']!);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                debugPrint("Could not launch ${ad['url']}");
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                ad['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String selectedAvatar = 'assets/images/boy.png'; // Default
  String? userName;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadSavedAvatar();
    _fetchUserDetails();
  }

  Future<void> _loadSavedAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAvatar = prefs.getString('selected_avatar');
    if (savedAvatar != null && mounted) {
      setState(() {
        selectedAvatar = savedAvatar;
      });
    }
  }

  Future<void> _saveAvatar(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_avatar', path);
  }

  Future<void> _fetchUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/user/user/details"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data["user"]["name"];
          userId = data["user"]["_id"];
        });

        // Apply saved avatar if any
        final savedAvatar = prefs.getString('selected_avatar');
        if (savedAvatar != null && mounted) {
          setState(() {
            selectedAvatar = savedAvatar;
          });
        }
      } else {
        print("Failed to fetch user details: ${response.body}");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showAvatarSelectionDialog(BuildContext context) {
    final List<String> avatarOptions = [
      'assets/images/boy.png',
      'assets/images/woman.png',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Your Avatar'),
          content: Wrap(
            spacing: 10,
            children: avatarOptions.map((img) => _avatarChoice(img)).toList(),
          ),
        );
      },
    );
  }

  Widget _avatarChoice(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatar = imagePath;
        });
        _saveAvatar(imagePath);
        Navigator.of(context).pop();
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        radius: 30,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: userName != null
                ? Text(userName!, style: const TextStyle(fontSize: 18))
                : const Text("Loading..."),
            accountEmail: userId != null
                ? Text("ID: $userId", style: const TextStyle(fontSize: 14))
                : const Text(""),
            currentAccountPicture: GestureDetector(
              onTap: () {
                _showAvatarSelectionDialog(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(selectedAvatar),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 158, 96),
            ),
          ),
          _buildDrawerItem(
              context, Icons.home, 'Home', const DashboardScreen()),
          _buildDrawerItem(context, Icons.health_and_safety, 'Health Programs',
              const HealthProgramsScreen()),
          _buildDrawerItem(context, Icons.calendar_today, 'Appointments',
              const AppointmentsScreen()),
          _buildDrawerItem(
              context, Icons.shopping_cart, 'Shop', const ShopScreen()),
          _buildDrawerItem(context, Icons.article, 'Blogs', const BlogScreen()),
          const Divider(),
          _buildDrawerItem(
              context, Icons.settings, 'Settings', const SettingsScreen()),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, Widget destination) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 21, 136, 25)),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
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
            _buildFeatureTile(
              context,
              'PRAKRITI PARIKSHA',
              'assets/images/icon2.jpeg',
              url:
                  'https://docs.google.com/forms/d/1kEnhHSZvxX5V8mLbVoiFjZtmJ5XWB_dOK6Mxbod7Gcg/viewform?chromeless=1&edit_requested=true',
            ),
            _buildFeatureTile(
              context,
              'Nutrition Plans',
              Icons.restaurant,
              color: Colors.orange,
            ),
            _buildFeatureTile(
              context,
              'Wellness/Exercise Routines',
              Icons.self_improvement,
              color: Colors.teal,
            ),
            _buildFeatureTile(context, 'Consultations', Icons.medical_services,
                color: Colors.green, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultationScreen(),
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeatureTile(
  BuildContext context,
  String title,
  dynamic asset, {
  Color? color,
  String? url,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap ??
        () {
          if (url != null) {
            _launchURL(url);
          }
        },
    child: Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          asset is IconData
              ? Icon(asset, size: 40, color: color ?? Colors.black)
              : Image.asset(asset, height: 40),
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

Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
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
      'imagePath': 'assets/images/diabetes.jpg',
      'screen': const DiabetesScreen(),
    },
    {
      'title': 'Heart Disease',
      'imagePath': 'assets/images/heart.jpg',
      'screen': const CardioScreen(),
    },
    {
      'title': 'Weight Management',
      'imagePath': 'assets/images/weight.jpg',
      'screen': const WeightManagementScreen(),
    },
    {
      'title': 'PCOD and Gynae Problems',
      'imagePath': 'assets/images/pcod.jpg',
      'screen': const FemaleHealthScreen(),
    },
    {
      'title': 'Kids Immunity & Nutrition',
      'imagePath': 'assets/images/kids.jpg',
      'screen': const KidsImmunityNutritionScreen(),
    },
    {
      'title': 'Nutrition for Cancer Patient',
      'imagePath': 'assets/images/cancer.jpg',
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
                      backgroundImage: AssetImage(item['imagePath']),
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
                subtitle:
                    const Text('Include green vegetables in your meals daily.'),
              ),
            );
          },
        ),
      ],
    ),
  );
}

// ✅ This is a widget function, not a class
Widget buildContactUsSection(BuildContext context) {
  // Reusable URL launcher function inside the widget
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // 📧 Email Link
        InkWell(
          onTap: () {
            _launchURL(
              'mailto:therealhealth13@gmail.com?subject=Support&body=Hello Team',
            );
          },
          child: const ListTile(
            leading: Icon(Icons.email, color: Colors.green),
            title: Text('Email Us'),
            subtitle: Text('therealhealth13@gmail.com'),
          ),
        ),

        // 📞 Phone Link
        InkWell(
          onTap: () {
            _launchURL('tel:+919991162741');
          },
          child: const ListTile(
            leading: Icon(Icons.phone, color: Colors.green),
            title: Text('Call Us'),
            subtitle: Text('+91 9991162741'),
          ),
        ),
      ],
    ),
  );
}

// Modify the BottomNavigationBar with onTap handling
Widget _buildBottomNavigationBar(BuildContext context) {
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  return ValueListenableBuilder<int>(
    valueListenable: selectedIndexNotifier,
    builder: (context, selectedIndex, child) {
      return BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndexNotifier.value = index;
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProSectionScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExploreScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()),
              );
              break;
          }
        },
        items: [
          _buildAnimatedNavItem(Icons.home, 'Home', 0, selectedIndex),
          _buildAnimatedNavItem(
              Icons.star_border_outlined, 'Pro', 1, selectedIndex),
          _buildAnimatedNavItem(
              Icons.explore, 'Explore Recipes', 2, selectedIndex),
          _buildAnimatedNavItem(Icons.support, 'About Us', 3, selectedIndex),
          // _buildAnimatedNavItem(
          //     Icons.contact_page, 'Contact', 4, selectedIndex),
        ],
      );
    },
  );
}

// Add this new helper method
BottomNavigationBarItem _buildAnimatedNavItem(
  IconData icon,
  String label,
  int index,
  int selectedIndex,
) {
  final isSelected = index == selectedIndex;

  return BottomNavigationBarItem(
    icon: AnimatedScale(
      scale: isSelected ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Icon(icon),
    ),
    label: label,
  );
}

// Additional Screens

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

  Future<void> _launchURL() async {
    const String phoneNumber =
        "+919991162741"; // Organization's WhatsApp number
    final String message = Uri.encodeComponent("Hello, I need support");
    final String url = "https://wa.me/$phoneNumber?text=$message";

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Support')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _launchURL,
          icon: const Icon(Icons.chat, color: Colors.white),
          label: const Text("Chat on WhatsApp",
              style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // WhatsApp theme color
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}

class HealthProgramsScreen extends StatelessWidget {
  const HealthProgramsScreen({super.key});

  static const List<Map<String, String>> programs = [
    {
      "title": "Diabetes & Pre Diabetes",
      "content": "Learn how to manage and prevent diabetes with expert advice.",
      "imagePath": "assets/images/diabetes.jpg",
    },
    {
      "title": "Heart Diseases",
      "content": "Explore tips and programs for a healthy heart.",
      "imagePath": "assets/images/heart.jpg",
    },
    {
      "title": "Weight Management",
      "content": "Achieve your ideal weight with our comprehensive guidance.",
      "imagePath": "assets/images/weight.jpg",
    },
    {
      "title": "Gynae & PCOD",
      "content": "Specialized programs for women's health and PCOD management.",
      "imagePath": "assets/images/pcod.jpg",
    },
    {
      "title": "Kids Immunity and Nutrition",
      "content": "Boost your child's immunity with nutrition-focused programs.",
      "imagePath": "assets/images/kids.jpg",
    },
    {
      "title": "Stress Management",
      "content": "Manage stress with expert techniques and guidance.",
      "imagePath": "assets/images/stress.jpg",
    },
    {
      "title": "Nutrition For Cancer Patient",
      "content": "Tailored nutritional guidance for cancer patients.",
      "imagePath": "assets/images/cancer.jpg",
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
            final program = programs[index];
            return GestureDetector(
              onTap: () {
                final title = program['title'];
                Widget destination;

                switch (title) {
                  case "Diabetes & Pre Diabetes":
                    destination = const DiabetesScreen();
                    break;
                  case "Heart Diseases":
                    destination = const CardioScreen();
                    break;
                  case "Weight Management":
                    destination = const WeightManagementScreen();
                    break;
                  case "Gynae & PCOD":
                    destination = FemaleHealthScreen();
                    break;
                  case "Kids Immunity and Nutrition":
                    destination = const KidsImmunityNutritionScreen();
                    break;
                  case "Stress Management":
                    destination = const StressManagementScreen();
                    break;
                  case "Nutrition For Cancer Patient":
                    destination = const CancerNutritionScreen();
                    break;
                  default:
                    return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => destination),
                );
              },
              child: Card(
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
                        child: Image.asset(
                          program['imagePath']!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              program["title"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              program["content"]!,
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
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProgramDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  const ProgramDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
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

Future<String?> fetchUserName() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs
      .getString("auth_token"); // Retrieve the token from SharedPreferences

  if (token == null) {
    return null; // Return null if no token is found
  }

  try {
    final response = await http.get(
      Uri.parse("$baseUrl/user/details"), // Replace with your backend URL
      headers: {
        "Authorization":
            "Bearer $token", // Pass the token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["user"]["name"]; // Extract the user's name from the response
    } else {
      print("Failed to fetch user details: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error fetching user details: $e");
    return null;
  }
}
