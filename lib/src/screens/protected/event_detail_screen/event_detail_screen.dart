import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B26F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Waves & Raves', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: Colors.grey.shade800,
            height: 2,
            width: double.infinity,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image carousel (static for now)
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'lib/assets/images/dummy_yacht_event.png',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 8,
                      top: 80,
                      child: Icon(Icons.arrow_back_ios, color: Colors.white70, size: 24),
                    ),
                    Positioned(
                      right: 8,
                      top: 80,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 24),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.white : Colors.white24,
                            shape: BoxShape.circle,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('Seascape Music Festival', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.location_on, color: Color(0xFFD1B26F), size: 18),
                  SizedBox(width: 4),
                  Text('Singapore', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.calendar_today, color: Color(0xFFD1B26F), size: 18),
                  SizedBox(width: 4),
                  Text('27/04/2025', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.access_time, color: Color(0xFFD1B26F), size: 18),
                  SizedBox(width: 4),
                  Text('10:30 AM - 11:00 PM', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Description', style: TextStyle(color: Color(0xFFD1B26F), fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text(
                'Villagio restaurant and bar has one mission: to provide guests with a fine and fresh seafood experience. Featuring seasonal and sustainable seafood that is flown in fresh daily, our chef-driven menu proves that no matter when you\'re dining, seafood can ',
                style: TextStyle(color: Colors.white70),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('Read More...', style: TextStyle(color: Color(0xFFD1B26F), fontSize: 12)),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1B26F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    onPressed: () {
                      context.push("/ticket-booking");
                    },
                    child: const Text('Book Ticket'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1B26F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    onPressed: () {
                      context.push("/table-booking");
                    },
                    child: const Text('Sofa & Table'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
