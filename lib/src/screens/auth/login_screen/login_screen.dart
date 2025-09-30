import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/screens/auth/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/helpers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<AuthProvider>();
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
                controller: provider.emailController,
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
                controller: provider.passwordController,
                hintText: "Enter Password",

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
                onPressed: () async {
                  LoadingDialog.show(context);
                  final status = await provider.login();
                  if (status['message'] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["message"],
                      textColor: Colors.white,
                      backgroundColor: Colors.green,
                    );
                    context.push("/home");
                  } else if (status["error"] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["error"],
                      backgroundColor: Colors.red,
                    );
                  }
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
