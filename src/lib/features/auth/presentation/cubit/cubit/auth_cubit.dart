import 'package:bloc/bloc.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/params/params.dart';
import '../../../domain/usecases/forget_password.dart';
import '../../../domain/usecases/login_google.dart';
import '../../../domain/usecases/sign_up_email.dart';
import '../../../domain/usecases/update_passwords.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithGoogle google;
  final SignUpWithEmail signUpEmail;
  final LoginWithEmail logInEmail;
  final ForgetPassword resetPassword;
  final UpdatePassword updatePassword;
  final Logout userLogout;
  AuthCubit(
    this.google,
    this.userLogout,
    this.signUpEmail,
    this.logInEmail,
    this.resetPassword,
    this.updatePassword,
  ) : super(AuthInitial());

  Future<void> logInWithGoogle() async {
    emit(AuthLoading());
    final response = await google.loginWithGoogle();
    return response.when(
      success: (_) {
        emit(AuthSuccess());
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        debugPrint(error.errMessage);
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
        emit(AuthError(message: error.errMessage));
        debugPrint(error.errMessage);
      },
    );
  }

  Future<void> logInWithEmail({required LoginParams params}) async {
    emit(AuthLoading());
    final response = await logInEmail.loginWithEmail(params: params);
    return response.when(
      success: (user) {
        if (user.emailConfirmedAt == null) {
          emit(AuthVerification());
          return;
        }
        emit(AuthSuccess());
      },
      failure: (error) {
        if (error.errMessage.contains('confirm') ||
            error.errMessage.contains('verify')) {
          emit(AuthVerification());
        } else {
          emit(
            AuthError(message: "Invalid email or password. Please try again."),
          );
        }
        debugPrint(error.errMessage);
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
        emit(AuthChangePassword());
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        debugPrint(error.errMessage);
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
        emit(AuthInitial());
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        debugPrint(error.errMessage);
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final response = await userLogout.logout();
    return response.when(
      success: (_) {
        emit(AuthInitial());
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        debugPrint(error.errMessage);
      },
    );
  }
}
//  Future<void> eitherFailureOrSuccessByDate() async {
//     final response = await getNews.callNewsDate();
//     return response.when(
//       success: (news) {
//         final validateNewsDate = news.where((post) {
//           return post.threadimageUrl != null &&
//               post.threadimageUrl!.isNotEmpty &&
//               Uri.tryParse(
//                     post.threadimageUrl!,
//                   )?.hasAbsolutePath ==
//                   true;
//         }).toList();
//         emit(
//           state.copyWith(
//             dateStatus: NewsStatus.loaded,
//             newsByDate: validateNewsDate,
//           ),
//         );
//       },
//       failure: (error) {
//         emit(
//           state.copyWith(
//             dateStatus: NewsStatus.error,
//             errorMessage: error.errMessage,
//           ),
//         );
//       },
//     );
//   }