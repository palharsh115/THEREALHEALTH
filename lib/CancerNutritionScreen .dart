import 'package:flutter/material.dart';

class CancerNutritionScreen extends StatelessWidget {
  const CancerNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancer Nutrition Support"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _headerCard("Why Do Cancer Patients Need a Nutritionist?", [
            "🔹 Optimizing treatment outcomes – A tailored diet helps improve response to treatments like chemotherapy and surgery.",
            "🔹 Preventing malnutrition – Personalized meal plans address nausea, appetite loss, and taste changes.",
            "🔹 Managing side effects – Dietary strategies help manage nausea, constipation, and other symptoms.",
            "🔹 Supporting immune function – Nutrient-rich foods help the body fight infections and cancer cells.",
            "🔹 Promoting healing and recovery – Nutrition aids tissue repair and post-treatment recovery.",
            "🔹 Improving quality of life – Balanced diets boost energy, reduce fatigue, and support emotional well-being.",
          ]),
          const SizedBox(height: 16),
          _textCard(
            "“Pay What You Can” Initiative",
            "We launched this initiative to ensure that no cancer patient is left behind due to financial constraints. Patients wanted to contribute, but not get the service for free. So we introduced a middle ground — contribute what you can, and we use those funds to spread awareness and support more people.",
          ),
          _textCard(
            "Why We Support This Model",
            "🔸 Making service available – Good nutrition is critical during cancer treatment and recovery.\n"
                "🔸 Financial relief – Reduces financial burden so patients can focus on healing.\n"
                "🔸 Empowerment – Patients contribute with dignity and feel involved in their care.\n"
                "🔸 Community support – Those who can give more help others who are in need.",
          ),
          const SizedBox(height: 16),
          _pricingCard(),
        ],
      ),
    );
  }

  Widget _headerCard(String title, List<String> points) {
    return _cardContainer(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: points
            .map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    point,
                    style: const TextStyle(fontSize: 15),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _textCard(String title, String body) {
    return _cardContainer(
      title: title,
      child: Text(
        body,
        style: const TextStyle(fontSize: 15, height: 1.5),
      ),
    );
  }

  Widget _pricingCard() {
    final plans = [
      ["1 Month", "₹3000", "\$45"],
      ["3 Month", "₹8000", "\$100"],
      ["6 Month", "₹14000", "\$180"],
      ["9 Month", "₹20000", "\$250"],
      ["12 Month", "₹26000", "\$320"],
    ];

    return _cardContainer(
      title: "Suggested Contributions",
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
        },
        children: [
          _tableRow(["Duration", "Indian Rupee", "US \$"], isHeader: true),
          ...plans.map((plan) => _tableRow(plan)).toList(),
        ],
      ),
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
}
