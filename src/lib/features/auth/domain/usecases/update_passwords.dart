import '../../../../core/connections/result.dart';
import '../repositories/auth_repository.dart';

class UpdatePassword {
  final AuthRepository repository;

  UpdatePassword({required this.repository});

  Future<Result> updatePassword({required String newPassword}) async {
    return await repository.updatePassword(newPassword: newPassword);
  }
}
