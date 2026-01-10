import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  int _locationToIndex(String location) {
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.bookDetails)) return 1;
    // if (location.startsWith(AppRoutes.profile)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);
    return _CustomBottomNav(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.home);
            break;
          case 1:
            context.go(AppRoutes.bookDetails);
            break;
        }
      },
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
      // width: context.sizeProvider.width,
      height: context.setMinSize(80),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        color: context.colorTheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.setMinSize(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavSvgIcon(
              path: 'assets/icons/home.svg',
              onTap: () => onTap(0),
              isActive: currentIndex == 0,
            ),

            _NavSvgIcon(
              path: 'assets/icons/book.svg',
              onTap: () => onTap(1),
              isActive: currentIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavSvgIcon extends StatelessWidget {
  const _NavSvgIcon({
    required this.path,

    required this.onTap,
    required this.isActive,
  });
  final String path;
  final VoidCallback onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.setMinSize(80),
      child: InkWell(
        onTap: () => onTap(),
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 220),
          tween: ColorTween(
            begin: AppColors.grayLighter,
            end: isActive ? context.colorTheme.primary : AppColors.grayLighter,
          ),
          builder: (BuildContext context, Color? value, Widget? child) {
            return SvgPicture.asset(
              path,
              colorFilter: ColorFilter.mode(value!, BlendMode.srcIn),
            );
          },
        ),
      ),
    );
  }
}
