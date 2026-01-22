import 'dart:io';

import 'package:bookreading/core/di/service_locator.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/theme_icon.dart';
import 'package:bookreading/features/book/data/models/user_stats.dart';
import 'package:bookreading/features/book/presentation/controllers/pick_image_controller.dart';
import 'package:bookreading/features/book/presentation/cubit/profile/user_stats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final user = sl<SupabaseClient>().auth.currentUser;
  late PickImageController _pickImageController;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _pickImageController = PickImageController();
    // context.read<UserStatsCubit>().saveUserStats();
    super.initState();
  }

  @override
  void dispose() {
    // _pickImageController.dispose();
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
          child: _PickImageSheet(controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('userMetadata ===> ${user!.userMetadata}');
    super.build(context);
    return BlocBuilder<UserStatsCubit, UserStatsState>(
      builder: (context, state) {
        return switch (state) {
          UserStatsLoading() || UserStatsInitial() => _buildLoadingIndicator(),
          UserStatsError(:final message) => _buildErrorMessage(message),
          UserStatsLoaded(:final userStats) ||
          UserStatsLoaded(:final userStats) => _buildStateUI(userStats),
          // _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildStateUI(UserStatsModel userStats) {
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildImageProfile(
                    context,
                    () => _showPickImageDialog(context, _pickImageController),
                  ),
                  SizedBox(height: context.setHeight(10)),
                  Text(
                    user!.userMetadata!['full_name'],
                    style: context.headlineLarge(),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.setHeight(25)),
            _buildStatus(context, userStats),
            SizedBox(height: context.setHeight(35)),
            _buildReadingPreference(context),
            SizedBox(height: context.setHeight(20)),
            _buildSetting(context),
          ],
        ),
        ThemeIcon(top: 0, right: 15),
      ],
    );
  }
}

Widget _buildImageProfile(
  BuildContext context,
  VoidCallback onTap,
  File image,
) {
  return Stack(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(image),
        //  AssetImage('assets/images/back_ground_auth.jpg'),
        backgroundColor: Colors.transparent,
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: context.colorTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    ],
  );
}

class _PickImageSheet extends StatelessWidget {
  final PickImageController controller;

  const _PickImageSheet({required this.controller});

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
              await controller.takePhoto();
            },
          ),
          _PickOption(
            icon: Icons.photo_library_rounded,
            title: 'Choose from gallery',
            onTap: () async {
              Navigator.pop(context);
              await controller.pickFromGallery();
            },
          ),
        ],
      ),
    );
  }
}

class _PickOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _PickOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

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

Widget _buildStatus(BuildContext context, UserStatsModel userStats) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(25),
          vertical: context.setMinSize(20),
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text('24', style: context.headlineLarge()),
            Text('BOOKS READ', style: context.bodyMedium()),
          ],
        ),
      ),
      SizedBox(width: context.setWidth(20)),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(25),
          vertical: context.setMinSize(20),
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          children: [
            Text(
              (userStats.totalReadingMinutes / 60).ceil().toString(),
              style: context.headlineLarge(),
            ),
            Text('HOURS READ', style: context.bodyMedium()),
          ],
        ),
      ),
    ],
  );
}

Widget _buildReadingPreference(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Reading Preference', style: context.headlineSmall()),
      SizedBox(height: context.setHeight(16)),
      Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [],
          border: Border.all(
            color: context.colorTheme.surfaceContainer.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            _buildOption(
              context,
              icon: Icons.text_fields_rounded,
              title: 'Text',
            ),

            _buildOption(
              context,
              icon: Icons.language_rounded,
              title: 'Language',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildOption(
  BuildContext context, {
  required IconData icon,
  required String title,
  bool spreadLine = true,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () => print('Option Tapped'),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setSp(8),
            vertical: context.setSp(14),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.surfaceContainer.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(icon, size: context.setSp(20)),
                ),
              ),
              SizedBox(width: context.setWidth(16)),
              Expanded(child: Text(title, style: context.bodyLarge())),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.setSp(20),
                  color: context.colorTheme.surfaceContainer.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        spreadLine
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: context.setSp(16)),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: context.colorTheme.surfaceContainer,
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}

Widget _buildSetting(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Setting', style: context.headlineSmall()),
      SizedBox(height: context.setHeight(16)),
      Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [],
          border: Border.all(
            color: context.colorTheme.surfaceContainer.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            _buildOption(
              context,
              icon: Icons.person_outline_outlined,
              title: 'Account Setting',
            ),
            _buildOption(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notification',
            ),
            _buildOption(
              context,
              icon: Icons.logout_rounded,
              title: 'LogOut',
              spreadLine: false,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text(message));
}
