import 'package:avatar_stack/animated_avatar_stack.dart'
    show AnimatedAvatarStack;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/home_screen/home_proivder.dart';
import 'package:mingly/src/screens/protected/profile_screen/profile_provider.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileProvider = context.watch<ProfileProvider>();
    final homeProvider = context.watch<HomeProivder>();
    final eventsProvider = context.watch<EventsProvider>();
    final venueProvider = context.watch<VenueProvider>();
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: Color(0xFFD1B26F),
          onPressed: () {
            context.push("/ai-chat");
          },
          child: Image.asset(
            "lib/assets/images/bot.png",
            height: 30,
            width: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await homeProvider.getHomeData();
            await profileProvider.getProfile();
            await eventsProvider.getEventList();
            await venueProvider.getVenuesList();
            await venueProvider.getFeaturedVenuesList();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                floating: true,
                snap: true,
                pinned: false,
                toolbarHeight: 70.h,
                title: null,
                leadingWidth: 0,
                surfaceTintColor: theme.colorScheme.surface,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'lib/assets/icons/location.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFFD1B26F),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  homeProvider.addressUser,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.grey.shade800,
                          child: ClipOval(
                            child: Builder(
                              builder: (context) {
                                final profileModel =
                                    profileProvider.profileModel;
                                final avatar = profileModel?.data?.avatar;

                                if (profileModel == null) {
                                  // Still loading the profile
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (avatar != null && avatar.isNotEmpty) {
                                  // Avatar available
                                  return Image.network(
                                    AppUrls.imageUrl + avatar,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  );
                                } else {
                                  // Avatar not available — show fallback asset
                                  return Image.asset(
                                    'lib/assets/images/dummy_profile.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top image
                    CarouselSlider.builder(
                      itemCount: homeProvider.addImageList.length,
                      options: CarouselOptions(
                        height: 0.3.sh, // requires flutter_screenutil
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        viewportFraction: 0.8,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                AppUrls.imageUrlNgrok + homeProvider.addImageList[index].imageUrl.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    // Referral code
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Referral Code',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                profileProvider.profileModel.data == null
                                    ? "N/A"
                                    : profileProvider
                                              .profileModel
                                              .data!
                                              .referralCode ??
                                          "N/A",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: 'XUYB895EW'),
                              );
                              CustomSnackbar.show(
                                context,
                                message: "Code copied: 'XUYB895EW'",
                              );
                            },
                            child: SvgPicture.asset(
                              'lib/assets/icons/copy.svg',
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFD1B26F),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Menu icons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _MenuIcon(
                            svgAsset: 'lib/assets/icons/calendar.svg',
                            label: 'Events',
                            onTap: () {
                              context.push('/event-list');
                            },
                          ),
                          _MenuIcon(
                            svgAsset: 'lib/assets/icons/map.svg',
                            label: 'Venues',
                            onTap: () {
                              context.push('/venue-list');
                            },
                          ),
                          _MenuIcon(
                            svgAsset: 'lib/assets/icons/coupon.svg',
                            label: 'Membership',
                            onTap: () => context.push('/membership'),
                          ),
                          _MenuIcon(
                            onTap: () => context.push('/my-bottles'),
                            svgAsset: 'lib/assets/icons/bottle.svg',
                            label: 'My Menu',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Featured Venues
                    _SectionHeader(title: 'Featured Venues'),

                    venueProvider.venuesFeaturedList.isEmpty
                        ? SizedBox()
                        : Column(
                            children: List.generate(
                              venueProvider.venuesFeaturedList.length,
                              (index) => InkWell(
                                onTap: () async {
                                  LoadingDialog.show(context);
                                  venueProvider.selectedVenue(
                                    venueProvider.venuesFeaturedList[index].id,
                                  );
                                  await eventsProvider.getEvetListVuneWise(
                                    venueProvider.venuesFeaturedList[index].id!
                                        .toInt(),
                                  );
                                  await venueProvider.getVenueMenuList(
                                    venueProvider.venuesFeaturedList[index].id!
                                        .toInt(),
                                  );
                                  LoadingDialog.hide(context);
                                  context.push("/venue-detail");
                                },
                                child: _VenueCard(
                                  image:
                                      venueProvider
                                              .venuesFeaturedList[index]
                                              .images!
                                              .isEmpty ||
                                          venueProvider
                                                  .venuesFeaturedList[index]
                                                  .images!
                                                  .first
                                                  .imageUrl ==
                                              null
                                      ? "https://www.directmobilityonline.co.uk/assets/img/noimage.png"
                                      : "${AppUrls.imageUrlNgrok}${venueProvider.venuesFeaturedList[index].images!.first.imageUrl!}",
                                  title: 'Celavie',
                                  location:
                                      'Marina Bay Sands Tower 3\nLevel 57\nSingapore',
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 12.h),
                    // Popular Events
                    _SectionHeader(title: 'Popular Events'),
                    _EventCard(),
                    const SizedBox(height: 24),
                    // Top 10 spenders
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Leaderboard',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            'Top 10 spenders',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Leaderboard(),
                    const SizedBox(height: 24),
                    // Recommendations
                    _SectionHeader(title: 'Recommendations for you'),
                    InkWell(
                      onTap: () => context.push('/venue-detail'),
                      child: _RecommendationCard(
                        image: 'lib/assets/images/dummy_calavie.png',
                        title: 'Sky High Soirée- MU;IN',
                        location: 'New York',
                        tag: 'Gold member',
                      ),
                    ),
                    InkWell(
                      onTap: () => context.push('/event-detail'),
                      child: _RecommendationCard(
                        image: 'lib/assets/images/dummy_muin.png',
                        title: '[Waves & Raves ] - Celvaie',
                        location: 'California',
                        tag: 'Free',
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  final String svgAsset;
  final String label;
  final VoidCallback? onTap;
  const _MenuIcon({required this.svgAsset, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: Colors.grey.shade900,
            child: SvgPicture.asset(
              svgAsset,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 28.h,
              height: 28.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              fontSize: 15.sp,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _VenueCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  const _VenueCard({
    required this.image,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                height: 90.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(image, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventsProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: eventProvider.popularEventModel.topPopularEvents == null
          ? SizedBox()
          : Column(
              children: List.generate(
                eventProvider.popularEventModel.topPopularEvents!.length,
                (index) {
                  return InkWell(
                    onTap: () async {
                      LoadingDialog.show(context);
                      // eventProvider.selectEventModelFunction(event);
                      await eventProvider.getEventsDetailsData(
                        eventProvider
                            .popularEventModel
                            .topPopularEvents![index]
                            .id
                            .toString(),
                      );
                      LoadingDialog.hide(context);
                      context.push(
                        "/event-detail",
                        extra: eventProvider.eventsList[index],
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 140,
                              child:
                                  eventProvider
                                          .popularEventModel
                                          .topPopularEvents![index]
                                          .picture ==
                                      null
                                  ? Image.network(
                                      "https://www.directmobilityonline.co.uk/assets/img/noimage.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      AppUrls.imageUrl +
                                          eventProvider
                                              .popularEventModel
                                              .topPopularEvents![index]
                                              .picture
                                              .toString(),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventProvider
                                        .popularEventModel
                                        .topPopularEvents![index]
                                        .eventName
                                        .toString(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'THU 26 May, 09:00 - FRI 27 May, 10:00',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: AnimatedAvatarStack(
                                          height: 30.w,
                                          infoWidgetBuilder:
                                              (surplus, context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50.r,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      surplus > 0
                                                          ? '+$surplus'
                                                          : '',
                                                      style: TextStyle(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.onPrimary,
                                                        fontSize: 12.sp,
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                          avatars: [
                                            for (var n = 0; n < 10; n++)
                                              NetworkImage(
                                                'https://i.pravatar.cc/150?img=$n',
                                              ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 30,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(
                                                    (255 * 0.1).toInt(),
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProivder = context.watch<HomeProivder>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              homeProivder.leaderBoardList.isEmpty
                  ? SizedBox()
                  : Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(128),
                              ),
                            ),
                            CircleAvatar(
                              radius: 36.h,
                              backgroundColor: Colors.grey.shade800,
                              child: ClipOval(
                                child: Image.network(
                                  AppUrls.imageUrl +
                                      homeProivder.leaderBoardList[1].image
                                          .toString(),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            ),
                            Text(
                              homeProivder.leaderBoardList[1].fullName
                                  .toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(182),
                                fontSize: 13.sp,
                              ),
                            ),
                            Text(
                              homeProivder.leaderBoardList[1].points.toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(136),
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      CircleAvatar(
                        radius: 40.h,
                        backgroundColor: Colors.grey.shade800,
                        child: ClipOval(
                          child: Image.network(
                            (homeProivder.leaderBoardList.isNotEmpty &&
                                    homeProivder.leaderBoardList[0].image !=
                                        null)
                                ? AppUrls.imageUrl +
                                      homeProivder.leaderBoardList[0].image!
                                : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),

                      Text(
                        homeProivder.leaderBoardList.isEmpty ||
                                homeProivder.leaderBoardList[0].fullName == null
                            ? "N/A"
                            : homeProivder.leaderBoardList[0].fullName
                                  .toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        homeProivder.leaderBoardList.isEmpty
                            ? " N/A"
                            : homeProivder.leaderBoardList[0].points.toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(136),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(
                        '3',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(128),
                        ),
                      ),
                      CircleAvatar(
                        radius: 40.h,
                        backgroundColor: Colors.grey.shade800,
                        child: ClipOval(
                          child: Image.network(
                            (homeProivder.leaderBoardList.isNotEmpty &&
                                    homeProivder.leaderBoardList[2].image !=
                                        null)
                                ? AppUrls.imageUrl +
                                      homeProivder.leaderBoardList[2].image!
                                : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                      Text(
                        homeProivder.leaderBoardList.isEmpty
                            ? "N/A"
                            : homeProivder.leaderBoardList[2].fullName
                                  .toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        homeProivder.leaderBoardList.isEmpty
                            ? "N/A"
                            : homeProivder.leaderBoardList[2].points.toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(136),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.w),
          Divider(
            indent: 0,
            height: 1,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
          ),
          SizedBox(height: 10.w),
          // List of spenders
          ...List.generate(homeProivder.leaderBoardList.length, (index) {
            if (index != 0 && index != 1 && index != 2) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 22.w,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 13.sp,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    CircleAvatar(
                      radius: 28.h,
                      backgroundColor: Colors.grey.shade800,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          AppUrls.imageUrl +
                              homeProivder.leaderBoardList[index].image
                                  .toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                fit: BoxFit.cover,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            homeProivder.leaderBoardList[index].fullName
                                .toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '${homeProivder.leaderBoardList[index].points}',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(128),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final String title;
  final String location;
  final String tag;
  final String image;
  const _RecommendationCard({
    required this.title,
    required this.location,
    required this.tag,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventsProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child:
          eventProvider.recomendedEventModel.recommended == null ||
              eventProvider.recomendedEventModel.recommended!.isEmpty
          ? SizedBox()
          : Column(
              children: List.generate(
                eventProvider.recomendedEventModel.recommended!.length,
                (index) {
                  return InkWell(
                    onTap: () async {
                      LoadingDialog.show(context);
                      // eventProvider.selectEventModelFunction(event);
                      await eventProvider.getEventsDetailsData(
                        eventProvider
                            .recomendedEventModel
                            .recommended![index]
                            .id
                            .toString(),
                      );
                      LoadingDialog.hide(context);
                      context.push(
                        "/event-detail",
                        extra: eventProvider.eventsList[index],
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 140,
                              child:
                                  eventProvider
                                          .recomendedEventModel
                                          .recommended![index]
                                          .picture ==
                                      null
                                  ? Image.network(
                                      "https://www.directmobilityonline.co.uk/assets/img/noimage.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      AppUrls.imageUrl +
                                          eventProvider
                                              .recomendedEventModel
                                              .recommended![index]
                                              .picture
                                              .toString(),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventProvider
                                        .recomendedEventModel
                                        .recommended![index]
                                        .eventName
                                        .toString(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'THU 26 May, 09:00 - FRI 27 May, 10:00',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: AnimatedAvatarStack(
                                          height: 30.w,
                                          infoWidgetBuilder:
                                              (surplus, context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50.r,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      surplus > 0
                                                          ? '+$surplus'
                                                          : '',
                                                      style: TextStyle(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.onPrimary,
                                                        fontSize: 12.sp,
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                          avatars: [
                                            for (var n = 0; n < 10; n++)
                                              NetworkImage(
                                                'https://i.pravatar.cc/150?img=$n',
                                              ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 30,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(
                                                    (255 * 0.1).toInt(),
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
