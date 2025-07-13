import 'package:flutter/material.dart';

class FemaleHealthScreen extends StatelessWidget {
  const FemaleHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Female Reproductive Health"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _cardContainer(
            title: "1. PCOD (Polycystic Ovarian Disease)",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "PCOD is caused by hormonal imbalance and genetic tendencies. Normally, ovaries release mature eggs monthly, but in PCOD, they release immature or partially-mature eggs, which form cysts and swell the ovaries."),
                _text(
                    "Excess androgens (male hormones) are produced, leading to symptoms such as male-pattern hair loss, abdominal weight gain, irregular periods, and possibly infertility."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Management (PCOD)",
            child: _text(
                "PCOD can be managed through regular exercise, healthy diet, stress management, and meditation. We’ll guide and support you step-by-step on your journey toward better reproductive health."),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "2. UTERINE FIBROIDS",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Uterine fibroids can cause anemia from heavy bleeding, pain during intercourse, and pressure on the bladder or bowel. They may also lead to complications in pregnancy or increase the risk of miscarriage."),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _cardContainer(
            title: "Management (Fibroids)",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                    "Ayurveda helps by balancing the doshas (vata, pitta, kapha) using herbal remedies, lifestyle changes, and stress reduction."),
                _text(
                    "Nutrition plays a vital role—eating fiber-rich foods, fruits, vegetables, and lean proteins supports hormonal balance and relieves constipation."),
                _text(
                    "Consulting with Ayurvedic experts or healthcare professionals will help create a personalized treatment plan tailored to your needs."),
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
          child,
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
      decoration: BoxDecoration(color: isHeader ? Colors.teal.shade100 : null),
      children: cells
          .map(
            (cell) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cell,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }
}
