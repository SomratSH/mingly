import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mingly/src/constant/app_urls.dart';
import 'package:mingly/src/screens/protected/home_screen/home_proivder.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
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
          ],
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
                            AppUrls.imageUrlNgrok +
                                homeProivder.leaderBoardList[1].avatar
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
                        homeProivder.leaderBoardList[1].fullName.toString(),
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
                            AppUrls.imageUrlNgrok +
                                homeProivder.leaderBoardList[0].avatar
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
                        homeProivder.leaderBoardList[0].fullName.toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        homeProivder.leaderBoardList[0].points.toString(),
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
                        radius: 30.h,
                        backgroundColor: Colors.grey.shade800,
                        child: ClipOval(
                          child: Image.network(
                            AppUrls.imageUrlNgrok +
                                homeProivder.leaderBoardList[2].avatar
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
                        homeProivder.leaderBoardList[2].fullName.toString(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(182),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        homeProivder.leaderBoardList[2].points.toString(),
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
                          AppUrls.imageUrlNgrok +
                              homeProivder.leaderBoardList[index].avatar
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
