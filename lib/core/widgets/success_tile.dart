import 'package:flutter/material.dart';

/// A common Success Tile widget styled to mirror [ErrorTile] but with a green
/// accent. Displays a check-circle icon, title, description message, and a
/// full-width dismiss button.
class SuccessTile extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;
  final String title;
  final String buttonText;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SuccessTile({
    super.key,
    required this.message,
    required this.onDismiss,
    this.title = 'Done!',
    this.buttonText = 'Done',
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primarySuccessColor = Color(0xFF16A34A);

    return Container(
      margin: margin ?? const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success check-circle icon
              const Icon(
                Icons.check_circle_outline_rounded,
                color: primarySuccessColor,
                size: 56,
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              // Success description message
              Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF64748B),
                  height: 1.4,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              // Full-width dismiss button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onDismiss,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarySuccessColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
