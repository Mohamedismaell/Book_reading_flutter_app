import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:flutter/material.dart';

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
                return Icon(Icons.star, size: context.setSp(23), color: value);
              },
            ),
          ),
        ),
        SizedBox(width: context.setWidth(8)),
        Text("4.0", style: context.bodyLarge()),
      ],
    );
  }
}
