import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data (replace with API or local data later)
    final favourites = [
      {
        "title": "[Waves & Raves] - \nCelvaie",
        "location": "Singapore",
        "image": "lib/assets/images/demo_fav.jpg",
        "icon": "lib/assets/icons/mdi_heart.svg",
      },
      {
        "title": "Summer Beats - \nClub XYZ",
        "location": "Dubai",
        "image": "lib/assets/images/demo_fav.jpg",
        "icon": "lib/assets/icons/mdi_heart.svg",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Favourite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFFAE5),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    height: 1.56,
                  ),
                ),
              ),
            ),

            // List of favorites
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final fav = favourites[index];
                  return InkWell(
                    onTap: () => context.push('/venue-detail'),
                    child: FavouriteCard(
                      title: fav["title"]!,
                      location: fav["location"]!,
                      imagePath: fav["image"]!,
                      iconPath: fav["icon"]!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteCard extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final String iconPath;

  const FavouriteCard({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF2E2D2C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Heart icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SvgPicture.asset(iconPath),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Location
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFFF3E5E5),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
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
