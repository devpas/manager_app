import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../models/models.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class BaseEmployeeItem extends StatelessWidget {
  final dynamic base;
  final Function() onTap;
  final Function() onEdit;

  Widget upAndDown(dynamic parameter, String title) {
    parameter = double.parse(parameter.toString());
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

  const BaseEmployeeItem({Key? key, required this.base, required this.onTap, required this.onEdit}) : super(key: key);

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
                                          base["name"],
                                          style: AppTypographies.styBlack11W400,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.45,
                                            child: Text(
                                              base["email"],
                                              style: AppTypographies.styBlack11W400,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
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
                            child: upAndDown(base["money"]!, "Công nợ"),
                          ),
                          SizedBox(
                            width: screenWidth * 0.425,
                            child: Text("Số đơn hàng: ${base["tickets"]}"),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 3),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: screenWidth * 0.425,
                    //         child: const Text("Công nợ: 555,666,333.4"),
                    //       ),
                    //       SizedBox(
                    //         width: screenWidth * 0.425,
                    //         child: const Text("Số đơn hàng: 200,500"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
