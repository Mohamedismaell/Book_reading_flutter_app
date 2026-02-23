import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.canEdit,
    required this.radius,
    required this.onTap,
    required this.state,
  });
  final UserState state;
  final bool canEdit;
  final double radius;
  final VoidCallback onTap;
  // void _showPickImageDialog(
  @override
  Widget build(BuildContext context) {
    final profileImage = state.user!.avatarUrl;
    return Stack(
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundImage: profileImage != null
              ? NetworkImage(profileImage)
              : const AssetImage('assets/images/deafult_user_cover.png'),
          backgroundColor: Colors.transparent,
        ),
        canEdit
            ? Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onTap,
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                      size: 20.r,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
