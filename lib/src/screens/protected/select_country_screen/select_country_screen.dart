import 'package:flutter/material.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});

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
        title: const Text('Select country', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade900,
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                hintText: 'Enter country name or code',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Thailand', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              trailing: const Text('+355', style: TextStyle(color: Colors.white70)),
              onTap: () {},
            ),
            const Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
