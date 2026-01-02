// import 'package:bookreading/core/theme/extensions/custom_colors.dart';
// import 'package:flutter/material.dart';

// extension Contextext on BuildContext {
//   CustomColors get customColors {
//     return Theme.of(this).customColors;
//   }
// }

import 'package:flutter/material.dart';

// extension ShortTheme on BuildContext {
//   TextTheme get text => Theme.of(this).textTheme;
//   ColorScheme get colors => Theme.of(this).colorScheme;
// }

extension ShortTheme on BuildContext {
  ThemeData get themeContext => Theme.of(this);
}
