import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class TotalEarningItemWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final num? earning;

  const TotalEarningItemWidget({
    Key? key,
    required this.title,
    required this.iconData,
    this.earning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 119.r,
        child: CustomPaint(
          painter: RatingPainter(),
          child: Container(
            height: 119.r,
            padding: REdgeInsets.only(
              left: 15,
              bottom: 20,
              right: 15,
            ),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.ratingBack,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                10.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypographies.styWhite16W500,
                        maxLines: 2,
                      ),
                    ),
                    Icon(
                      iconData,
                      size: 25.r,
                      color: AppColors.totalPanelGradient1,
                    ),
                  ],
                ),
                10.verticalSpace,
                Text(
                  NumberFormat.currency(
                    symbol: LocalStorage.instance.getSelectedCurrency()?.symbol,
                  ).format(earning ?? 0),
                  style: AppTypographies.styWhite16W500,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
