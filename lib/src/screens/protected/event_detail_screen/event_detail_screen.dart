import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/application/events/model/events_model.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/helpers.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  EventsModel model;
  EventDetailScreen({super.key, required this.model});

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
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B26F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          eventProvider.eventDetailsModel.eventName.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                      child: PageView.builder(
                        itemCount: eventProvider.eventDetailsImageList.length,
                        onPageChanged: (index) {},

                        itemBuilder: (context, index) {
                          return Image.network(
                            "${AppUrls.imageUrlNgrok}${eventProvider.eventDetailsImageList[index]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                    // 🔹 Back arrow
                    Positioned(
                      left: 8,
                      top: 80,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          eventProvider.previousImage();
                        },
                      ),
                    ),
                    // 🔹 Forward arrow
                    Positioned(
                      right: 8,
                      top: 80,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          eventProvider.nextImage();
                        },
                      ),
                    ),
                    // 🔹 Dots indicator
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          eventProvider.eventDetailsModel.images!.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: eventProvider.currentIndex == index
                                  ? Colors.white
                                  : Colors.white30,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                model.eventName.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFFD1B26F), size: 18),
                  SizedBox(width: 4),
                  Text(
                    model.venueCity.toString(),
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xFFD1B26F),
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    eventProvider.eventDetailsModel.firstSessionDate.toString(),
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, color: Color(0xFFD1B26F), size: 18),
                  SizedBox(width: 4),
                  Text(
                    '${formatTimeToAmPm(eventProvider.eventDetailsModel.sessionStartTime.toString())} - ${formatTimeToAmPm(eventProvider.eventDetailsModel.sessionEndTime.toString())}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFFD1B26F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                model.description.toString(),
                style: TextStyle(color: Colors.white70),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Read More...',
                  style: TextStyle(color: Color(0xFFD1B26F), fontSize: 12),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1B26F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () async {
                      LoadingDialog.show(context);
                      await eventProvider.getEventTicketList(
                        model.id.toString(),
                      );

                      LoadingDialog.hide(context);
                      context.push("/ticket-booking");
                    },
                    child: const Text('Book Ticket'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1B26F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () async {
                      LoadingDialog.show(context);
                      await eventProvider.getTableTicketList();
                      LoadingDialog.hide(context);
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
