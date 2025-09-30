import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/ticket_booking_screen/custom_book_ticket_sheet.dart';
import 'package:provider/provider.dart';

class TicketBookingScreen extends StatelessWidget {
  const TicketBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventProvider = context.watch<EventsProvider>();
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Buy Ticket',
          style: TextStyle(
            color: const Color(0xFFFFFAE5),
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
            height: 1.56,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              eventProvider.selectEventModel.eventName.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.calendar_today, color: Colors.white),
                SizedBox(width: 8),
                Text('Fri, 26 Jan 2025', style: TextStyle(color: Colors.white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 32),
              child: Text(
                'Open gate at 20:00',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.store, color: Colors.white),
                SizedBox(width: 8),
                Text('Outlet', style: TextStyle(color: Colors.white)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: Text(
                '${eventProvider.selectEventModel.venueName}\nCity - ${eventProvider.selectEventModel.venueCity}',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: eventProvider.eventTicketList.isEmpty
                  ? [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "No tickets available",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ]
                  : List.generate(eventProvider.eventTicketList.length, (
                      index,
                    ) {
                      final ticket = eventProvider.eventTicketList[index];
                      return _TicketOption(
                        id: ticket.id.toString(),
                        title: ticket.title ?? "",
                        price: ticket.price?.toString() ?? "0",
                        soldOut: ticket.isSoldOut != 0,
                      );
                    }),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD1B26F),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  context.push("/booking-confirmation");
                },
                child: Text('Buy Tickets (${eventProvider.totalPrice})'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _TicketOption extends StatelessWidget {
  final String title;
  final String price;
  final int? qty;
  final int? selectedQty;
  final bool soldOut;
  final bool showFire;
  final String id;
  const _TicketOption({
    required this.title,
    required this.price,
    required this.id,
    this.qty,
    this.selectedQty,
    this.soldOut = false,
    this.showFire = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        color: Color(0xFF2E2D2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Row(
            children: [
              Text(title, style: const TextStyle(color: Colors.white)),
              if (showFire) ...[
                const SizedBox(width: 4),
                Text('26#128293', style: TextStyle(fontSize: 16)),
              ],
            ],
          ),
          subtitle: qty != null
              ? Text(
                  '$price\nQty: $qty',
                  style: const TextStyle(color: Colors.white54),
                )
              : Text('$price', style: const TextStyle(color: Colors.white54)),
          trailing: soldOut
              ? const Text('SOLD OUT', style: TextStyle(color: Colors.white54))
              : selectedQty != null
              ? Text(
                  '$selectedQty',
                  style: const TextStyle(color: Colors.white),
                )
              : InkWell(
                  onTap: () {
                    context.read<EventsProvider>().clearData();
                    showTicketSelectionModal(
                      context,
                      double.parse(price),
                      title,
                      id,
                    );
                  },
                  child: const Icon(Icons.chevron_right, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
