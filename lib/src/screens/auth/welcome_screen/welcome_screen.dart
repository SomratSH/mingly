import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/helpers.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 55,
              child: Image.asset(
                'lib/assets/images/entry_banner.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.all(16).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.h),
                      child: Text(
                        'Private Jet  .  Yacht  .  Event',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text(
                          'Elite Networking & Dating Events',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Discretion as a Cornerstone',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                            text: "Sign-Up",
                            onPressed: () {
                              context.push("/signup");
                            },
                            ),
                          ],
                          ),
                          Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Text(
                              'Already have an account?',
                              style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                              context.push("/login");
                              },
                              child: Text(
                              'Login',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              ),
                            ),
                            ],
                          ),
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
      ),
    );
  }
}
