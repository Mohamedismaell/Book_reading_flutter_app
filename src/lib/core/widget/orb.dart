import 'dart:ui';

import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/orb_position.dart';
import '../theme/app_colors.dart';

class Orb extends StatelessWidget {
  const Orb({super.key, required this.position, this.isCyan = true});

  final OrbPosition position;
  final bool isCyan;

  double orbSize(BuildContext context) {
    return context.setMinSize(200);
  }

  double radius(BuildContext context) => orbSize(context) / 2;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeOrb = orbSize(context);

    return Positioned(
      top: _top(size, context),
      bottom: _bottom(context),
      left: _left(size, context),
      right: _right(context),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
        child: Container(
          width: sizeOrb,
          height: sizeOrb,
          decoration: BoxDecoration(
            color: isCyan ? AppColors.cyan50 : AppColors.pink50,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  double? _top(Size size, BuildContext context) {
    switch (position) {
      case OrbPosition.topLeft:
      case OrbPosition.topRight:
      case OrbPosition.topCenter:
        return -radius(context);

      case OrbPosition.centerLeft:
      case OrbPosition.centerRight:
        return (size.height / 2) - radius(context);

      default:
        return null;
    }
  }

  double? _bottom(BuildContext context) {
    switch (position) {
      case OrbPosition.bottomLeft:
      case OrbPosition.bottomRight:
      case OrbPosition.bottomCenter:
        return -radius(context);
      default:
        return null;
    }
  }

  double? _left(Size size, BuildContext context) {
    switch (position) {
      case OrbPosition.topLeft:
      case OrbPosition.centerLeft:
      case OrbPosition.bottomLeft:
        return -radius(context);

      case OrbPosition.topCenter:
      case OrbPosition.bottomCenter:
        return (size.width / 2) - radius(context);

      default:
        return null;
    }
  }

  double? _right(BuildContext context) {
    switch (position) {
      case OrbPosition.topRight:
      case OrbPosition.centerRight:
      case OrbPosition.bottomRight:
        return -radius(context);
      default:
        return null;
    }
  }
}
