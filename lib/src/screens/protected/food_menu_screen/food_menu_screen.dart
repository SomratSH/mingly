import 'package:flutter/material.dart';

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Food Menu', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Starters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            _MenuItem(title: 'Seafood Platter', description: 'Fresh seafood selection served with house sauce.', price: '2425.00'),
            _MenuItem(title: 'Bruschetta', description: 'Grilled bread with tomato and basil.', price: '412.00'),
            const SizedBox(height: 24),
            const Text('Main Course', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            _MenuItem(title: 'Grilled Salmon', description: 'Salmon fillet with seasonal vegetables.', price: '2435.00'),
            _MenuItem(title: 'Steak', description: 'Prime beef steak cooked to your liking.', price: '2440.00'),
            const SizedBox(height: 24),
            const Text('Desserts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            _MenuItem(title: 'Cheesecake', description: 'Classic cheesecake with berry compote.', price: '2415.00'),
            _MenuItem(title: 'Chocolate Lava Cake', description: 'Warm chocolate cake with molten center.', price: '2418.00'),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  const _MenuItem({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(color: Colors.white70)),
        trailing: Text(price, style: const TextStyle(color: Color(0xFFD1B26F), fontWeight: FontWeight.bold)),
      ),
    );
  }
}
