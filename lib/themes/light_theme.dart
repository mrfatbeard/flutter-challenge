import 'package:flutter/material.dart';
import 'package:flutter_challenge/gen/fonts.gen.dart';
import 'package:flutter_challenge/themes/colors.dart';
import 'package:flutter_challenge/themes/rounded_tab_bar_style.dart';
import 'package:flutter_challenge/themes/text_styles.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: FontFamily.tTNorms,
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    constraints: const BoxConstraints(maxHeight: 46),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightPrimary),
      borderRadius: BorderRadius.circular(24),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightForeground.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(24),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightPrimary),
      borderRadius: BorderRadius.circular(24),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: TextStyles.body1.copyWith(color: AppColors.lightForeground),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyles.body1,
    labelSmall: TextStyles.button,
  ),
  colorScheme: const ColorScheme.light(
    background: AppColors.lightBackground,
    onBackground: AppColors.lightForeground,
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
    error: AppColors.error,
  ),
  extensions: [
    RoundedTabBarStyle(
      selectedTabColor: AppColors.royalBlue600,
      unselectedTabColor: AppColors.lightSecondary,
      selectedTextStyle: TextStyles.button.copyWith(
        fontFamily: FontFamily.tTNorms,
        color: Colors.white,
      ),
      unselectedTextStyle: TextStyles.button.copyWith(
        fontFamily: FontFamily.tTNorms,
        color: AppColors.lightForeground,
      ),
    ),
  ],
);
