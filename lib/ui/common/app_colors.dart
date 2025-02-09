import 'package:expense_tracker/services/expense_service.dart';
import 'package:flutter/material.dart';

import '../../app/app.locator.dart';

const Color kcPrimaryColor = Color(0xFF53697A);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFF5F5F5);
const Color kcBackgroundColor = kcDarkGreyColor;
const Color kcWhiteColor = Colors.white;
const Color kcBlackColor = Colors.black;


Color getBackgroundColor() {
  final themeService = locator<ExpenseService>();
  return themeService.darkMode.value ? kcBlackColor : kcWhiteColor;
}

Color getIconTextColor() {
  final themeService = locator<ExpenseService>();
  return themeService.darkMode.value ? kcWhiteColor : kcBlackColor;
}

Color getCardColor() {
  final themeService = locator<ExpenseService>();
  return themeService.darkMode.value ? kcMediumGrey : kcVeryLightGrey;
}