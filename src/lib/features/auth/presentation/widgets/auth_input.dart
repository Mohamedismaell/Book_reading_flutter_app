import 'package:bookreading/core/enums/validation_type.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthInput extends StatefulWidget {
  final String hintText;
  final ValidationType validationType;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  const AuthInput({
    super.key,
    required this.hintText,
    required this.validationType,
    this.onSaved,
    this.controller,
    this.validator,
    required this.isPassword,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _obscure = true;
  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      validator: (value) => widget.validator != null
          ? widget.validator!(value)
          : FormValidators().getValidator(widget.validationType, value),

      onSaved: (value) =>
          widget.onSaved != null ? widget.onSaved!(value) : null,
      decoration: InputDecoration(
        //! Hint Text
        hintText: widget.hintText,
        hintStyle: context.textTheme.bodyMedium,
        //! Eye icon
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              )
            : null,
      ),
      style: context.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
