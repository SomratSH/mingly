import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/helpers.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Reset Password', style: TextStyle(fontSize: 20)),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'Set New Password',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            // New Password field
            Text(
              'New Password',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            PasswordInputField(
              controller: TextEditingController(),
              hintText: 'Enter new password',
            ),
            const SizedBox(height: 24),
            // Confirm Password field
            Text(
              'Confirm Password',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            PasswordInputField(
              controller: TextEditingController(),
              hintText: 'Confirm new password',
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: 'Reset Password', onPressed: () {
              context.go("/login");
            }),
          ],
        ),
      ),
    );
  }
}
