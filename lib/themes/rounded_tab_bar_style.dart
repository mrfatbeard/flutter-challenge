import 'package:flutter/material.dart';

class RoundedTabBarStyle extends ThemeExtension<RoundedTabBarStyle> {
  final Color selectedTabColor;
  final Color unselectedTabColor;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;

  const RoundedTabBarStyle({
    required this.selectedTabColor,
    required this.unselectedTabColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
  });

  @override
  RoundedTabBarStyle copyWith({
    Color? selectedTabColor,
    Color? unselectedTabColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
  }) {
    return RoundedTabBarStyle(
      selectedTabColor: selectedTabColor ?? this.selectedTabColor,
      unselectedTabColor: unselectedTabColor ?? this.unselectedTabColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
    );
  }

  @override
  ThemeExtension<RoundedTabBarStyle> lerp(ThemeExtension<RoundedTabBarStyle>? other, double t) {
    if (other is! RoundedTabBarStyle) {
      return this;
    }
    return RoundedTabBarStyle(
      selectedTabColor: Color.lerp(selectedTabColor, other.selectedTabColor, t) ?? selectedTabColor,
      unselectedTabColor: Color.lerp(unselectedTabColor, other.unselectedTabColor, t) ?? unselectedTabColor,
      selectedTextStyle: TextStyle.lerp(selectedTextStyle, other.unselectedTextStyle, t) ?? selectedTextStyle,
      unselectedTextStyle: TextStyle.lerp(unselectedTextStyle, other.unselectedTextStyle, t) ?? unselectedTextStyle,
    );
  }
}
