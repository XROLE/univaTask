import 'package:flutter/material.dart';
import 'package:univa_task/utils/app_colors.dart';

class CustumeTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function(String e)? onChange;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String? e)? validator;

  const CustumeTextInput({
    this.controller,
    this.keyboardType,
    this.readOnly,
    this.onChange,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (e) => onChange != null ? onChange!(e) : () {},
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        controller: controller,
        validator: (val) => validator != null ?  validator!(val) : null,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: outlineBorder,
          enabledBorder: outlineBorder,
        ));
  }
}

InputBorder outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.black.withOpacity(.12)));