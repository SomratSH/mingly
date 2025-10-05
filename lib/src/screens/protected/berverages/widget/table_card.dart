import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final List<String> no;
  final String downPayment;
  final String minimumCharge;
  final String tableCount;
  final String totalDownPayment;
  final VoidCallback onDelete;

  const TableCard({
    super.key,
    required this.no,
    required this.downPayment,
    required this.minimumCharge,
    required this.tableCount,
    required this.totalDownPayment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: Color(0xFF2E2D2C),
        shape: RoundedRectangleBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("No : "),
                    Row(
                      children: List.generate(
                        no.length,
                        (index) => Text("${no[index]} "),
                      ),
                    ),
                  ],
                ),
                _buildRow("Down Payment:", downPayment),
                _buildRow("Minimum Charge :", minimumCharge),
                const SizedBox(height: 20),
                const Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildRow("Table :", tableCount),
                _buildRow("Down Payment :", totalDownPayment),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E7A72),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),

        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
