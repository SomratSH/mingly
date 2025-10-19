import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String _searchQuery = "";
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventProvider = context.watch<EventsProvider>();

    // Apply filters
    final filteredEvents = eventProvider.eventsList.where((event) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          (event.eventName?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false) ||
          (event.venueName?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false);

      final matchesDate = _selectedDate == null
          ? true
          : DateTime.tryParse('')?.toLocal().day == _selectedDate?.day;

      return matchesSearch && matchesDate;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Event List', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Search + Date Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              children: [
                // Date filter
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xFFD1B26F),
                                onPrimary: Colors.white,
                                surface: Color(0xFF1F2937),
                                onSurface: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                      await eventProvider.getEventListSearch(
                        _selectedDate.toString(),
                        _searchQuery,
                      );
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD1B26F),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _selectedDate == null
                                ? "Date"
                                : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          if (_selectedDate != null)
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  setState(() => _selectedDate = null),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Search bar
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search events...',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onChanged: (value) async {
                        setState(() => _searchQuery = value);
                        await eventProvider.getEventListSearch(
                          _selectedDate.toString(),
                          _searchQuery,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Event Grid
          Expanded(
            child: filteredEvents.isEmpty
                ? const Center(
                    child: Text(
                      "No events found",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return _EventCard(
                        onTap: () async {
                          LoadingDialog.show(context);
                          eventProvider.selectEventModelFunction(event);
                          await eventProvider.getEventsDetailsData(
                            event.id.toString(),
                          );
                          LoadingDialog.hide(context);
                          context.push("/event-detail", extra: event);
                        },
                        date: "",
                        image: event.images!.first.thumbnailImage!,
                        title: event.eventName ?? "",
                        location: event.venueName ?? "",
                        country: event.currency ?? "",
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String date;
  final String image;
  final String title;
  final String location;
  final String country;
  final Function()? onTap;

  const _EventCard({
    required this.date,
    required this.image,
    required this.title,
    required this.location,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        AppUrls.imageUrlNgrok + image,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          debugPrint("❌ Image load failed: $error");
                          return Image.network(
                            'https://www.directmobilityonline.co.uk/assets/img/noimage.png',
                            fit: BoxFit.cover,
                            height: 160,
                            width: double.infinity,
                          );
                        },

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.grey.shade300.withOpacity(0.4),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            location,
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            country,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
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
