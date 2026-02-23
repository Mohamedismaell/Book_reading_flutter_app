import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  // final SaveProfileImageUseCase saveProfileImageUseCase;

  // void updateImagePath(String? value) {
  //   final updated = state.copyWith(imagePath: value);
  //   emit(updated);
  // }

  // Future<void> saveImagePath(String value) async {
  //   await saveProfileImageUseCase.call(value);
  //   emit(state.copyWith(imagePath: value));
  // }

  // Future<File?> saveImageFile(XFile image) async {
  //   final appDir = await getApplicationDocumentsDirectory();
  //   final newFile = await File(image.path).copy('${appDir.path}/${image.name}');
  //   await saveImagePath(newFile.path);
  //   return newFile;
  // }
}
