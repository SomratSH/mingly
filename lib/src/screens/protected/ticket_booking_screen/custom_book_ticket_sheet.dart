import 'package:flutter/material.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:provider/provider.dart';

class TicketSelectionModal extends StatelessWidget {
  final double ticketPrice;
  final String ticketName;
  final String ticketId;

  const TicketSelectionModal({
    Key? key,
    required this.ticketPrice,
    required this.ticketId,
    required this.ticketName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventsProvider>();

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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticketName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${provider.ticketTotalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('🔥🔥', style: TextStyle(fontSize: 14)),
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
                      onTap: () => provider.decrementTicket(ticketPrice),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF666666),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: provider.ticketCount > 1
                              ? Colors.white
                              : const Color(0xFF666666),
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 32),

                    // Count display
                    Text(
                      '${provider.ticketCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 32),

                    // Plus button
                    GestureDetector(
                      onTap: () => provider.incrementTicket(ticketPrice),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF666666),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 20),
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
                      Navigator.pop(context, {
                        'ticketCount': provider.ticketCount,
                        'totalPrice': provider.totalPrice,
                      });
                      provider.addOrUpdateTicket(
                        ticketId,
                        provider.ticketCount,
                      );
                      // provider.clearData();
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
                    child: const Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
void showTicketSelectionModal(
  BuildContext context,
  double ticketPrice,
  String ticketName,
  String ticketId,
) {
  final provider = context.read<EventsProvider>();
  provider.start(ticketPrice); // reset state before opening

  showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => TicketSelectionModal(
      ticketPrice: ticketPrice,
      ticketName: ticketName,
      ticketId: ticketId,
    ),
  ).then((result) {
    if (result != null) {
      print('Selected ${result['ticketCount']} tickets');
      print('Total price: \$${result['totalPrice'].toStringAsFixed(2)}');
    }
  });
}
