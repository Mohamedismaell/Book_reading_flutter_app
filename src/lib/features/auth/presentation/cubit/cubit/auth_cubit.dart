import 'package:bloc/bloc.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:meta/meta.dart';
import '../../../data/models/user_app.dart';
import '../../../domain/usecases/login_google.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithGoogle userloging;
  final Logout userLogout;
  AuthCubit(this.userloging, this.userLogout) : super(AuthInitial());

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    final response = await userloging.loginWithGoogle();
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