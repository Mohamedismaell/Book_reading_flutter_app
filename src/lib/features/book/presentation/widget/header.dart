import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Wednesday, 24 Oct", style: context.bodyMedium()),
              SizedBox(height: context.setHeight(4)),
              Text("Good Morning, Alex", style: context.headlineMedium()),
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
        InkWell(
          onTap: () => context.read<AuthCubit>().logout(),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorTheme.onSurface,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/images/profile_pic.png"),
          ),
        ),
      ],
    );
  }
}
