import 'package:avatar_stack/animated_avatar_stack.dart'
    show AnimatedAvatarStack;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../components/app_bars.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
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
                                'Bangkok,Thailand',
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
                          child: Image.asset(
                            'lib/assets/images/dummy_profile.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: 0.3.sh,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: const DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/dummy_yacht_event.png',
                          ), 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                              'XUYB895EW',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'lib/assets/icons/copy.svg',
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFD1B26F),
                            BlendMode.srcIn,
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
                          label: 'My Bottles',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Featured Venues
                  _SectionHeader(title: 'Featured Venues'),
                  InkWell(
                    onTap: () => context.push('/venue-detail'),
                    child: _VenueCard(
                      image: 'lib/assets/images/dummy_calavie.png',
                      title: 'Celavie',
                      location: 'Marina Bay Sands Tower 3\nLevel 57\nSingapore',
                    ),
                  ),
                  InkWell(
                    onTap: () => context.push('/venue-detail'),
                    child: _VenueCard(
                      image: 'lib/assets/images/dummy_muin.png',
                      title: 'Muin',
                      location: 'Tan Nuea, Watthana, Bangkok',
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Popular Events
                  _SectionHeader(title: 'Popular Events'),
                  InkWell(
                    onTap: () => context.push('/event-detail'),
                    child: _EventCard()),
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
                  child: Image.asset(image, fit: BoxFit.cover),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                child: Image.asset(
                  'lib/assets/images/dummy_yacht_event.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Super Yacht (Phuket)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'THU 26 May, 09:00 - FRI 27 May, 10:00',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: AnimatedAvatarStack(
                            height: 30.w,
                            infoWidgetBuilder: (surplus, context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Center(
                                  child: Text(
                                    surplus > 0 ? '+$surplus' : '',
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
                                color: Theme.of(context).colorScheme.primary
                                    .withAlpha((255 * 0.1).toInt()),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
  }
}

class _Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
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
                            'https://i.pravatar.cc/150?img=12',
                          ),
                        ),
                      ),
                      Text(
                        'Tuhin Ghoria',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '45,000,000',
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
                            'https://i.pravatar.cc/150?img=5',
                          ),
                        ),
                      ),
                      Text(
                        'Mrs. Diana',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        '45,000,000',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
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
                        radius: 30.h,
                        backgroundColor: Colors.grey.shade800,
                        child: ClipOval(
                          child: Image.network(
                            'https://i.pravatar.cc/150?img=9',
                          ),
                        ),
                      ),
                      Text(
                        'Calcutta',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '45,000,000',
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
          ...List.generate(7, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 22.w,
                    child: Text(
                      '${index + 4}',
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
                        'https://i.pravatar.cc/150?img=${index + 10}',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Name ${index + 4}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '${(24 - index * 2).toStringAsFixed(0)},000,000',
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
                  child: Image.asset(image, fit: BoxFit.cover),
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
