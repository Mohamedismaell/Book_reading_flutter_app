import 'dart:io';

import 'package:bookreading/core/shared/injection/di/service_locator.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/profile.dart';
import 'package:bookreading/features/book/presentation/cubit/profile/profile_cubit.dart';
import 'package:bookreading/features/book/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  // final ValueNotifier<File?> avatarNotifier;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return switch (profileState) {
          ProfileLoading() || ProfileInitial() => _buildLoadingIndicator(),

          ProfileError(:final message) => _buildErrorMessage(message),
          ProfileLoaded(:final profile) => _buildStateUI(context, profile),
          // _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

Widget _buildStateUI(BuildContext context, ProfileModel profile) {
  final user = sl<SupabaseClient>().auth.currentUser;
  ValueNotifier<File?> avatarNotifier;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Wednesday, 24 Oct", style: context.bodyMedium()),
            SizedBox(height: context.setHeight(4)),
            Text(
              "Good Morning, ${user!.userMetadata!['full_name'].toString().split(' ').first}",
              style: context.headlineMedium(),
            ),
          ],
        ),
      ),
      //! Notification Icon
      Container(
        decoration: BoxDecoration(
          // color: context.colorTheme.surface,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: const Icon(Icons.notifications_outlined),
        ),
      ),
      SizedBox(width: context.setWidth(12)),
      //! Profile Icon
      ProfileAvatar(profile: profile, canEdit: false, radius: 20),
    ],
  );
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text(message));
}
