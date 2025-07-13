import 'package:flutter/material.dart';

class KidsImmunityNutritionScreen extends StatelessWidget {
  const KidsImmunityNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kids Immunity & Nutrition"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _cardContainer(
            title: "1. Kids Immunity",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Children’s immune systems are still developing, making them more vulnerable to infections. Nutrition plays a key role in boosting immunity by supplying vital nutrients like vitamin C, D, zinc, and iron."),
                _text(
                    "These nutrients help the immune system fight pathogens, reduce severity, and quicken recovery from illnesses."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "2. Kids Nutrition",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Nutrition is the foundation of children’s health and development. A well-balanced diet supports growth, brain development, organ function, and prevents future diseases."),
                _text(
                    "Establishing healthy habits early reduces long-term risks of obesity, diabetes, and heart disease."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Management",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "As mothers ourselves, we understand the daily challenges parents face in feeding their kids a nutritious diet. Our personalized plans consider:"),
                _bulletList([
                  "🔹 Nutritional Balance – Meals with right carbs, proteins, fats, vitamins, minerals",
                  "🔹 Variety of Foods – Fruits, vegetables, grains, proteins, and healthy fats",
                  "🔹 Portion Control – Based on age, activity, and individual needs",
                  "🔹 Hydration – Importance of water and healthy drinks",
                  "🔹 Immune-Boosting Foods – Citrus, berries, yogurt, nuts, leafy greens",
                  "🔹 Limiting Sugar & Processed Foods – Reducing snacks, sodas, junk food",
                  "🔹 Regular Meals & Snacks – To ensure energy and steady development",
                  "🔹 Parent Participation – Involving parents to tailor the child’s plan continuously"
                ]),
                _text(
                    "By following these principles, we help kids build a strong immune system and healthy eating habits that last a lifetime."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Duration & Pricing",
            child: _pricingTable(),
          ),
        ],
      ),
    );
  }

  Widget _cardContainer({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: const TextStyle(fontSize: 15, height: 1.5)),
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(item, style: const TextStyle(fontSize: 15)),
              ))
          .toList(),
    );
  }

  Widget _pricingTable() {
    final plans = [
      ["1 Month", "₹3000", "\$45"],
      ["3 Month", "₹8000", "\$100"],
      ["6 Month", "₹14000", "\$180"],
      ["9 Month", "₹20000", "\$250"],
      ["12 Month", "₹26000", "\$320"],
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      children: [
        _tableRow(["Duration", "Indian Rupee", "US \$"], isHeader: true),
        ...plans.map((plan) => _tableRow(plan)).toList()
      ],
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.teal.shade100 : null,
      ),
      children: cells
          .map(
            (cell) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cell,
                style: TextStyle(
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }
}
