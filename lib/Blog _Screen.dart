import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  final List<Map<String, String>> blogs = const [
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
        title: const Text('Blogs'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            final blog = blogs[index];

            return InkWell(
              onTap: () => _launchURL(blog['url']!),
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
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        blog['imageUrl']!,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
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