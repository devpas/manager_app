import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';

class EditBackImageButton extends StatelessWidget {
  final String? imageUrl;
  final Color statusColor;
  final XFile? file;
  final Function(XFile logoFile) onChangePhoto;
  final Function() onDelete;

  const EditBackImageButton({
    Key? key,
    required this.onChangePhoto,
    this.imageUrl,
    required this.statusColor,
    this.file,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 130.r,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.settingsButtonBack,
          ),
          child: file != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.file(
                    File(file!.path),
                    fit: BoxFit.cover,
                    height: 130.r,
                    width: double.infinity,
                  ),
                )
              : imageUrl != null
                  ? CommonImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: 130.r,
                      radius: 10,
                    )
                  : Icon(
                      FlutterRemix.image_line,
                      color: AppColors.black,
                      size: 30.r,
                    ),
        ),
        Padding(
          padding: REdgeInsets.only(
            bottom: 15.0,
            right: 15,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                borderRadius: BorderRadius.circular(28.r),
                color: AppColors.shopsPageBack,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28.r),
                  onTap: () async {
                    final XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1000,
                      maxHeight: 1000,
                      imageQuality: 90,
                    );
                    if (pickedFile != null) {
                      onChangePhoto(pickedFile);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    alignment: Alignment.center,
                    padding: REdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.uploadImage),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              if (file != null || imageUrl != null)
                SmallIconButton(
                  icon: Container(
                    height: 36.r,
                    width: 36.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      color: AppColors.white,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      FlutterRemix.delete_bin_line,
                      size: 20.r,
                      color: AppColors.black,
                    ),
                  ),
                  onPressed: onDelete,
                )
            ],
          ),
        ),
      ],
    );
  }
}
