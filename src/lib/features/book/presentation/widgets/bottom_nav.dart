import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return _CustomBottomNav(
      currentIndex: currentIndex,
      onTap: (index) => onTap(index),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  const _CustomBottomNav({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: context.colorTheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavSvgIcon(
              path: 'assets/icons/home.min.svg',
              onTap: () => onTap(0),
              isActive: currentIndex == 0,
            ),

            _NavSvgIcon(
              icon: Icons.explore,
              onTap: () => onTap(1),
              isActive: currentIndex == 1,
            ),
            _NavSvgIcon(
              icon: Icons.bookmark,
              onTap: () => onTap(2),
              isActive: currentIndex == 2,
            ),
            _NavSvgIcon(
              icon: Icons.person,
              onTap: () => onTap(3),
              isActive: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavSvgIcon extends StatelessWidget {
  const _NavSvgIcon({
    this.path,
    required this.onTap,
    required this.isActive,
    this.icon,
  });
  final String? path;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    Color color = isActive ? context.colorTheme.primary : AppColors.grayLighter;
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          key: ValueKey(isActive),
          curve: Curves.easeOut,
          scale: isActive ? 1.2 : 1.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: path == null
                ? Icon(icon, size: 24.sp, color: color)
                : SvgPicture.asset(
                    path!,
                    width: 22.r,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
          ),
        ),
      ),
    );
  }
}
