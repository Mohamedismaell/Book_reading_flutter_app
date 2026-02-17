import 'package:bookreading/core/enums/orb_position.dart';
import 'package:bookreading/core/shared/presentation/widget/connection_banner.dart';
import 'package:bookreading/core/widget/orb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:news_app/core/connection/connection_visibility.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context) {
    // final showBanner = shouldShowConnectionBanner(location);
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Orb(position: OrbPosition.topLeft),
          Orb(position: OrbPosition.centerRight, isCyan: false),
          Orb(position: OrbPosition.bottomRight),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.h),
              child: Stack(
                children: [
                  child,
                  // if (showBanner)
                  const Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: ConnectionBanner(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
