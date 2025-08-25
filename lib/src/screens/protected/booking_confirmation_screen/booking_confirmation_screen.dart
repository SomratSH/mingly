import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

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
        title: const Text('Confirmation', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text('Personal details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card(
                color: Colors.grey.shade900,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: const Text('Tyler Howell', style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('1234567890', style: TextStyle(color: Colors.white70)),
                      Text('tyler.howell@gmail.com', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  trailing: InkWell(
                    onTap: ()=> context.push("/personal-info"),
                    child: const Icon(Icons.chevron_right, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('[Event]', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Fri, 26 Jan 2025', style: TextStyle(color: Colors.white)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text('Open gate at 20:00', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.store, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Outlet', style: TextStyle(color: Colors.white)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text('[Address]\nCity - Country', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.grey.shade900,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Ticket  : VIP', style: TextStyle(color: Colors.white)),
                          Text('2415.00', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('1 x', style: TextStyle(color: Colors.white70)),
                          Text('2415.00', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      const Divider(color: Colors.white24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total', style: TextStyle(color: Colors.white)),
                          Text('2415.00', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Promo Code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        prefixIcon: const Icon(Icons.card_giftcard, color: Colors.white54),
                        hintText: 'Enter promo code',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text('Apply'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.grey.shade900,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Promo', style: TextStyle(color: Colors.white)),
                          Text('-', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Subtotal', style: TextStyle(color: Colors.white)),
                          Text('2415.00', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Grand Total', style: TextStyle(color: Colors.white)),
                          Text('2415.00', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Full Payment', style: TextStyle(color: Colors.black)),
                    Text('2415.00', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1B26F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    context.push("/payment");
                  },
                  child: const Text('Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
