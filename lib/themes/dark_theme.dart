import 'package:flutter/material.dart';
import 'package:flutter_challenge/gen/fonts.gen.dart';
import 'package:flutter_challenge/themes/colors.dart';
import 'package:flutter_challenge/themes/rounded_tab_bar_style.dart';
import 'package:flutter_challenge/themes/text_styles.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: FontFamily.tTNorms,
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    constraints: const BoxConstraints(maxHeight: 46),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkPrimary),
      borderRadius: BorderRadius.circular(24),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.darkForeground.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(24),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkPrimary),
      borderRadius: BorderRadius.circular(24),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: TextStyles.body1.copyWith(color: AppColors.darkForeground),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyles.body1,
    labelSmall: TextStyles.button,
  ),
  colorScheme: const ColorScheme.light(
    background: AppColors.darkBackground,
    onBackground: AppColors.darkForeground,
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    error: AppColors.error,
  ),
  extensions: [
    RoundedTabBarStyle(
      selectedTabColor: AppColors.royalBlue600,
      unselectedTabColor: AppColors.darkSecondary,
      selectedTextStyle: TextStyles.button.copyWith(
        fontFamily: FontFamily.tTNorms,
        color: Colors.white,
      ),
      unselectedTextStyle: TextStyles.button.copyWith(
        fontFamily: FontFamily.tTNorms,
        color: Colors.white,
      ),
    ),
  ],
);
