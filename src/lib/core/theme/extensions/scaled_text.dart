import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';

extension ScaledTextTheme on BuildContext {
  TextStyle headlineLarge() => _scale(textTheme.headlineLarge!);
  TextStyle headlineMedium() => _scale(textTheme.headlineMedium!);
  TextStyle headlineSmall() => _scale(textTheme.headlineSmall!);

  TextStyle bodyLarge() => _scale(textTheme.bodyLarge!);
  TextStyle bodyMedium() => _scale(textTheme.bodyMedium!);
  TextStyle bodySmall() => _scale(textTheme.bodySmall!);

  TextStyle labelLarge() => _scale(textTheme.labelLarge!);
  TextStyle labelMedium() => _scale(textTheme.labelMedium!);
  TextStyle labelSmall() => _scale(textTheme.labelSmall!);

  TextStyle _scale(TextStyle style) {
    final fontSize = style.fontSize;
    if (fontSize == null) return style;

    return style.copyWith(fontSize: setSp(fontSize));
  }
}
