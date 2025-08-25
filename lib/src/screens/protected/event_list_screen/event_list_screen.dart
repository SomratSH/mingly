import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Event List', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
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
                        children: const [
                          Icon(Icons.calendar_today, color: Color(0xFFD1B26F)),
                          SizedBox(width: 8),
                          Text('Date', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Search', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 0.5,
              ),
              delegate: SliverChildListDelegate([
                _EventCard(
                  onTap: () {
                    print("Event tapped");
                    context.push('/event-detail');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title:
                      '[Seascape Festival '
                      ']',
                  location: 'Lazarus Island',
                  country: 'Singapore',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: 'Sky High Soirée',
                  location: 'MU;IN',
                  country: '[bangkok] - [thailand]',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: '[Seascape Festival \'\']',
                  location: 'Lazarus Island',
                  country: 'Singapore',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: 'Sky High Soirée',
                  location: 'MU;IN',
                  country: '[bangkok] - [thailand]',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: '[Seascape Festival \'\']',
                  location: 'Lazarus Island',
                  country: 'Singapore',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: 'Sky High Soirée',
                  location: 'MU;IN',
                  country: '[bangkok] - [thailand]',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: '[Seascape Festival \'\']',
                  location: 'Lazarus Island',
                  country: 'Singapore',
                ),
                _EventCard(
                  onTap: () {
                    context.push('/event-detail-one');
                  },
                  date: 'Fri, 26 Jan 2025',
                  image: 'lib/assets/images/dummy_yacht_event.png',
                  title: 'Sky High Soirée',
                  location: 'MU;IN',
                  country: '[bangkok] - [thailand]',
                ),
              ]),
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
    return Padding(
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
                    child: Image.asset(
                      image,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location,
                          style: const TextStyle(color: Colors.white70),
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
    );
  }
}
