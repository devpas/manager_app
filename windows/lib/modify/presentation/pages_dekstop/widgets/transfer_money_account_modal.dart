import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/src/core/di/dependency_manager.dart';
import 'package:intl/intl.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../riverpob/states/base/base_state.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class TransferMoneyAccountModal extends ConsumerStatefulWidget {
  final double totalMoneyFromTicket;
  final int warehouseId;
  final int reason;
  const TransferMoneyAccountModal({Key? key, required this.totalMoneyFromTicket, required this.warehouseId, required this.reason}) : super(key: key);

  @override
  ConsumerState<TransferMoneyAccountModal> createState() =>
      // ignore: no_logic_in_create_state
      _TransferMoneyAccountModalState(totalMoneyFromTicket, warehouseId, reason);
}

class _TransferMoneyAccountModalState extends ConsumerState<TransferMoneyAccountModal> with TickerProviderStateMixin {
  final double totalMoneyFromTicket;

  final int warehouseId;

  final int reason;
  double totalMoney = 0;

  double arrearsMoney = 0;

  double depositsMoney = 0;

  double refundsMoney = 0;

  bool editMoney = false;

  _TransferMoneyAccountModalState(this.totalMoneyFromTicket, this.warehouseId, this.reason);

  WidgetsToImageController controller = WidgetsToImageController();

  @override
  void initState() {
    super.initState();
    setState(() {
      totalMoney = totalMoneyFromTicket;
    });
  }

  Widget payment(BaseState stateBase) {
    final stateBase = ref.watch(baseProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth * 0.35,
              child: ListView(
                physics: const CustomBouncingScrollPhysics(),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: notifier.money.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Column(children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              editMoney = true;
                              totalMoney = totalMoney;

                              if (editMoney) {
                                depositsMoney += notifier.money[index]["price"];
                              } else {
                                depositsMoney = notifier.money[index]["price"];
                              }

                              if (depositsMoney > totalMoney) {
                                refundsMoney = depositsMoney - totalMoney;
                                arrearsMoney = 0;
                              } else {
                                arrearsMoney = totalMoney - depositsMoney;
                              }
                            });
                          },
                          child: Image.network(
                            notifier.money[index]["img"],
                            height: 50,
                            width: 100,
                          ),
                        ),
                        Text("${notifier.money[index]["price"]}"),
                      ]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth * 0.2,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateBase.translate[stateBase.languageSelected]["give"],
                          style: AppTypographies.styBlack14W400,
                        ),
                        Text(editMoney ? notifier.convertNumberZero(depositsMoney) : notifier.convertNumberZero(totalMoney), style: AppTypographies.styBlack14W400)
                      ],
                    ),
                    40.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateBase.translate[stateBase.languageSelected]["back"],
                          style: AppTypographies.styBlack14W400,
                        ),
                        Text(notifier.convertNumberZero(refundsMoney), style: AppTypographies.styBlack14W400)
                      ],
                    ),
                    40.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateBase.translate[stateBase.languageSelected]["total"],
                          style: AppTypographies.styBlack14W400,
                        ),
                        Text(notifier.convertNumberZero(totalMoney), style: AppTypographies.styBlack14W400)
                      ],
                    ),
                    40.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateBase.translate[stateBase.languageSelected]["money_left"],
                          style: AppTypographies.styBlack14W400,
                        ),
                        Text(notifier.convertNumberZero(arrearsMoney), style: AppTypographies.styBlack14W400)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateBase = ref.watch(baseProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.55,
      child: Column(
        children: [
          10.verticalSpace,
          Text(
            stateBase.translate[stateBase.languageSelected]["payment"],
            style: AppTypographies.styBlack22W500,
          ),
          10.verticalSpace,
          payment(stateBase),
          const Divider(height: 5, thickness: 3),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      RoundedCheckBox(
                        value: true,
                        onChanged: (value) {
                          // notifier.setVisibility(!state.visibility);
                        },
                      ),
                      10.horizontalSpace,
                      Text(
                        "In",
                        style: AppTypographies.styBlack14W400,
                      ),
                    ],
                  ),
                ),
                20.horizontalSpace,
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: arrearsMoney == 0
                      ? AccentButtonCustom(
                          disable: false,
                          title: AppHelpers.getTranslation(TrKeys.ok),
                          height: 40,
                          width: 100,
                          onPressed: () async {
                            // ignore: use_build_context_synchronously
                          })
                      : AccentButtonCustom(disable: true, title: AppHelpers.getTranslation(TrKeys.ok), height: 40, width: 100, onPressed: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AccentButtonCustom(
                      disable: false,
                      title: AppHelpers.getTranslation(TrKeys.cancel),
                      height: 40,
                      width: 100,
                      onPressed: () {
                        context.popRoute();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
