import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/screens/auth/auth_provider.dart';
import 'package:mingly/src/screens/protected/event_detail_screen/widget/custom_dialog_membership.dart';
import 'package:provider/provider.dart';

import '../../../components/helpers.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

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
                onChanged: (value) {},
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
                onPressed: () async {
                  LoadingDialog.show(context);
                  final status = await provider.signUpUser();
                  if (status['message'] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["message"],
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                    context.push("/otp-verification");
                  } else if (status["email"] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["email"][0],
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
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
