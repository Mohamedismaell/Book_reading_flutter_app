import 'dart:io';

import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/profile/presentation/controllers/pick_image_controller.dart';
import 'package:bookreading/features/profile/presentation/widget/pick_option.dart';
import 'package:flutter/material.dart';

class PickImageSheet extends StatelessWidget {
  final PickImageController controller;
  final ValueNotifier<File?> avatarNotifier;
  const PickImageSheet({
    super.key,
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
          PickOption(
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
          PickOption(
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
