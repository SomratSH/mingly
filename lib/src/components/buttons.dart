import 'package:flutter/material.dart';

/// A customizable gradient button component.
///
/// This button displays a gradient background with two colors.
/// You can set [fullWidth] to make the button expand to the maximum width,
/// or leave it to wrap its content.
///
/// Example usage:
/// ```dart
/// GradientButton(
///   onPressed: () {},
///   text: 'Click Me',
///   gradientColors: [Colors.blue, Colors.purple],
///   fullWidth: true,
/// )
/// ```
class GradientButton extends StatelessWidget {
  /// The callback when the button is pressed.
  final VoidCallback onPressed;

  /// The text displayed on the button.
  final String text;

  /// The two colors used for the gradient background.
  final List<Color> gradientColors;

  /// If true, the button will expand to fill the available width.
  /// If false, the button will wrap its content.
  final bool fullWidth;

  /// Optional: The border radius of the button.
  final double borderRadius;

  /// Optional: The height of the button.
  final double height;

  /// Optional: The text style.
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.gradientColors,
    this.fullWidth = false,
    this.borderRadius = 8.0,
    this.height = 48.0,
    this.textStyle,
  })  : assert(gradientColors.length == 2, 'Provide exactly two colors for the gradient.');

  @override
  Widget build(BuildContext context) {
    final buttonChild = Container(
      height: height,
      padding: fullWidth ? null : const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: buttonChild,
        ),
      ),
    );
  }
}