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
    double widthHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widthHeight * 0.0348,
          child: Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? AppColors.greenMain : AppColors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          title,
                          style: isSelected ? AppTypographies.styWhite10W500 : AppTypographies.styBlack10W500,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        4.5.verticalSpace,
      ],
    );
  }
}
