import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/orb_position.dart';
import '../theme/app_colors.dart';

class Orb extends StatelessWidget {
  const Orb({super.key, required this.position, this.isCyan = true});

  final OrbPosition position;
  final bool isCyan;

  static const double _size = 200;
  static const double _radius = _size / 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: _top(size),
      bottom: _bottom,
      left: _left(size),
      right: _right,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
        child: Container(
          width: _size.w,
          height: _size.w,
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
        return -_radius.h;

      case OrbPosition.centerLeft:
      case OrbPosition.centerRight:
        return (size.height / 2) - _radius.h;

      default:
        return null;
    }
  }

  double? get _bottom {
    switch (position) {
      case OrbPosition.bottomLeft:
      case OrbPosition.bottomRight:
      case OrbPosition.bottomCenter:
        return -_radius.h;
      default:
        return null;
    }
  }

  double? _left(Size size) {
    switch (position) {
      case OrbPosition.topLeft:
      case OrbPosition.centerLeft:
      case OrbPosition.bottomLeft:
        return -_radius.w;

      case OrbPosition.topCenter:
      case OrbPosition.bottomCenter:
        return (size.width / 2) - _radius.w;

      default:
        return null;
    }
  }

  double? get _right {
    switch (position) {
      case OrbPosition.topRight:
      case OrbPosition.centerRight:
      case OrbPosition.bottomRight:
        return -_radius.w;
      default:
        return null;
    }
  }
}
