import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/my_reservation_screen/reservation_provider.dart';
import 'package:provider/provider.dart';

class MyReservationScreen extends StatelessWidget {
  const MyReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationProvider()..getFavouriteList(),
      child: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ReservationProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Reservations',
                  style: TextStyle(
                    color: theme.colorScheme.onBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ✅ Fix: Wrap ListView with Expanded
            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: provider.reservationList.isEmpty
                        ? Center(child: Text("No reservation"))
                        : ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            children: List.generate(
                              provider.reservationList.length,
                              (index) => InkWell(
                                onTap: () => context.push('/event-detail'),
                                child: _ReservationCard(
                                  onPressed: () async {
                                    LoadingDialog.show(context);
                                    final response = await provider
                                        .addToFavourite(
                                          provider.reservationList[index].event
                                              .toString(),
                                        );
                                    if (response["message"] != null) {
                                      CustomSnackbar.show(
                                        context,
                                        message: response["message"],
                                        backgroundColor: Colors.green,
                                      );
                                    } else {
                                      CustomSnackbar.show(
                                        context,
                                        message: "Something wrong, try again",
                                        backgroundColor: Colors.green,
                                      );
                                    }
                                    LoadingDialog.hide(context);
                                  },
                                  title: provider
                                      .reservationList[index]
                                      .eventName
                                      .toString(),
                                  location: provider.reservationList[index].city
                                      .toString(),
                                  imagePath:
                                      provider
                                          .reservationList[index]
                                          .eventPicture ??
                                      "",
                                  date: "Aug 25, 2025",
                                  status: provider.reservationList[index].status
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final String date;
  final String status;
  final Function() onPressed;

  const _ReservationCard({
    required this.title,
    required this.location,
    required this.imagePath,
    required this.date,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: imagePath == ""
                  ? Image.network(
                      "https://www.directmobilityonline.co.uk/assets/img/noimage.png",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${AppUrls.imageUrl}${imagePath}",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: status == "Confirmed"
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              color: theme.colorScheme.primary,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
