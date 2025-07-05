import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_3/base_url.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  // Static blogs
  final List<Map<String, String>> staticBlogs = [
    {
      "title": "Meditation Tips for Beginners",
      "description":
          "Discover simple and effective tips to start meditating and improve your mental well-being.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2024/05/meditation4514431926123109363.jpg",
      "url": "https://therealhealth.org/meditation-tips-for-beginners/",
    },
    {
      "title": "Brazilian Nut 101",
      "description":
          "Learn about the health benefits of Brazilian nuts and how to include them in your diet.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2024/05/screenshot_2024-05-20-19-22-12-51_965bbf4d18d205f782c6b8409c5773a47569541557691675440.jpg",
      "url": "https://therealhealth.org/brazilian-nut-101/",
    },
    {
      "title": "Stress & Tips to Manage It",
      "description":
          "Understand stress and explore actionable tips to manage it effectively in your daily life.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2023/03/STRESS-MX.jpg",
      "url": "https://therealhealth.org/stress-tips-to-manage-it/",
    },
    {
      "title": "Gudmaar - Boon for Diabetes Patients",
      "description":
          "Explore the benefits of Gudmaar and its role in managing diabetes naturally.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2023/03/GUDMAAR-1.jpg",
      "url": "https://therealhealth.org/gudmaar-boon-for-diabetes-patients/",
    },
    {
      "title": "Plant Based Vegan Milk Options",
      "description":
          "Discover various plant-based milk options and their benefits for a vegan lifestyle.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2023/04/MILK.jpg",
      "url": "https://therealhealth.org/plant-based-vegan-milk-options/",
    },
    {
      "title": "Haridrakhand – The Magic of Ayurveda",
      "description":
          "Learn about Haridrakhand and its amazing benefits in Ayurvedic medicine.",
      "imageUrl":
          "https://therealhealth.org/wp-content/uploads/2023/03/hari-1.jpg",
      "url": "https://therealhealth.org/haridrakhand-the-magic-of-ayurveda/",
    },
  ];

  // List to hold both static and backend blogs
  final List<Map<String, String>> blogs = [];

  @override
  void initState() {
    super.initState();
    // Add static blogs first
    blogs.addAll(staticBlogs);
    // Fetch blogs from backend
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    try {
      // Send GET request to fetch blogs
      final response = await http.get(Uri.parse('$baseUrl/api/blogs/blogs'));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          blogs.addAll(data.map((blog) => {
                "title": blog["title"] ?? "No Title", // Default value if null
                "description": blog["description"] ?? "No Description",
                "imageUrl": blog["image"] ?? "", // Public URL for the image
              }));
        });
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      print("Error fetching blogs: $e");
    }
  }

   // ignore: unused_element
   Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: blogs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the BlogDetailScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(
                            title: blog['title']!,
                            description: blog['description']!,
                            imageUrl: blog['imageUrl']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Blog Image
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: blog['imageUrl']!.isNotEmpty
                                ? Image.network(
                                    blog['imageUrl']!,
                                    width: double.infinity,
                                    height: screenWidth * 0.45, // Responsive height
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image,
                                          size: 180);
                                    },
                                  )
                                : const Icon(Icons.image_not_supported,
                                    size: 180),
                          ),
                          // Blog Title and Description
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blog['title']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  blog['description']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
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

class BlogDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const BlogDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: screenHeight * 0.4, // Responsive height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 300);
                },
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: screenWidth * 0.045, // Responsive font size
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}