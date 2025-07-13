import 'package:flutter/material.dart';

class CardioScreen extends StatelessWidget {
  const CardioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardiovascular Diseases"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _card(
            title: "Cardiovascular Diseases (Heart Diseases)",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Heart diseases, also known as CVD, is an umbrella term that includes coronary heart disease, cerebrovascular disease, rheumatic heart disease, and other heart and blood vessel conditions."),
                _text(
                    "The most important behavioral risk factors for heart disease and stroke are unhealthy lifestyle choices such as poor diet, physical inactivity, tobacco use, and alcohol consumption, which can lead to:"),
                _bulletList([
                  "Raised blood pressure (Hypertension)",
                  "Raised blood glucose (Diabetes)",
                  "Raised blood lipids (Cholesterol)",
                  "Obesity"
                ]),
                _text(
                    "You may feel frustrated, upset, or overwhelmed upon learning that you or a loved one has heart disease. But heart disease can be improved — or even prevented — by making specific lifestyle changes."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: "MANAGEMENT",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "At Therealhealth, we guide you through the process of cardiac rehabilitation by identifying the root cause of your condition."),
                _text(
                    "We provide customized diet plans, exercise routines including yoga, stress management through meditation, and psychological counseling for patients and caregivers."),
              ],
            ),
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

  Widget _bulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 20)),
                  Expanded(
                      child: Text(item,
                          style: const TextStyle(fontSize: 15, height: 1.4)))
                ],
              ),
            ),
          )
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
