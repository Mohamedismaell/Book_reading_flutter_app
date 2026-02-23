import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return switch (userState.status) {
          LoadStatus.loading || LoadStatus.initial => _buildLoadingIndicator(),

          LoadStatus.error => _buildErrorMessage(userState.message!),
          LoadStatus.loaded => Center(
            child: Column(
              children: [
                ProfileAvatar(
                  canEdit: true,
                  radius: 40.r,
                  onTap: () {},
                  state: userState,
                ),
                SizedBox(height: 16.h),
                Text(
                  userState.user!.name!,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        };
      },
    );
  }
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text('Something Went Wrong $message'));
}

//Todo save image to in lcoal
// void pickImage(BuildContext context) {
//   final userProfileCubit = context.read<UserProfileCubit>();
//   showDialog(
//     context: context,
//     builder: (context) {
//       return BlocProvider.value(
//         value: userProfileCubit,
//         child: SimpleDialog(
//           contentPadding: EdgeInsets.symmetric(vertical: 16.h),
//           children: [
//             SimpleDialogOption(
//               onPressed: () async {
//                 final image = await pickPhoto(
//                   userProfileCubit,
//                   ImageOptions.camera,
//                 );
//                 // print(' image?.path == > ${image?.path}');
//                 userProfileCubit.updateImagePath(image?.path);
//                 if (!context.mounted) return;
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.camera_alt_outlined, size: 24.sp),
//                   SizedBox(width: 8.w),
//                   Text('Camera', style: context.textTheme.bodyLarge),
//                 ],
//               ),
//             ),
//             SimpleDialogOption(
//               onPressed: () async {
//                 final image = await pickPhoto(
//                   userProfileCubit,
//                   ImageOptions.gallery,
//                 );
//                 // print(' image?.path == > ${image?.path}');
//                 userProfileCubit.updateImagePath(image?.path);
//                 if (!context.mounted) return;
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.image_outlined, size: 24.sp),
//                   SizedBox(width: 8.w),
//                   Text('Gallery', style: context.textTheme.bodyLarge),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// Future<File?> pickPhoto(
//   UserProfileCubit userProfileCubit,
//   ImageOptions imageOptions,
// ) async {
//   switch (imageOptions) {
//     case ImageOptions.camera:
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (image != null) {
//         // final savedImage = await saveImage(image);

//         final savedImage = await userProfileCubit.saveImageFile(image);
//         return savedImage;
//       }
//     case ImageOptions.gallery:
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         final savedImage = await userProfileCubit.saveImageFile(image);
//         return savedImage;
//       }
//   }
//   return null;
// }
