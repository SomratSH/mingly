import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String menuName;
  final String price;
  final String quantity;
  final String subtotal;
  final VoidCallback onDelete;

  const MenuCard({
    super.key,
    required this.menuName,
    required this.price,
    required this.quantity,
    required this.subtotal,
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
                Text(
                  '[Menu] $menuName',
                  style: const TextStyle(
                    color: Color(0xFFFFFAE5),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
                _buildRow("Price :", price),
                _buildRow("Quantity :", quantity),
                _buildRow("Subtotal :", subtotal),
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
