import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/constants/constants.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../../src/presentation/theme/theme.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;

  const SearchTextField({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.textEditingController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      style: AppTypographies.styBlack14W400,
      onChanged: onChanged,
      controller: textEditingController,
      cursorWidth: 1.r,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        hintStyle: AppTypographies.styBlack14W400Opacity30,
        hintText: hintText ?? AppHelpers.getTranslation(TrKeys.searchStores),
        contentPadding: EdgeInsetsDirectional.only(start: 24.r),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 18.r,
          maxWidth: 53.r,
        ),
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 24.r, end: 11.r),
          child: Icon(
            FlutterRemix.search_2_line,
            size: 18.r,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        suffixIcon: suffixIcon,
        fillColor: AppColors.white,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
      ),
    );
  }
}
