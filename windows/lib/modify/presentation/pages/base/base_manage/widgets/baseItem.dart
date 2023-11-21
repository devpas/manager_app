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

  Widget upAndDown(double parameter, String title) {
    if (parameter > 0) {
      return Row(
        children: [
          Text(
            "${title}: ",
          ),
          const Icon(
            Icons.arrow_upward,
            color: AppColors.greenMain,
            size: 18,
          ),
          Text(
            parameter.toString(),
            style: const TextStyle(color: AppColors.greenMain),
          )
        ],
      );
    } else if (parameter < 0) {
      return Row(
        children: [
          Text(title),
          const Icon(
            Icons.arrow_downward,
            color: AppColors.red,
            size: 18,
          ),
          Text(parameter.toString())
        ],
      );
    } else {
      return Text("$title: ${parameter.toString()}");
    }
  }

  const BaseItem({Key? key, required this.base, required this.onTap, required this.onEdit, required this.onSwitch, required this.onDeleteTap, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
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
            ExpansionTile(
              // ignore: prefer_interpolation_to_compose_strings
              title: Row(
                children: [
                  Text(
                    "Tổng tài sản: ${base.moneyRecord["total_money_day_end"]}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    "(${base.moneyRecord["money_income_in_day"] > 0 ? '+' : '-'}${base.moneyRecord["money_income_in_day"]})",
                    style: TextStyle(color: base.moneyRecord["money_income_in_day"] > 0 ? AppColors.greenMain : AppColors.red),
                  )
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.425,
                        child: upAndDown(base.moneyWallet!, "Công nợ"),
                      ),
                      SizedBox(
                        width: screenWidth * 0.425,
                        child: Text("Số đơn hàng: ${base.ticketsNum}"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.425,
                        child: Text("Tiền hàng: ${base.moneyRecord["total_money_product"]}"),
                      ),
                      SizedBox(
                        width: screenWidth * 0.425,
                        child: Text("thu nhập hôm qua: ${base.moneyRecord["money_sold"]}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
