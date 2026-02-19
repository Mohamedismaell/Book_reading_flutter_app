import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  // final ValueNotifier<File?> avatarNotifier;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return switch (state.status) {
          LoadStatus.loading || LoadStatus.initial => _buildLoadingIndicator(),

          LoadStatus.error => _buildErrorMessage(state.message!),
          LoadStatus.loaded => Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Wednesday, 24 Oct", style: context.bodyMedium()),
                    SizedBox(height: 4.h),
                    Text(
                      "Good Morning, ${state.user!.name}",
                      style: context.headlineMedium(),
                    ),
                  ],
                ),
              ),
              //! Notification Icon
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ),
              SizedBox(width: 12.w),
              //! Profile Icon
              ProfileAvatar(
                profileImage: state.user!.profileImage,
                canEdit: false,
                radius: 20,
              ),
            ],
          ),
          // _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text('Something Went Wrong $message'));
}
