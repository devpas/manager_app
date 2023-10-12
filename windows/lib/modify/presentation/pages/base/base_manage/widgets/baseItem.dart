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

  const BaseItem({Key? key, required this.base, required this.onTap, required this.onEdit, required this.onSwitch, required this.onDeleteTap, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.6,
                                        child: Text(
                                          base.ownerName!,
                                          style: AppTypographies.styBlack11W400,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.45,
                                            child: Text(
                                              base.email!,
                                              style: AppTypographies.styBlack11W400,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                base.shareStatus!,
                                                style: base.shareStatus! == "owner" ? AppTypographies.styGreen11W400 : AppTypographies.styOrange11W400,
                                                maxLines: 2,
                                              ),
                                              Text(" - ${base.baseStatus}",
                                                  style: TextStyle(
                                                      color: base.baseStatus == "Ready"
                                                          ? Colors.green
                                                          : base.baseStatus == "Close"
                                                              ? Colors.red
                                                              : Colors.black,
                                                      fontSize: 11.sp,
                                                      fontWeight: FontWeight.w400))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                  child: active ? const Icon(FlutterRemix.stop_fill) : const Icon(FlutterRemix.play_fill),
                                ),
                                onPressed: onSwitch,
                              ),
                              IconButton(onPressed: onEdit, icon: const Icon(FlutterRemix.file_2_line)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 5, 3),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.425,
                            child: const Text("thu vào: 66,110,100,443.4"),
                          ),
                          SizedBox(
                            width: screenWidth * 0.425,
                            child: const Text("xuất ra: 44,110,100,443.4"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.425,
                            child: const Text("Công nợ: 555,666,333.4"),
                          ),
                          SizedBox(
                            width: screenWidth * 0.425,
                            child: const Text("Số đơn hàng: 200,500"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
