import 'package:flutter/material.dart';

class StressManagementScreen extends StatelessWidget {
  const StressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stress Management"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _cardContainer(
            title: "Understanding Stress",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Stress is something we hear about a lot these days. It can be both a root cause and a byproduct of other health issues. Stress can affect not only the individual but also their family and caregivers—especially after a diagnosis or during prolonged treatment."),
                _text(
                    "It can stem from work, family, or personal challenges. We believe a healthy soul lives in a healthy body—and that includes being mentally, physically, and spiritually balanced."),
                _text(
                    "Stress in any form is harmful to human well-being. Effective stress management helps you regain control and live a more joyful, healthy, and productive life."),
                _text(
                    "The goal is a balanced life—with time for relationships, work, relaxation, and fun—while building resilience to handle life’s challenges."),
                _text(
                    "Managing stress also helps families and patients support one another throughout and beyond treatment."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Our Approach",
            child: _bulletList([
              "🔹 Identify the sources of stress in your life.",
              "🔹 Practice the 4 A’s of stress management.",
              "🔹 Motivate you to follow the “Get Moving” method.",
              "🔹 Help you manage your time effectively.",
              "🔹 Guide you to balance life with a healthy lifestyle.",
              "🔹 Teach you techniques to relieve stress in the moment.",
            ]),
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
