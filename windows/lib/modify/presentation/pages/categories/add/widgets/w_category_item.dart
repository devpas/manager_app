import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../modify/models/models.dart';
import '../../../../../../src/core/utils/local_storage.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';

class WCategoryItem extends ConsumerWidget {
  final CategoryPasData category;
  final Function() onEditTap;
  final Function() onDeleteTap;
  final String userRole;

  const WCategoryItem({
    Key? key,
    required this.category,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: AppColors.transparent,
            highlightColor: AppColors.greenMain.withOpacity(0.15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: category.active == 1 ? AppColors.greenMain : AppColors.totalPanelGradient1,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      11.horizontalSpace,
                      CommonImage(
                        imageUrl: category.img.toString(),
                        width: 50,
                        height: 50,
                        radius: 10,
                      ),
                      8.horizontalSpace,
                      Text(
                        '${category.name}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.4,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                            FlutterRemix.pencil_line,
                            size: 20.r,
                            color: AppColors.black,
                          ),
                        ),
                        onPressed: onEditTap,
                      ),
                      AbsorbPointer(
                        absorbing: userRole == "pos-admin" ? false : true,
                        child: SmallIconButton(
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
                              color: userRole == "pos-admin" ? Colors.black : Colors.grey,
                            ),
                          ),
                          onPressed: onDeleteTap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
