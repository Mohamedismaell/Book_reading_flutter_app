import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/cubit/theme_cubit.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Positioned(
          top: MediaQuery.sizeOf(context).height * 0.05,
          right: MediaQuery.sizeOf(context).width * 0.05,
          child: IconButton(
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
            icon: state.isLight
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined),
          ),
        );
      },
    );
  }
}
