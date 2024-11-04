// Arjun, Robert, Varun, Tamil

// 1. Home Page - Robert
// 2. Welcome Page - Arjun
// 3. Settings - Varun
// 4. Current Plan - Tamil
// 5. Form Pages (optional) - Justin

// Common components:
// - GSPage - default page + rounded corners stationary "sheet"
// - GSButton
//   - Primary
//   - Secondary
//   - Status :: Normal | Loading | Disabled
// - GSTextFormField
//   -

import 'package:flutter/material.dart';

class GSButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final bool disabled;
  final bool changeDisableColor;
  final GSButtonType buttonType;

  const GSButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.changeDisableColor = false,
    this.buttonType = GSButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final primaryBackgroundColor = theme.colorScheme.primary;
    const secondaryBackgroundColor = Colors.white;

    final backgroundColor = (disabled && changeDisableColor)
        ? theme.disabledColor
        : buttonType == GSButtonType.primary
            ? primaryBackgroundColor
            : secondaryBackgroundColor;

    final textColor = (disabled && changeDisableColor)
        ? theme.disabledColor.withOpacity(0.6)
        : buttonType == GSButtonType.primary
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSecondary;

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: loading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

enum GSButtonType { primary, secondary }
