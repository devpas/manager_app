import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../../core/constants/constants.dart';

enum NotificationType { newOrder, newComment }

class NotificationItem extends StatelessWidget {
  final NotificationType notificationType;
  final String date;
  final String? commentOwner;
  final String? comment;
  final String? order;
  final String? amount;
  final String? user;

  const NotificationItem({
    Key? key,
    required this.notificationType,
    required this.date,
    this.commentOwner,
    this.comment,
    this.order,
    this.amount,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(14),
      margin: REdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    notificationType == NotificationType.newOrder
                        ? AppAssets.svgIcOrders
                        : AppAssets.svgIcComments,
                  ),
                  8.horizontalSpace,
                  Text(
                    notificationType == NotificationType.newOrder
                        ? TrKeys.newOrderAdded
                        : TrKeys.newCommentAdded,
                    style: AppTypographies.styBlack14W500,
                  ),
                ],
              ),
              Text(
                date,
                style: AppTypographies.styDarkGray14W500,
              ),
            ],
          ),
          14.verticalSpace,
          const Divider(),
          14.verticalSpace,
          notificationType == NotificationType.newOrder
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TrKeys.order,
                          style: AppTypographies.styBlack12W500Opacity50,
                        ),
                        Text(
                          order ?? '',
                          style: AppTypographies.styBlack14W500,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TrKeys.amount,
                          style: AppTypographies.styBlack12W500Opacity50,
                        ),
                        Text(
                          amount ?? '',
                          style: AppTypographies.styBlack14W500,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TrKeys.user,
                          style: AppTypographies.styBlack12W500Opacity50,
                        ),
                        Text(
                          user ?? '',
                          style: AppTypographies.styBlack14W500,
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commentOwner ?? '',
                      style: AppTypographies.styBlack14W500,
                    ),
                    4.verticalSpace,
                    Text(
                      comment ?? '',
                      style: AppTypographies.styLightGray12W400,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
