import 'package:bloc/bloc.dart';
import 'package:bookreading/core/params/params.dart';
import 'package:bookreading/features/auth/domain/usecases/forget_password.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:bookreading/features/auth/domain/usecases/update_passwords.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithGoogle google;
  final SignUpWithEmail signUpEmail;
  final LoginWithEmail logInEmail;
  final ForgetPassword resetPassword;
  final UpdatePassword updatePassword;
  final Logout userLogout;
  final SupabaseClient supabaseClient;
  AuthCubit({
    required this.google,
    required this.userLogout,
    required this.signUpEmail,
    required this.logInEmail,
    required this.resetPassword,
    required this.updatePassword,
    required this.supabaseClient,
  }) : super(AuthNone());

  Future<void> logInWithGoogle() async {
    emit(AuthLoading());
    final response = await google.loginWithGoogle();
    return response.when(
      success: (_) {
        emit(AuthSuccess());
      },
      failure: (error) {
        emit(AuthError(message: error.message));
        debugPrint(error.message);
      },
    );
  }

  Future<void> signUpWithEmail({required SignupParams params}) async {
    emit(AuthLoading());

    final response = await signUpEmail.signUpWithEmail(params: params);
    return response.when(
      success: (_) {
        emit(AuthVerification());
      },
      failure: (error) {
        emit(AuthError(message: error.message));
        debugPrint(error.message);
      },
    );
  }

  Future<void> logInWithEmail({required LoginParams params}) async {
    emit(AuthLoading());
    final response = await logInEmail.loginWithEmail(params: params);
    return response.when(
      success: (_) {
        final user = supabaseClient.auth.currentUser;
        if (user == null) {
          emit(AuthError(message: "Something went wrong. Please try again."));
          return;
        }
        if (user.emailConfirmedAt == null) {
          emit(AuthVerification());
          return;
        }
        emit(AuthSuccess());
      },
      failure: (error) {
        if (error.message.contains('confirmed')) {
          emit(AuthError(message: "Email not Confirmed."));
        } else {
          emit(
            AuthError(message: "Invalid email or password. Please try again."),
          );
        }
        debugPrint(error.message);
      },
    );
  }

  Future<void> requestResetPassword({
    required ForgotPasswordParams params,
  }) async {
    emit(AuthLoading());
    final response = await resetPassword.resetPassword(params: params);
    return response.when(
      success: (_) {
        emit(AuthForgetPassword());
      },
      failure: (error) {
        emit(AuthError(message: error.message));
        debugPrint(error.message);
      },
    );
  }

  Future<void> resetePassword({required String newPassword}) async {
    emit(AuthLoading());
    final response = await updatePassword.updatePassword(
      newPassword: newPassword,
    );
    return response.when(
      success: (_) {
        emit(AuthUpdatePassword());
      },
      failure: (error) {
        emit(AuthError(message: error.message));
        debugPrint(error.message);
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final response = await userLogout.logout();
    return response.when(
      success: (_) {
        emit(AuthNone());
      },
      failure: (error) {
        emit(AuthError(message: error.message));
        debugPrint(error.message);
      },
    );
  }
}
