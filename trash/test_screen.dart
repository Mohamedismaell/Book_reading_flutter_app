// import 'package:bookreading/core/params/params.dart';
// import 'package:bookreading/features/auth/data/models/user_app.dart';
// import 'package:bookreading/features/auth/domain/usecases/forget_password.dart';
// import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
// import 'package:bookreading/features/auth/domain/usecases/logout.dart';
// import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../domain/usecases/login_email.dart';
// import '../../domain/usecases/sign_up_email.dart';
// import '../../domain/usecases/update_passwords.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AuthCubit(
//         sl<LoginWithGoogle>(),
//         sl<Logout>(),
//         sl<SignUpWithEmail>(),
//         sl<LoginWithEmail>(),
//         sl<ForgetPassword>(),
//         sl<UpdatePassword>(),
//       ),
//       child: BlocBuilder<AuthCubit, AuthState>(
//         builder: (context, state) {
//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => context.read<AuthCubit>().logInWithGoogle(
//                       // params: LoginParams(
//                       //   email: 'icebringer111@gmail.com',
//                       //   password: 'Easybooy1592004',
//                       // ),
//                     ),
//                     child: const Text('Sign in with Google'),
//                   ),
//                   state is AuthSuccess
//                       ? Text(
//                           'you are looged in with email ${state.user.fullName}',
//                         )
//                       : const Text('not looged yet '),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => context.read<AuthCubit>().signUpWithEmail(
//                       params: SignupParams(
//                         name: 'Mohamed Ismael',
//                         email: "itsfacebooky@gmail.com",
//                         password: 'A123456',
//                       ),
//                     ),
//                     child: const Text('Sign Up with your email'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => context.read<AuthCubit>().logInWithEmail(
//                       params: LoginParams(
//                         email: "itsfacebooky@gmail.com",
//                         password: 'A123456',
//                       ),
//                     ),
//                     child: const Text('LOGIN In with your email'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => context.read<AuthCubit>().logout(
//                       currentUser: UserApp(id: 'id', fullName: 'fullname'),
//                     ),
//                     child: const Text('Sign out'),
//                   ),
//                   state is AuthInitial
//                       ? const Text('you are looged out')
//                       : const Text('no action yet'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
