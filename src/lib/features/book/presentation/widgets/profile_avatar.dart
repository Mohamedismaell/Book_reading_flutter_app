import 'dart:io';

import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/controllers/pick_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    super.key,
    required this.profileImage,
    required this.canEdit,
    required this.radius,
  });
  final String? profileImage;
  final bool canEdit;
  final double radius;
  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late PickImageController _pickImageController;
  late final ValueNotifier<File?> avatarNotifier;
  @override
  void initState() {
    // _pickImageController = PickImageController(profileCubit: context.read());
    avatarNotifier = ValueNotifier(null);

    super.initState();
  }

  @override
  void dispose() {
    avatarNotifier.dispose();
    super.dispose();
  }

  void _showPickImageDialog(
    BuildContext context,
    PickImageController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 250),
          tween: Tween(begin: 0, end: 1),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 80 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: _PickImageSheet(
            controller: controller,
            avatarNotifier: avatarNotifier,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProfileAvatar(
      context,
      widget.profileImage ?? 'assets/images/deafult_user_cover.png',
      avatarNotifier,
      widget.canEdit,
      widget.canEdit
          ? () => _showPickImageDialog(context, _pickImageController)
          : null,
      widget.radius,
    );
  }

  Widget _buildProfileAvatar(
    BuildContext context,
    String profileImage,
    ValueNotifier<File?> avatarNotifier,
    bool canEdit,
    VoidCallback? onTap,
    double radius,
  ) {
    return Stack(
      children: [
        ValueListenableBuilder<File?>(
          valueListenable: avatarNotifier,
          builder: (context, file, child) => CircleAvatar(
            radius: radius.r,
            backgroundImage: file != null
                ? FileImage(file)
                : profileImage != 'assets/images/deafult_user_cover.png'
                ? NetworkImage(profileImage)
                : const AssetImage('assets/images/deafult_user_cover.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        canEdit
            ? Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onTap,
                  child: Container(
                    width: 35.r,
                    height: 35.r,
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

class _PickImageSheet extends StatelessWidget {
  final PickImageController controller;
  final ValueNotifier<File?> avatarNotifier;
  const _PickImageSheet({
    required this.controller,
    required this.avatarNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PickOption(
            icon: Icons.camera_alt_rounded,
            title: 'Take photo',
            onTap: () async {
              Navigator.pop(context);
              final file = await controller.takePhoto();
              if (file != null) {
                avatarNotifier.value = file;
              }
            },
          ),
          _PickOption(
            icon: Icons.photo_library_rounded,
            title: 'Choose from gallery',
            onTap: () async {
              Navigator.pop(context);
              final file = await controller.pickFromGallery();
              if (file != null) {
                avatarNotifier.value = file;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _PickOption extends StatelessWidget {
  const _PickOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 26),
            const SizedBox(width: 16),
            Text(title, style: context.bodyLarge()),
          ],
        ),
      ),
    );
  }
}
