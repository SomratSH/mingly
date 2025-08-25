import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mingly/src/components/buttons.dart';

import 'inputs.dart';

/// A customizable primary button widget that displays a gradient background.
/// 
/// This widget wraps a [GradientButton] and provides a consistent style for primary actions.
/// 
/// - [text]: The label displayed on the button.
/// - [onPressed]: The callback triggered when the button is pressed.
/// 
/// The button uses a fixed gradient color scheme and does not expand to full width.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return GradientButton(
      text: text,
      onPressed: onPressed,
      gradientColors: const [Color(0xFFF7D99A), Color(0xFFC3A266)],
      fullWidth: false,
      textStyle: TextStyle(
        color: onPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
    );
  }
}

/// A single-line text field using [CustomInputField] from inputs.dart.
/// 
/// - [controller]: Controls the text being edited.
/// - [hintText]: Placeholder text shown when the field is empty.
/// - [onChanged]: Callback when the text changes.

class SingleLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget? prefixSvg;

  const SingleLineTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.prefixSvg,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      maxLines: 1,
      minLines: 1,
      isMultiline: false,
      isPassword: false,
      prefixSvg: prefixSvg as SvgPicture?,
    );
  }
}

/// A password input field using [CustomInputField] from inputs.dart.
/// 
/// This widget provides a secure text field for password entry, hiding the input by default.
/// 
/// - [controller]: Controls the text being edited.
/// - [hintText]: Placeholder text shown when the field is empty.
/// - [onChanged]: Callback when the text changes.
/// - [obscureText]: Whether to obscure the text (defaults to true).
/// 
/// The field uses a single line and disables suggestions and autocorrect for privacy.


class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget? prefixSvg;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.prefixSvg,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}


class _PasswordInputFieldState extends State<PasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.controller,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
      maxLines: 1,
      minLines: 1,
      isMultiline: false,
      isPassword: true,
      prefixSvg: widget.prefixSvg as SvgPicture?,
    );
  }
}

