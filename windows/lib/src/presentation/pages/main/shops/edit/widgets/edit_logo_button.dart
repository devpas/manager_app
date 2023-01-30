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

class EditLogoButton extends StatelessWidget {
  final String? imageUrl;
  final Color statusColor;
  final XFile? logoFile;
  final Function(XFile logoFile) onChangePhoto;
  final Function() onDelete;

  const EditLogoButton({
    Key? key,
    required this.onChangePhoto,
    this.imageUrl,
    required this.statusColor,
    this.logoFile,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8.75,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35.r),
            child: logoFile != null
                ? Image.file(
                    File(logoFile!.path),
                    width: 52.5,
                    height: 52.5,
                    fit: BoxFit.cover,
                  )
                : CommonImage(imageUrl: imageUrl, width: 52.5, height: 52.5),
          ),
          Row(
            children: [
              Material(
                borderRadius: BorderRadius.circular(28),
                color: AppColors.shopsPageBack,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
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
                      borderRadius: BorderRadius.circular(28),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.changePhoto),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SmallIconButton(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.black.withOpacity(0.05),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FlutterRemix.delete_bin_line,
                    size: 20.r,
                    color: AppColors.black,
                  ),
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
