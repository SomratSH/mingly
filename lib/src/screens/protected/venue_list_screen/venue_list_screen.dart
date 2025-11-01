import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class VenueListScreen extends StatefulWidget {
  const VenueListScreen({super.key});

  @override
  State<VenueListScreen> createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final venuesProvider = context.watch<VenueProvider>();
    final eventProvider = context.watch<EventsProvider>();

    // Filtered venue list
    final filteredVenues = venuesProvider.venuesList.where((venue) {
      final name = venue.name?.toLowerCase() ?? '';
      final address = venue.address?.toLowerCase() ?? '';
      return name.contains(searchQuery) || address.contains(searchQuery);
    }).toList();
    String countryValue;
    String stateValue;
    String cityValue;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Venues', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.20,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: const Color(0xFFF7D99A),
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Thailand',
                      items: const [
                        DropdownMenuItem(
                          value: 'Thailand',
                          child: Row(
                            children: [
                              Icon(Icons.public, color: Color(0xFFD1B26F)),
                              SizedBox(width: 8),
                              Text(
                                'Thailand',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Singapore',
                          child: Row(
                            children: [
                              Icon(Icons.public, color: Color(0xFFD1B26F)),
                              SizedBox(width: 8),
                              Text(
                                'Singapore',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      dropdownColor: Colors.grey.shade900,
                      iconEnabledColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'All cities',
                      items: const [
                        DropdownMenuItem(
                          value: 'All cities',
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color(0xFFD1B26F),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'All cities',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Bangkok',
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color(0xFFD1B26F),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Bangkok',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Singapore',
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Color(0xFFD1B26F),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Singapore',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      dropdownColor: Colors.grey.shade900,
                      iconEnabledColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.20,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: const Color(0xFFF7D99A),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔍 Search Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  hintText: 'Search venues...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // 📋 Venue list (filtered)
            Expanded(
              child: filteredVenues.isEmpty
                  ? const Center(
                      child: Text(
                        "No venues found",
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await venuesProvider.getVenuesList();
                      },
                      child: ListView.builder(
                        itemCount: filteredVenues.length,
                        itemBuilder: (context, index) {
                          final venue = filteredVenues[index];
                          return _VenueCard(
                            onTap: () async {
                              LoadingDialog.show(context);
                              venuesProvider.selectedVenue(venue.id);
                              await eventProvider.getEvetListVuneWise(
                                venue.id!.toInt(),
                              );
                              await venuesProvider.getVenueMenuList(
                                venue.id!.toInt(),
                              );
                              LoadingDialog.hide(context);
                              context.push("/venue-detail");
                            },
                            image:
                                venue.images!.isEmpty ||
                                    venue.images!.first.imageUrl == null
                                ? "https://www.directmobilityonline.co.uk/assets/img/noimage.png"
                                : "${AppUrls.imageUrl}${venue.images!.first.imageUrl!}",
                            title: venue.name ?? '',
                            location: venue.address ?? '',
                            time: venue.openingHours!.isEmpty
                                ? ""
                                : "${venue.openingHours![0].open} - ${venue.openingHours![0].close}",
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reuse your _VenueCard widget (assuming it's already defined elsewhere)

class _VenueCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String time;
  final Function()? onTap;
  const _VenueCard({
    required this.image,
    required this.title,
    required this.location,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Color(0xFF2E2D2C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    image,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
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
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            location,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white54,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                time,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
