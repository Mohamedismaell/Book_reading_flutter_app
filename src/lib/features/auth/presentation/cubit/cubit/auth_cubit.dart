import 'package:bloc/bloc.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:meta/meta.dart';
import '../../../../../core/params/params.dart';
import '../../../data/models/user_app.dart';
import '../../../domain/usecases/login_google.dart';
import '../../../domain/usecases/sign_up_email.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithGoogle google;
  final SignUpWithEmail signUpEmail;
  final LoginWithEmail logInEmail;
  // final ForgetPassword resetPassword;
  // final UpdatePassword updatePassword;
  final Logout userLogout;
  AuthCubit(
    this.google,
    this.userLogout,
    this.signUpEmail,
    this.logInEmail,
    // this.resetPassword,
    // this.updatePassword,
  ) : super(AuthInitial());

  Future<void> logInWithGoogle() async {
    emit(AuthLoading());
    final response = await google.loginWithGoogle();
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
        print("****Login success****");
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        print("****Login error****");
        print(error.errMessage);
      },
    );
  }

  Future<void> signUpWithEmail({required SignupParams params}) async {
    emit(AuthLoading());
    final response = await signUpEmail.signUpWithEmail(params: params);
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
        print("****Sign up success****");
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        print("****Sign up error****");
        print(error.errMessage);
      },
    );
  }

  Future<void> logInWithEmail({required LoginParams params}) async {
    emit(AuthLoading());
    final response = await logInEmail.loginWithEmail(params: params);
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
        print("****Log in success****");
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        print("****Log in error****");
        print(error.errMessage);
      },
    );
  }

  // Future<void> requestResetPassword({
  //   required ForgotPasswordParams params,
  // }) async {
  //   emit(AuthLoading());
  //   final response = await resetPassword.resetPassword(params: params);
  //   return response.when(
  //     success: (user) {
  //       emit(AuthRequestPassword(user: user));
  //       print("****Request password success****");
  //     },
  //     failure: (error) {
  //       emit(AuthError(message: error.errMessage));
  //       print("****Request password error****");
  //       print(error.errMessage);
  //     },
  //   );
  // }

  // Future<void> updateUserPassword({required String newPassword}) async {
  //   emit(AuthLoading());
  //   final response = await updatePassword.updatePassword(
  //     newPassword: newPassword,
  //   );
  //   return response.when(
  //     success: (_) {
  //       emit(AuthInitial());
  //       print("****Update password success****");
  //     },
  //     failure: (error) {
  //       emit(AuthError(message: error.errMessage));
  //       print("****Update password error****");
  //       print(error.errMessage);
  //     },
  //   );
  // }

  Future<void> logout({required UserApp currentUser}) async {
    emit(AuthLoading());
    final response = await userLogout.logout(currentUser: currentUser);
    return response.when(
      success: (_) {
        emit(AuthInitial());
        print("****Logout success****");
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
        print("****Logout error****");
        print(error.errMessage);
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