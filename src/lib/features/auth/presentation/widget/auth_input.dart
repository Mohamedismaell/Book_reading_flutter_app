import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/validation_type.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators/form_validators.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    required this.hintText,
    required this.validationType,
    required this.onSaved,
    this.controller,
    this.validator,
  });

  final String hintText;
  final ValidationType validationType;
  final Function(String?) onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: validationType == ValidationType.password,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return FormValidators().getValidator(validationType, value);
      },
      onSaved: (value) => onSaved(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
        hintText: hintText,
        hintStyle: AppTextStyles.input16,
      ),
      style: AppTextStyles.input18,
    );
  }
}
