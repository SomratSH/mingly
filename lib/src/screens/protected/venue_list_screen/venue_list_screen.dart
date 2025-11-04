import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/couttry_city_widget.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';

class VenueListScreen extends StatefulWidget {
  const VenueListScreen({super.key});

  @override
  State<VenueListScreen> createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  String countryValue = "";

  String cityValue = "";
  String? selectedVenueType;

  final List<String> venueTypes = [
    "Rooftop / Sky Lounge",
    "Nightclub / Bar",
    "Beach Club",
    "Ballroom / Banquet Hall",
    "Private Villa / Mansion",
    "Yacht / Cruise",
    "Restaurant",
    "Lounge",
    "Poolside Venue",
    "Garden / Outdoor Terrace",
    "Hotel Conference Room",
    "Convention Center",
    "Co-working Space",
    "Exhibition Hall",
    "Auditorium / Theatre",
    "Private Members’ Club",
    "Luxury Hotel Suite",
    "Chateau / Estate",
    "Art Gallery / Museum",
    "Penthouse",
  ];

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
      final matchesSearch =
          name.contains(searchQuery) || address.contains(searchQuery);

      final matchesVenueType =
          selectedVenueType == null ||
          venue.address?.toLowerCase() == selectedVenueType!.toLowerCase();

      final matchesCountry =
          countryValue.isEmpty ||
          (venue.country?.toLowerCase() == countryValue.toLowerCase());

      final matchesCity =
          cityValue.isEmpty ||
          (venue.city?.toLowerCase() == cityValue.toLowerCase());

      return matchesSearch && matchesVenueType && matchesCountry && matchesCity;
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF7D99A), width: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.grey.shade900,
                  value: selectedVenueType,
                  hint: const Text(
                    "Select Venue Type",
                    style: TextStyle(color: Colors.white),
                  ),
                  isExpanded: true,
                  items: venueTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVenueType = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            CountryCityDropdown(
              onChanged: (country, city) {
                setState(() {
                  countryValue = country ?? "";
                  cityValue = city ?? "";
                });
              },
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

// ✅ Venue Card Widget
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
          color: const Color(0xFF2E2D2C),
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
                          Expanded(
                            child: Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
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
