import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/profile/presentation/manager/user_stats/user_stats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatsCubit, UserStatsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: context.colorTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                context,
                'Favorite',
                state.userStats.booksFavorite.toString(),
              ),
              Expanded(
                child: VerticalDivider(
                  thickness: 2,
                  color: context.colorTheme.onSurface.withOpacity(0.1),
                ),
              ),
              _buildStatCard(
                context,
                'Minutes Read',
                state.userStats.totalReadingMinutes.toString(),
              ),
              Expanded(
                child: VerticalDivider(
                  thickness: 2,
                  color: context.colorTheme.onSurface.withOpacity(0.1),
                ),
              ),
              _buildStatCard(
                context,
                'Read',
                state.userStats.booksCompleted.toString(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
