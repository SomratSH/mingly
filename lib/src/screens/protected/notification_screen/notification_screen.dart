import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NotificationItem(
              icon: Icons.calendar_today,
              title: 'Announcement',
              subtitle: 'Are you ready for today’s part..',
              date: '12 mar',
            ),
            _NotificationItem(
              icon: Icons.calendar_today,
              title: 'Campaign',
              subtitle: 'Are you ready for today’s part..',
              date: '12 mar',
            ),
            _NotificationItem(
              icon: Icons.attach_money,
              title: 'Transaction complete!',
              subtitle: 'Paid 29\$ successfully',
              date: '12 mar',
            ),
            _NotificationItem(
              icon: Icons.calendar_today,
              title: 'order notification',
              subtitle: 'order complete',
              date: '12 mar',
            ),
            _NotificationItem(
              icon: Icons.person,
              title: 'Account assistant',
              subtitle: 'login attempted from ip',
              date: '12 mar',
            ),
          ],
        ),
      ),
      
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
