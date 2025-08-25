import 'package:flutter/material.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

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
        title: const Text('Membership Details', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Membership status card
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                       SizedBox(
                    height: 161.25,
                    child: PageView(
                      children: [
                        Card(
                          color: Color(0xffD4AF37),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Membership Status', style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 8),
                                Text('Gold', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                                SizedBox(height: 8),
                                Text('Access to more events, priority booking,  member-only ticket discounts', style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                        ),
                        // Add more cards for other membership types if needed
                      ],
                    ),
                  ),
                              
                  // PageView for Membership Types
                  SizedBox(
                    height: 161.25,
                    child: PageView(
                      children: [
                        Card(
                          color: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Membership Status', style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 8),
                                Text('Silver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                                SizedBox(height: 8),
                                Text('Access to more events, priority booking,  member-only ticket discounts', style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                        ),
                        // Add more cards for other membership types if needed
                      ],
                    ),
                  ),
                            
                  
                  ],),
                ),
              ),
            ),
            
          
            const SizedBox(height: 8),
            // Indicator dots
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Member benefits section
            const Text('Member Benefits', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Discount 5%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Lorem ipsum dolor sit amet consectetur. Amet consequat tempor congue elit nisi nunc eu gravida.', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Priority Booking', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Only Silver Members Get to book special bookings', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
