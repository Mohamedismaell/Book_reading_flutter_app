import 'dart:io';

import 'package:bookreading/core/enums/profile.dart';
import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/cubit/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundColor: Colors.transparent,
                  backgroundImage: userState.user?.profileImage != null
                      ? FileImage(File(userState.user!.profileImage!))
                      : const AssetImage(
                              'assets/images/7CBCD403-05F5-4DE0-BF87-3AD3215870C7.png',
                            )
                            as ImageProvider,
                ),
                GestureDetector(
                  onTap: () {
                    // pickImage(context);
                  },
                  child: Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorTheme.surface,
                    ),
                    child: Icon(Icons.camera_alt_outlined, size: 18.sp),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(width: 25.w),
        Column(
          children: [
            Text('Mohamed Ismael', style: context.textTheme.headlineMedium),
          ],
        ),
      ],
    );
  }
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
