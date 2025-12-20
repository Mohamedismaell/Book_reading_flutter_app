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
  final LoginWithGoogle logInWithGoogle;
  final SignUpWithEmail signUpWithGoogle;
  final LoginWithEmail logInWithEmail;
  final Logout userLogout;
  AuthCubit(
    this.logInWithGoogle,
    this.userLogout,
    this.signUpWithGoogle,
    this.logInWithEmail,
  ) : super(AuthInitial());

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    final response = await logInWithGoogle.loginWithGoogle();
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
      },
    );
  }

  Future<void> signUpWithEmail({required SignupParams params}) async {
    emit(AuthLoading());
    final response = await signUpWithGoogle.signUpWithEmail(params: params);
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
      },
    );
  }

  Future<void> loginWithEmail({required LoginParams params}) async {
    emit(AuthLoading());
    final response = await logInWithEmail.loginWithEmail(params: params);
    return response.when(
      success: (user) {
        emit(AuthSuccess(user: user));
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
      },
    );
  }

  Future<void> logout({required UserApp currentUser}) async {
    emit(AuthLoading());
    final response = await userLogout.logout(currentUser: currentUser);
    return response.when(
      success: (user) {
        emit(AuthInitial());
      },
      failure: (error) {
        emit(AuthError(message: error.errMessage));
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