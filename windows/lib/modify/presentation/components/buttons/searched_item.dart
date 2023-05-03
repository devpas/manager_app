import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation/theme/theme.dart';
import '../common_image.dart';
import '../hero_photo_view_wrapper.dart';

class SearchedItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool isSelected;
  final Function() onTap;
  final double? verticalPadding;

  const SearchedItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.imageUrl,
    this.verticalPadding = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding!,
                horizontal: 18,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTypographies.styBlack16W500,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  isSelected
                      ? Icon(
                          FlutterRemix.checkbox_circle_fill,
                          color: AppColors.greenMain,
                          size: 24.r,
                        )
                      : imageUrl != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HeroPhotoViewRouteWrapper(
                                      imageProvider: NetworkImage(imageUrl!),
                                    ),
                                  ),
                                );
                              },
                              child: CommonImage(
                                imageUrl: imageUrl,
                                width: 40,
                                height: 40,
                              ),
                            )
                          : const SizedBox(),
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
