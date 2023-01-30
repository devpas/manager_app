import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class CommonInputField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final String? initialValue;
  final TextInputType? inputType;
  final bool? obscure;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputAction? inputAction;

  const CommonInputField({
    Key? key,
    required this.label,
    required this.onChanged,
    this.initialValue,
    this.inputType,
    this.obscure,
    this.hintText,
    this.suffixIcon,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            letterSpacing: -0.4,
            color: AppColors.black.withOpacity(0.3),
          ),
        ),
        TextFormField(
          onChanged: onChanged,
          initialValue: initialValue,
          cursorColor: AppColors.black,
          cursorWidth: 1.r,
          keyboardType: inputType,
          obscureText: obscure ?? false,
          obscuringCharacter: '*',
          textInputAction: inputAction,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
            ),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              letterSpacing: -0.4,
              color: AppColors.inputNameHint,
            ),
          ),
        ),
      ],
    );
  }
}
