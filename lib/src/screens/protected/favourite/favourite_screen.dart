import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/favourite/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavouriteProvider()..getFavouriteList(),
      child: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavouriteProvider>();

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
              child: provider.favouriteList.isEmpty
                  ? Center(child: Text("No favourite"))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: provider.favouriteList.length,
                      itemBuilder: (context, index) {
                        final fav = provider.favouriteList[index];
                        return InkWell(
                          onTap: () => context.push('/venue-detail'),
                          child: FavouriteCard(
                            title: fav.eventName.toString(),
                            location:
                                "${fav.address.toString()}, ${fav.city.toString()}, ${fav.state.toString()}, ${fav.country.toString()}",
                            imagePath: fav.eventPicture ?? "",
                            iconPath: "lib/assets/icons/mdi_heart.svg",
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
                child: imagePath == ""
                    ? Image.network(
                        "https://www.directmobilityonline.co.uk/assets/img/noimage.png",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "${AppUrls.imageUrl}${imagePath}",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                        errorBuilder: (context, error, stackTrace) {
                          if (error is NetworkImageLoadException &&
                              error.statusCode == 404) {
                            print("image error " + error.statusCode.toString());
                            return Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey[500],
                              child: const Icon(Icons.image_not_supported),
                            );
                          } else {
                            return Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey[500],
                              child: const Icon(Icons.image_not_supported),
                            );
                          }
                        },
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
