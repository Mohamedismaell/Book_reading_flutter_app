import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/widget/action_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//Todo Adjust Text content in every dialog
class AuthDialog extends StatelessWidget {
  const AuthDialog({
    super.key,
    required this.title,
    required this.actionText,
    this.description,
    required this.onPressed,
  });
  final String title;
  final String? description;
  final String actionText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.nearBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: context.setWidth(30)),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: _Content(
        title: title,
        description: description ?? "",
        actionText: actionText,
        onPressed: onPressed,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.description,
    required this.actionText,
    required this.onPressed,
  });

  final String title;
  final String description;
  final String actionText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.setMinSize(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CheckIcon(),
          SizedBox(height: context.setHeight(30)),
          Text(title, style: context.labelLarge()),
          SizedBox(height: context.setHeight(12)),
          Text(
            description,

            textAlign: TextAlign.center,
            style: context.bodyMedium(),
          ),
          SizedBox(height: context.setHeight(30)),
          // ToDo make it pop in resest and go in sign up
          ActionAuthButton(myText: actionText, onPressed: onPressed),
        ],
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon();

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(90, 90),
      width: context.setMinSize(90),
      height: context.setMinSize(90),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeProvider.width,
            height: context.sizeProvider.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // gradient: LinearGradient(
              //   colors: [AppColors.backGround, AppColors.backGround.withOpacity(0.8)],
              // ),
              color: context.colorTheme.primary,
              boxShadow: [
                // BoxShadow(
                //   color: AppColors.backGround.withOpacity(0.3),
                //   blurRadius: 20.r,
                //   offset: const Offset(0, 8),
                // ),
              ],
            ),
            child: Icon(
              Icons.check_rounded,
              size: context.setWidth(48),
              color: context.colorTheme.onPrimary,
            ),
          );
        },
      ),
    );
  }
}
