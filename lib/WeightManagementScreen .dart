import 'package:flutter/material.dart';

class WeightManagementScreen extends StatelessWidget {
  const WeightManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weight Management"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _cardContainer(
            title: "1. OBESITY",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                  "Obesity is an epidemic of the current generation, worldwide. According to WHO, in 2016 more than 1.9 billion adults (18+ years) were overweight, and over 650 million were obese. In 2020, 39 million children under 5 were overweight or obese.",
                ),
                _text(
                  "Overweight and obesity are defined as abnormal or excessive fat accumulation that may impair health. The main causes include unhealthy eating (high calories, low nutrition), lack of physical activity, and hormonal imbalance due to lifestyle disorders.",
                ),
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
                  "We will guide you throughout the weight management process, starting with prakriti (constitution) analysis to identify the root cause.",
                ),
                _text(
                  "Then we’ll provide personalized diet and exercise plans including yoga, and help manage stress with meditation and psychological counseling for both patients and caregivers.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "2. BEING UNDERWEIGHT",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                  "While obesity is on the rise globally, underweight due to malnutrition is still a concern. It’s often due to high metabolism, poor diet, anorexia, or genetics. It may also be linked with autoimmune disorders, Crohn’s disease, or cancer.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Management",
            child: _text(
              "We offer prakriti (constitution) analysis to identify underlying causes, followed by personalized diet and exercise plans. Ayurvedic medicines can support healthy weight gain effectively.",
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.5),
      ),
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
