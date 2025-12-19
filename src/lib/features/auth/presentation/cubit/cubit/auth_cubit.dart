import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_app.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}
