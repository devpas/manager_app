import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/theme.dart';

class OrderDetailItemWidget extends StatelessWidget {
  final String? title;
  final String? value;

  const OrderDetailItemWidget({Key? key, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('$title', style: AppTypographies.styBlack14W400),
                  4.horizontalSpace,
                  Expanded(
                    child: Text(
                      '$value',
                      style: AppTypographies.styBlack14W500,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              Divider(
                color: AppColors.black.withOpacity(0.05),
                height: 1.r,
                thickness: 1.r,
              ),
              14.verticalSpace,
            ],
          );
  }
}
