import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../components/helpers.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Sign up to join exclusive events',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Username field
              SingleLineTextField(
                controller: emailController,
                hintText: "Enter Email",
                prefixSvg: SvgPicture.asset(
                  'lib/assets/icons/profile.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password field
              PasswordInputField(
                controller: passwordController,
                hintText: "Enter Password",
                onChanged: (value) {
                  setState(() {
                  });
                },
                prefixSvg: SvgPicture.asset(
                  'lib/assets/icons/lock.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Signup button
              PrimaryButton(
                text: 'Sign Up',
                onPressed: () {
                  context.push("/email-verification");
                },
              ),
              const SizedBox(height: 32),
              // Referral code
              Text(
                'Referral Code (Optional)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    hintText: 'Referral Code',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
