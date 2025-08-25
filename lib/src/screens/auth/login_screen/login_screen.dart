import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../components/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                      'Welcome Back!',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Use credentials to access your account',
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
              // Login button
              PrimaryButton(
                text: 'Login',
                onPressed: () {
                  context.push("/home");
                },
              ),
              const SizedBox(height: 32),
              // Forgot password section
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Forgot password?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        context.push("/email-verification");
                      },
                      child: Text(
                        'Reset',
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
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
