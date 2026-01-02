import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  //! Common
  static const Color white = Color(0xFFFFFFFF);

  static const Color eboneyClay = Color(0xFF2E3148);
  static const Color paleSky = Color(0xFF6B7280);
  static const Color athensGray = Color(0xFFE0E2EE);
  static const Color flamingo = Color(0xFFEF4444);
  static const Color gullGray = Color(0xFF9CA3AF);
  static const Color riverBed = Color(0xFF4B5563);
  static const Color slateGray = Color(0xFF64748B);

  //! Active Back Ground Color
  static const Color backGround = Color(0xFFE6EEFF);
  //! white container
  static final Color whiteContainer = Colors.white.withOpacity(0.6);
  // //! Not Active Back Ground Color
  // static const LinearGradient backGround = LinearGradient(
  //   colors: [Color(0xFFFFFFFF), Color(0xFFE6EEFF)],
  //   stops: [0.0, 1.0],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
  static const LinearGradient brandBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [eboneyClay, Color(0xFF4A5678)],
  );

  //! Dark Mode Colors
  static const Color linearGround1 = Color(0xFF252836);
  static const Color linearGround2 = Color(0xFF0F1014);
  static LinearGradient darkbackGround = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [linearGround1, linearGround2],
  );
}

//  buttonSelected: Color(0xFF6C7FFF), // Lighter purple for dark mode
//       buttonUnselected: Color(0xFF2A2A2A), // Dark grey
//       buttonTextSelected: Colors.white,
//       buttonTextUnselected: Color(0xFFB0B0B0),
