import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Star extends StatefulWidget {
  const Star({super.key});

  @override
  State<Star> createState() => StarState();
}

class StarState extends State<Star> {
  bool isActive = false;
  final Color activatedColor = Colors.yellow;
  final Color deactivatedColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isActive = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: List.generate(
            4,
            (index) => TweenAnimationBuilder<Color?>(
              duration: Duration(milliseconds: 500 + index * 500),
              tween: ColorTween(
                begin: deactivatedColor,
                end: isActive ? activatedColor : deactivatedColor,
              ),
              builder: (context, value, child) {
                return Icon(Icons.star, size: 20.sp, color: value);
              },
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text("4.0", style: context.textTheme.bodyLarge),
      ],
    );
  }
}
