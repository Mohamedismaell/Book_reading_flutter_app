import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../cubit/cubit/auth_cubit.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          //Todo change the style of bloking button
          onPressed: state is AuthLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Google", style: context.labelLarge()),
                SizedBox(width: context.setWidth(8)),
                state is AuthLoading
                    ? CircularProgressIndicator()
                    : SvgPicture.asset(
                        "assets/icons/earth.svg",
                        colorFilter: ColorFilter.mode(
                          context.colorTheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                        width: context.setWidth(18),
                        height: context.setHeight(22),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
