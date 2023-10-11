import 'package:flutter/material.dart';
import 'package:flutter_challenge/gen/assets.gen.dart';
import 'package:flutter_challenge/themes/colors.dart';
import 'package:flutter_challenge/themes/text_styles.dart';

extension ContextExtension on BuildContext {
  static const _defaultSnackbarDuration = Duration(seconds: 2);

  void showErrorSnackBar(String message) {
    _showSnackBar(
      message,
      title: "Error!",
      backgroundColor: AppColors.error,
      image: Assets.graphics.xCircle.svg(),
    );
  }

  void showSuccessSnackBar(String message) {
    _showSnackBar(
      message,
      title: "Well done!",
      backgroundColor: AppColors.success,
      image: Assets.graphics.checkCircle.svg(),
    );
  }

  void _showSnackBar(
    String message, {
    Duration duration = _defaultSnackbarDuration,
    required Widget image,
    required Color backgroundColor,
    required String title,
  }) {
    if (message.isEmpty) {
      return;
    }
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        content: Row(
          children: [
            image,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyles.h6),
                    Text(message, style: TextStyles.body2, softWrap: true),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(this).hideCurrentSnackBar(),
              child: Assets.graphics.close.svg(),
            ),
          ],
        ),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
