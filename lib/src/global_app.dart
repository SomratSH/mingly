import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/app_router.dart';
import 'package:mingly/src/screens/auth/email_verification_screen/email_verification_screen.dart';
// Auth screens
import 'package:mingly/src/screens/auth/welcome_screen/welcome_screen.dart';
import 'package:mingly/src/screens/auth/signup_screen/signup_screen.dart';
import 'package:mingly/src/screens/auth/password_reset_screen/password_reset_screen.dart';
import 'package:mingly/src/screens/auth/otp_verification_screen/otp_verification_screen.dart';
import 'package:mingly/src/screens/auth/login_screen/login_screen.dart';
import 'package:mingly/src/screens/protected/event_detail_screen/event_details_screen_one.dart';
// Protected screens
import 'screens/protected/booking_confirmation_screen/booking_confirmation_screen.dart';
import 'screens/protected/event_detail_screen/event_detail_screen.dart';
import 'screens/protected/event_list_screen/event_list_screen.dart';
import 'screens/protected/food_menu_screen/food_menu_screen.dart';
import 'screens/protected/home_screen/home_screen.dart';
import 'screens/protected/membership_screen/membership_screen.dart';
import 'screens/protected/my_reservation_screen/my_reservation_screen.dart';
import 'screens/protected/notification_screen/notification_screen.dart';
import 'screens/protected/personal_info_screen/personal_info_screen.dart';
import 'screens/protected/profile_screen/profile_screen.dart';
import 'screens/protected/select_country_screen/select_country_screen.dart';
import 'screens/protected/select_payment_screen/select_payment_screen.dart';
import 'screens/protected/table_booking_screen/table_booking_screen.dart';
import 'screens/protected/ticket_booking_screen/ticket_booking_screen.dart';
import 'screens/protected/venue_detail_screen/venue_detail_screen.dart';
import 'screens/protected/venue_list_screen/venue_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mingly/src/app_router.dart';

class GlobalApp extends StatelessWidget {
  const GlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define app colors
    const Color primary = Color(0xFFD1B26F); // Gold
    const Color primaryLight = Color(0xFFFCECC2); // Light Gold
    const Color backgroundPrimary = Color(0xFF181818); // Dark background
    const Color lightBackground = Color(0xFF232323); // Lighter dark
    const Color onSurface = Color(0xFFFDFDFD); // Primary text color
    const Color onPrimary = backgroundPrimary; // Text color on primary

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Party Booking App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Gotham',
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: primary,
            onPrimary: onPrimary,
            secondary: primaryLight,
            onSecondary: onPrimary,
            surface: backgroundPrimary,
            onSurface: onSurface,
            primaryContainer: lightBackground,
            error: Colors.red,
            onError: Colors.white,
          ),
          scaffoldBackgroundColor: backgroundPrimary,
          appBarTheme: const AppBarTheme(
            backgroundColor: lightBackground,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        routerConfig: AppRouter.router, // Use GoRouter
      ),
    );
  }
}
