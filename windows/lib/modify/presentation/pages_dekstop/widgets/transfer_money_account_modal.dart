import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
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
  const TransferMoneyAccountModal({Key? key}) : super(key: key);

  @override
  ConsumerState<TransferMoneyAccountModal> createState() =>
      // ignore: no_logic_in_create_state
      _TransferMoneyAccountModalState();
}

class _TransferMoneyAccountModalState extends ConsumerState<TransferMoneyAccountModal> {
  double totalMoney = 0;

  double arrearsMoney = 0;

  double depositsMoney = 0;

  double refundsMoney = 0;

  String inputText = "";

  bool editMoney = false;

  _TransferMoneyAccountModalState();

  WidgetsToImageController controller = WidgetsToImageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        setState(() {
          totalMoney = ref.watch(customersProvider).customerSelected!.curDebt!;
        });
      },
    );
  }

  Widget calculatorDebt(BuildContext context) {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    return Container(
      width: 185,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 130.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "CE",
                          style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!inputText.contains("-")) {
                      setState(() {
                        inputText = "-$inputText";
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "-",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "7";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "7",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "8";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "8",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "9";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "9",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "4";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "4",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "5";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "5",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "6";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "6",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "1";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "1",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "2";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "2",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "3";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "3",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inputText += "0";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 130.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "0",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    inputText += ".";
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          ".",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 130.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(inputText)],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (inputText != "") {
                        editMoney = true;
                        totalMoney = totalMoney;

                        if (editMoney) {
                          depositsMoney += double.parse(inputText);
                        } else {
                          depositsMoney = double.parse(inputText);
                        }

                        if (depositsMoney > totalMoney) {
                          refundsMoney = depositsMoney - totalMoney;
                          arrearsMoney = 0;
                        } else {
                          arrearsMoney = totalMoney - depositsMoney;
                        }
                        inputText = "";
                      }

                      print("A $totalMoney");
                      print("B $depositsMoney");
                      print("C $arrearsMoney");
                      print("D $refundsMoney");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.check_line,
                        size: 20.r,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget payment(BaseState stateBase) {
    final stateBase = ref.watch(baseProvider);

    final notifier = ref.read(posSystemPASProvider.notifier);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                stateBase.translate[stateBase.languageSelected]["give"],
                                style: AppTypographies.styBlack14W400,
                              ),
                              Text(editMoney ? notifier.convertNumberZero(depositsMoney) : notifier.convertNumberZero(totalMoney), style: AppTypographies.styBlack14W400),
                            ],
                          ),
                          40.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                stateBase.translate[stateBase.languageSelected]["money_back"],
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
                ],
              ),
            ),
            calculatorDebt(context),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    final notifierCustomer = ref.read(customersProvider.notifier);
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.8,
      color: Colors.white,
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
          stateBase.sendMoneyLoading!
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenMain,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Padding(
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
                          child: AccentButtonCustom(
                              disable: !(editMoney == false && inputText != "") ? false : true,
                              title: AppHelpers.getTranslation(TrKeys.ok),
                              height: 40,
                              width: 100,
                              onPressed: () async {
                                if (!(editMoney == false && inputText != "")) {
                                  await notifierBase.createOrder(editMoney ? depositsMoney : totalMoney, -2, 0, "Tiền mặt", "${stateBase.baseRootInfomation["email"]}_${stateBase.baseInfomation["email"]}", "", stateCustomer.customerSelected!.id!);
                                  notifierCustomer.fetchListCustomers();
                                  // ignore: use_build_context_synchronously
                                  context.popRoute();
                                }
                              })),
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
