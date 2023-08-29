import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modify/presentation/theme/theme.dart';
import '../common_image.dart';
import '../hero_photo_view_wrapper.dart';

class TicketItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool isSelected;
  final Function() onTap;
  final Function() onDelete;
  final double? verticalPadding;

  const TicketItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.imageUrl,
    this.verticalPadding = 20,
    required this.onDelete,
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
                      style: isSelected
                          ? AppTypographies.styGreen16W500
                          : AppTypographies.styBlack16W500,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // notifierPos.deleteTicket(selectTicket);
                      // selectTicket = statePos.listTicket!.length - 1;
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.blue.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: onDelete,
                          child: Icon(
                            Icons.delete,
                            size: 20.r,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
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
