import 'package:flutter/material.dart';

// Define the Recipe class with imageUrl
class Recipe {
  final String name;
  final List<String> ingredients;
  final List<String> preparationSteps;
  final String imageUrl;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.preparationSteps,
    required this.imageUrl,
  });
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Sample list of Ayurvedic recipes with image URLs
  List<Recipe> recipes = [
    Recipe(
      name: 'Ashwagandha Milk',
      ingredients: [
        '1 cup milk',
        '1 tsp Ashwagandha powder',
        'Honey (optional)'
      ],
      preparationSteps: [
        'Heat the milk in a saucepan.',
        'Add the Ashwagandha powder and stir well.',
        'Once the milk is warm, pour into a cup.',
        'Add honey for sweetness if desired.',
        'Drink before bedtime for relaxation.'
      ],
      imageUrl:
          'https://eu-images.contentstack.com/v3/assets/bltd5b5e8fe28aae49e/blt491352bb97523d03/6694f54e1a46653875a73a36/Ashwagandha-root-powder-drink_iStock_eskymaks_1333961108.png?width=1280&auto=webp&quality=95&format=jpg&disable=upscale',
    ),
    Recipe(
      name: 'Turmeric Ginger Tea',
      ingredients: [
        '1 cup water',
        '1 tsp turmeric',
        '1 tsp grated ginger',
        'Honey (optional)'
      ],
      preparationSteps: [
        'Boil water in a saucepan.',
        'Add turmeric and grated ginger to the boiling water.',
        'Let it simmer for 5-7 minutes.',
        'Strain and pour the tea into a cup.',
        'Add honey if desired and enjoy!'
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmEBG_vevEy9YDWjwE-83jbHR5JMlCHs3Zeg&s',
    ),
    Recipe(
      name: 'Moringa Soup',
      ingredients: [
        '2 cups vegetable broth',
        '1 cup Moringa leaves',
        '1/2 onion',
        'Salt to taste'
      ],
      preparationSteps: [
        'Heat the vegetable broth in a pot.',
        'Add chopped onion and let it cook until soft.',
        'Add the Moringa leaves and cook for 5 minutes.',
        'Season with salt and other spices as desired.',
        'Blend the mixture if you prefer a smoother texture.'
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgZy3qQlJ-61ntpGIDvHjWlYGGXwcq3P7_UQ&s',
    ),
    // Add more recipes as needed...
  ];

  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes; // Initially show all recipes
  }

  // Function to filter recipes based on search query
  void _filterRecipes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRecipes = recipes;
      } else {
        filteredRecipes = recipes
            .where((recipe) =>
                recipe.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Navigate to the detail screen for the selected recipe
  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Recipes'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search for Recipes...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // List of Recipes
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return GestureDetector(
                  onTap: () => _navigateToRecipeDetail(recipe),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${recipe.ingredients.length} ingredients',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  recipe.imageUrl,
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var ingredient in recipe.ingredients)
              Text(
                '• $ingredient',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            const Text(
              'Preparation Steps',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var step in recipe.preparationSteps)
              Text(
                '• $step',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}