import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:provider/provider.dart';

class TableBookingScreen extends StatelessWidget {
  const TableBookingScreen({super.key});

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
          eventProvider.selectEventModel.eventName.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                eventProvider.selectEventModel.eventName.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFFD1B26F)),
                  SizedBox(width: 8),
                  Text(
                    eventProvider.selectEventModel.venueCity.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Text(
                'North Miami Beach, FL 33160 |',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, color: Color(0xFFD1B26F)),
                  SizedBox(width: 8),
                  Text(
                    "  ${eventProvider.eventDetailsModel.sessionStartTime.toString()} - ${eventProvider.eventDetailsModel.sessionEndTime.toString()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("lib/assets/icons/calender_gold.svg"),
                  SizedBox(width: 5),
                  Text("17/12/2022"),
                  Icon(Icons.arrow_drop_down_sharp),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.47,
                          vertical: 8.37,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withValues(alpha: 0.13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.23),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10.47,
                          children: [
                            Icon(Icons.access_time, color: Color(0xFFD1B26F)),
                            Text(
                              '12:15',
                              style: TextStyle(
                                color: const Color(0xFFCECECE),
                                fontSize: 12.56,
                                fontFamily: 'Segoe UI',
                                fontWeight: FontWeight.w600,
                                height: 1.67,
                              ),
                            ),
                            Container(
                              width: 10.47,
                              height: 10.47,
                              child: Stack(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.47,
                          vertical: 8.37,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white.withValues(alpha: 0.13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.23),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10.47,
                          children: [
                            Icon(Icons.group, color: Color(0xFFD1B26F)),
                            Text(
                              '2',
                              style: TextStyle(
                                color: const Color(0xFFCECECE),
                                fontSize: 12.56,
                                fontFamily: 'Segoe UI',
                                fontWeight: FontWeight.w600,
                                height: 1.67,
                              ),
                            ),
                            Container(
                              width: 10.47,
                              height: 10.47,
                              child: Stack(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFFD1B26F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                eventProvider.eventDetailsModel.description.toString(),
                style: TextStyle(color: Colors.white70),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Read More...',
                  style: TextStyle(color: Color(0xFFD1B26F), fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Select a time you like',
                style: TextStyle(
                  color: Color(0xFFD1B26F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 15,
                runSpacing: 8,
                children: [
                  ...List.generate(eventProvider.listedTimeSlot!.length, (
                    index,
                  ) {
                    final timeSlot = eventProvider.listedTimeSlot![index];

                    return _TimeSlotButton(label: timeSlot, index: index);
                  }),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    '${AppUrls.imageUrlNgrok}${eventProvider.eventDetailsModel.images!.first.seatingPlan}',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Book Preferred Slot',
                style: TextStyle(
                  color: Color(0xFFD1B26F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...List.generate(eventProvider.tableTicketModel.tables!.length, (
                    index,
                  ) {
                    final table = eventProvider.tableTicketModel.tables![index];

                    // Example: consider "available" if availabilityStatus == "available"
                    final isAvailable = table.availabilityStatus == "available";

                    return _TableSlotButton(
                      id: table.id!,
                      label:
                          'Table\n${(table.tcketNumber ?? index + 1).toString().padLeft(2, '0')}',
                      available: isAvailable,
                    );
                  }),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.circle, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text('Available', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 16),
                  Icon(Icons.circle, color: Colors.red, size: 16),
                  SizedBox(width: 4),
                  Text('Sold', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 24),
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
                    context.push("/beverages");
                  },
                  child: const Text('Proceed'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeSlotButton extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  const _TimeSlotButton({
    required this.label,
    this.selected = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventsProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: provider.indexOfSelectedTimeSlot == index
            ? const Color(0xFFD1B26F)
            : Colors.grey.shade900,
        foregroundColor: provider.indexOfSelectedTimeSlot == index
            ? Colors.black
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {
        provider.selectTimeSlot(index);
      },
      child: Text(label),
    );
  }
}

class _TableSlotButton extends StatelessWidget {
  final int id;
  final String label;
  final bool available;
  const _TableSlotButton({
    required this.label,
    required this.available,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventsProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: available ? Colors.green : Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: eventProvider.tableBooking.seatId == id
              ? BorderSide(color: Colors.white)
              : BorderSide(color: Colors.transparent),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
      onPressed: () {
        if (available == false) {
          CustomSnackbar.show(
            context,
            message: "Table already booked.",
            backgroundColor: Colors.red,
          );
        } else if (available) {
          eventProvider.selecteTableBooking(id, "17:00");
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
