import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../enums/orb_position.dart';
import '../theme/app_colors.dart';

class Orb extends StatelessWidget {
  const Orb({super.key, required this.position, this.isCyan = true});

  final OrbPosition position;
  final bool isCyan;

  double orbSize() {
    return 200.sp;
  }

  double radius() => orbSize() / 2;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeOrb = orbSize();

    return Positioned(
      top: _top(size),
      bottom: _bottom(),
      left: _left(size),
      right: _right(),
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

  double? _top(Size size) {
    switch (position) {
      case OrbPosition.topLeft:
      case OrbPosition.topRight:
      case OrbPosition.topCenter:
        return -radius();

      case OrbPosition.centerLeft:
      case OrbPosition.centerRight:
        return (size.height / 2) - radius();

      default:
        return null;
    }
  }

  double? _bottom() {
    switch (position) {
      case OrbPosition.bottomLeft:
      case OrbPosition.bottomRight:
      case OrbPosition.bottomCenter:
        return -radius();
      default:
        return null;
    }
  }

  double? _left(Size size) {
    switch (position) {
      case OrbPosition.topLeft:
      case OrbPosition.centerLeft:
      case OrbPosition.bottomLeft:
        return -radius();

      case OrbPosition.topCenter:
      case OrbPosition.bottomCenter:
        return (size.width / 2) - radius();

      default:
        return null;
    }
  }

  double? _right() {
    switch (position) {
      case OrbPosition.topRight:
      case OrbPosition.centerRight:
      case OrbPosition.bottomRight:
        return -radius();
      default:
        return null;
    }
  }
}
