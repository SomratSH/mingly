import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/api_service/firebae_google_signup.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/helpers.dart';
import 'package:provider/provider.dart';
import 'package:mingly/src/screens/auth/auth_provider.dart' as Top;

import '../../../components/custom_snackbar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<Top.AuthProvider>();
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
                          // Existing Sign-Up button
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: "Sign-Up",
                              onPressed: () {
                                context.push("/signup");
                              },
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // New "Sign in with Google" button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                                side: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              icon: SvgPicture.asset(
                                'lib/assets/icons/google (1).svg', // make sure you add this image in your assets
                                height: 24.h,
                              ),
                              label: Text(
                                'Sign in with Google',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              onPressed: () async {
                                final status = await FirebaseServices()
                                    .signInWithGoogle();
                                if (status != null) {
                                  final data = await provider.signUpGoogle(
                                    status,
                                  );
                                  if (data['message'] != null) {
                                    CustomSnackbar.show(
                                      context,
                                      message: data["message"],
                                      textColor: Colors.white,
                                      backgroundColor: Colors.green,
                                    );
                                    context.push("/home");
                                  } else if (data["error"] != null) {
                                    CustomSnackbar.show(
                                      context,
                                      message: data["error"],
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                } else {
                                  CustomSnackbar.show(
                                    context,
                                    message: "Somthing wrong, try again.",
                                  );
                                }
                                print("done" + status.toString());
                                // await FirebaseServices().googleSignOut();
                              },
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Already have account? Login
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
