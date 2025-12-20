import 'package:bookreading/features/auth/data/models/user_app.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/params/params.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(sl<LoginWithGoogle>(), sl<Logout>()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().loginWithGoogle(
                      // params: LoginParams(
                      //   email: 'icebringer111@gmail.com',
                      //   password: 'Easybooy1592004',
                      // ),
                    ),
                    child: const Text('Sign in with Google'),
                  ),
                  state is AuthSuccess
                      ? Text(
                          'you are looged in with email ${state.user.fullName}',
                        )
                      : const Text('not looged yet '),
                  ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().logout(
                      currentUser: UserApp(id: 'id', fullName: 'fullname'),
                    ),
                    child: const Text('Sign out'),
                  ),
                  state is AuthInitial
                      ? const Text('you are looged out')
                      : const Text('no action yet'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
