import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class BaseItem extends StatelessWidget {
  final BaseData base;
  final Function() onTap;
  final Function() onEdit;
  final Function() onSwitch;
  final Function() onDeleteTap;
  final bool active;

  const BaseItem(
      {Key? key,
      required this.base,
      required this.onTap,
      required this.onEdit,
      required this.onSwitch,
      required this.onDeleteTap,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: onEdit,
                      icon: const Icon(FlutterRemix.file_2_line)),
                  18.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 210,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    base.baseName!,
                                    style: AppTypographies.styBlack11W400,
                                    maxLines: 2,
                                  ),
                                ),
                                3.verticalSpace,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        base.ownerName!,
                                        style: AppTypographies.styBlack11W400,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      base.shareStatus!,
                                      style: base.shareStatus! == "owner"
                                          ? AppTypographies.styGreen11W400
                                          : AppTypographies.styOrange11W400,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                3.verticalSpace,
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SmallIconButton(
                                      icon: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color:
                                              AppColors.black.withOpacity(0.05),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: active
                                            ? const Icon(FlutterRemix.stop_fill)
                                            : const Icon(
                                                FlutterRemix.play_fill),
                                      ),
                                      onPressed: onSwitch,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text("${base.baseStatus}",
                                          style: TextStyle(
                                              color: base.baseStatus == "Ready"
                                                  ? Colors.green
                                                  : base.baseStatus == "Close"
                                                      ? Colors.red
                                                      : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
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
