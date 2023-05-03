import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modify/presentation/theme/theme.dart';

class CategoryPosItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool isSelected;
  final Function() onTap;

  const CategoryPosItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          width: 100,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? AppColors.greenMain : AppColors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          style: isSelected
                              ? AppTypographies.styWhite10W500
                              : AppTypographies.styBlack10W500,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        5.verticalSpace,
      ],
    );
  }
}
