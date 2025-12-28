// import 'package:bookreading/core/params/params.dart';
// import 'package:bookreading/core/theme/app_colors.dart';
// import 'package:bookreading/core/theme/app_shadows.dart';
// import 'package:bookreading/core/theme/app_text_styles.dart';
// import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
// import 'package:bookreading/features/auth/presentation/widget/action_auth_button.dart';
// import 'package:bookreading/features/auth/presentation/widget/auth_input.dart';
// import 'package:bookreading/features/auth/presentation/widget/banner.dart';
// import 'package:bookreading/features/auth/presentation/widget/google_button.dart';
// import 'package:bookreading/features/auth/presentation/widget/head_title.dart';
// import 'package:bookreading/features/auth/presentation/widget/seperator_line.dart';
// import 'package:bookreading/features/auth/presentation/widget/white_contianer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/enums/validation_type.dart';

// class ForgetPasswordCard extends StatelessWidget {
//   const ForgetPasswordCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //! Main White Container
//     return WhiteContianer(child: _Content());
//   }
// }

// class _Content extends StatefulWidget {
//   const _Content();

//   @override
//   State<_Content> createState() => _ContentState();
// }

// class _ContentState extends State<_Content> {
//   final _formKey = GlobalKey<FormState>();

//   String _newPassword = '';
//   String _confirmPassword = '';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //! Logo
//         Logo(),
//         SizedBox(height: 16.h),
//         //! Title
//         HeadTitle(
//           headText: 'Welcome Back',
//           hashText: 'Start your reading journey today.',
//         ),
//         SizedBox(height: 32.h),
//         //! Form
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               AuthInput(
//                 hintText: '_oldPassword',
//                 validationType: ValidationType.email,
//                 onSaved: (value) => _newPassword = value ?? '',
//               ),
//               SizedBox(height: 16),
//               AuthInput(
//                 hintText: 'Password',
//                 validationType: ValidationType.password,
//                 onSaved: (value) => _confirmPassword = value ?? '',
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: 16.h),
//         //! Action button
//         ActionAuthButton(
//           myText: "Log In",
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState!.save();
//               context.read<AuthCubit>().logInWithEmail(

//               );
//               _formKey.currentState!.reset();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
