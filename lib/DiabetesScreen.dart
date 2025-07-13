import 'package:flutter/material.dart';

class DiabetesScreen extends StatelessWidget {
  const DiabetesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes & Prediabetes"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _card(
            title: "A) PREDIABETES",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Prediabetes is a condition in which blood sugar levels are higher than normal but not high enough to be diagnosed as type 2 diabetes. It’s often considered a warning sign that someone is at risk of developing type 2 diabetes in the future."),
                _text(
                    "Without intervention, prediabetes can progress to type 2 diabetes, increasing the risk of serious health complications such as heart disease, stroke, and kidney damage."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: "MANAGEMENT (PREDIABETES)",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bulletPoint("Balanced Diet",
                    "Include whole grains, legumes, fruits, vegetables, lean proteins, and healthy fats. Avoid processed foods and sugary snacks."),
                _bulletPoint("Herbal Supplements",
                    "Use herbs like bitter melon, fenugreek, cinnamon, and turmeric to improve insulin sensitivity."),
                _bulletPoint("Stress Management",
                    "Practice yoga, meditation, and deep breathing exercises to reduce stress."),
                _bulletPoint("Regular Exercise",
                    "Daily activity improves insulin use, lowers blood sugar, and helps maintain weight."),
                _bulletPoint("Individualized Approach",
                    "Consult with an Ayurvedic practitioner to create a personalized plan."),
                const SizedBox(height: 10),
                _text(
                    "Combining Ayurveda with conventional medical approaches can provide comprehensive support. Always consult healthcare professionals before making major changes."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: "B) DIABETES",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Diabetes is a condition in which sugar level in the blood rises. Your body breaks food into sugar (glucose), which requires insulin to enter cells."),
                _text(
                    "If the body doesn’t make enough insulin or use it properly, the pancreas gets exhausted and stops producing insulin. This may lead to serious health issues."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: "MANAGEMENT (DIABETES)",
            content: _text(
                "Management without medicine is possible through food habits, physical activity, stress management, and psychological support — all of which we provide at Therealhealth."),
          ),
          const SizedBox(height: 16),
          _card(
            title: "Duration & Pricing",
            content: _pricingTable(),
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
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
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, height: 1.5),
      ),
    );
  }

  Widget _bulletPoint(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 20)),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$title: ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
                children: [
                  TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, height: 1.4),
                  )
                ],
              ),
            ),
          )
        ],
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
