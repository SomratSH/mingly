
import 'package:flutter/material.dart';

class TicketSelectionModal extends StatefulWidget {
  const TicketSelectionModal({Key? key}) : super(key: key);

  @override
  State<TicketSelectionModal> createState() => _TicketSelectionModalState();
}

class _TicketSelectionModalState extends State<TicketSelectionModal> {
  int ticketCount = 1;
  final int maxTickets = 5;
  final double ticketPrice = 15.00;

  void _incrementTicket() {
    if (ticketCount < maxTickets) {
      setState(() {
        ticketCount++;
      });
    }
  }

  void _decrementTicket() {
    if (ticketCount > 1) {
      setState(() {
        ticketCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Select Number of Tickets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 0.3,
                ),
                
                const SizedBox(height: 24),
                
                // Ticket info and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '[Ticket]',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Max ($maxTickets Tickets)',
                          style: const TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${ticketPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Fire emojis
                        const Text(
                          '🔥🔥',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Counter controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Minus button
                    GestureDetector(
                      onTap: _decrementTicket,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: const Color(0xFF666666),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: ticketCount > 1 
                              ? Colors.white 
                              : const Color(0xFF666666),
                          size: 20,
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 32),
                    
                    // Count display
                    Text(
                      '$ticketCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    const SizedBox(width: 32),
                    
                    // Plus button
                    GestureDetector(
                      onTap: _incrementTicket,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: const Color(0xFF666666),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: ticketCount < maxTickets 
                              ? Colors.white 
                              : const Color(0xFF666666),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Buy button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle buy action
                      Navigator.pop(context, {
                        'ticketCount': ticketCount,
                        'totalPrice': ticketCount * ticketPrice,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: const Color(0xFF1A1A1A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Buy',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                // Bottom padding for safe area
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to show the modal
void showTicketSelectionModal(BuildContext context) {
  showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const TicketSelectionModal(),
  ).then((result) {
    if (result != null) {
      // Handle the result
      print('Selected ${result['ticketCount']} tickets');
      print('Total price: \$${result['totalPrice'].toStringAsFixed(2)}');
    }
  });
}
