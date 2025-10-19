import 'dart:core';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/helpers.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';

class VenueDetailScreen extends StatelessWidget {
  const VenueDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VenueProvider>();
    final eventProvider = context.watch<EventsProvider>();
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
        title: Text(
          provider.selectedVenueData.name ?? 'Venue Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_border, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  provider.selectedVenueData.picture == null
                      ? "https://www.directmobilityonline.co.uk/assets/img/noimage.png"
                      : "${AppUrls.imageUrl}${provider.selectedVenueData.picture}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFF8E7A72), width: 0.4),
                    bottom: BorderSide(color: Color(0xFF8E7A72), width: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.grid_view, color: Color(0xFFD1B26F)),
                          SizedBox(width: 8),
                          Text(
                            'Event List',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 35, width: 1, color: Color(0xFF8E7A72)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.menu_book, color: Color(0xFFD1B26F)),
                          SizedBox(width: 8),
                          Text(
                            'View Menu',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.location_on, color: Color(0xFFD1B26F)),
                  SizedBox(width: 8),
                  Text(
                    'Address',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "${provider.selectedVenueData.address.toString()}, ${provider.selectedVenueData.city.toString()}, ${provider.selectedVenueData.state.toString()}, ${provider.selectedVenueData.country.toString()}",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.access_time, color: Color(0xFFD1B26F)),
                  SizedBox(width: 8),
                  Text(
                    'Opening hour',
                    style: TextStyle(
                      color: Color(0xFFD1B26F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Text('Friday', style: TextStyle(color: Colors.white70)),
                  SizedBox(width: 16),
                  Text(
                    '19:00 PM - 01:00 AM',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              eventProvider.eventsListVenueWise.isEmpty
                  ? Text("No event available!!")
                  : Column(
                      children: List.generate(
                        eventProvider.eventsListVenueWise.length,
                        (index) {
                          return _PopularEventCard(
                            image:
                                eventProvider
                                        .eventsListVenueWise[index]
                                        .images!
                                        .first
                                        .thumbnailImage ==
                                    null
                                ? "https://www.directmobilityonline.co.uk/assets/img/noimage.png"
                                : "${AppUrls.imageUrlNgrok}${eventProvider.eventsListVenueWise[index].images!.first.thumbnailImage}",
                            name: eventProvider
                                .eventsListVenueWise[index]
                                .eventName
                                .toString(),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD1B26F)),
                          foregroundColor: Color(0xFFD1B26F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          openMapToAddress(
                            "${provider.selectedVenueData.address.toString()}, ${provider.selectedVenueData.city.toString()}, ${provider.selectedVenueData.state.toString()}, ${provider.selectedVenueData.country.toString()}",
                          );
                        },
                        child: const Text('Direction'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFE7B9),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          // context.push("/event-detail");
                          //  eventProvider.addReserve(eventProvider.eventsListVenueWise[index].id!.toInt());
                        },
                        child: Text(
                          'Reserve',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF0E0F11),
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularEventCard extends StatelessWidget {
  String name;
  String image;

  _PopularEventCard({Key? key, required this.image, required this.name})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Image.network(
                  image!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Dance',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: Color(0xFFFFE7B9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  name!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'THU 26 May, 09:00 - 10:00',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.shade800,
                          child: Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '+15',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$30.00',
                      style: TextStyle(
                        color: const Color(0xFFE6B863),
                        fontSize: 14,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
