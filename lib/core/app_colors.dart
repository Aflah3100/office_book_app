import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color scaffoldBackground = Color(0xFF121212); // Main dark background
  static const Color cardBackground = Color(0xFF1F1F1F);     // Cards / task containers

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3);       // Light gray text
  static const Color textTertiary = Color(0xFF707070);        // Darker gray text

  // Accent / Primary Colors
  static const Color primaryOrange = Color(0xFFFF5E00);       // Main orange (used in buttons)
  static const Color primaryOrangeLight = Color(0xFFFF8C42);  // Lighter orange for hover/active

  // Other UI elements
  static const Color dividerColor = Color(0xFF2C2C2C);         // Divider and borders
  static const Color inactiveDateColor = Color(0xFF5C5C5C);    // Non-selected dates
  static const Color selectedDateColor = primaryOrange;        // Selected date background

  // Timeline Blocks
  static const Color workspaceGreen = Color(0xFF00C896);       // Example: UNIQLO workspace block
  static const Color workspacePurple = Color(0xFF7353EA);      // Example: POS Foodie workspace
  static const Color workspaceRed = Color(0xFFFF4C4C);         // Example: Private workspace tasks

  // Icons
  static const Color iconColor = Colors.white;

  // Button
  static const Color buttonBackground = primaryOrange;
  static const Color buttonText = Colors.white;
}