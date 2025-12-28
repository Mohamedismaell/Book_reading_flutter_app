import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';

class NoteMessage extends StatelessWidget {
  const NoteMessage({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppTextStyles.buttonMedium.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/theme/app_text_styles.dart';
// import '../cubit/cubit/auth_cubit.dart';

// class ErrorMessage extends StatelessWidget {
//   const ErrorMessage({super.key, required this.text});

//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<AuthCubit, AuthState, String?>(
//       selector: (state) => state is AuthError ? state.message : null,
//       builder: (context, message) {
//         if (message == null) return const SizedBox.shrink();
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               message,
//               style: AppTextStyles.buttonMedium.copyWith(color: Colors.red),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
