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
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class PayInfoModal extends ConsumerStatefulWidget {
  final double totalMoneyFromTicket;
  final int warehouseId;
  final int reason;
  const PayInfoModal({Key? key, required this.totalMoneyFromTicket, required this.warehouseId, required this.reason}) : super(key: key);

  @override
  ConsumerState<PayInfoModal> createState() =>
      // ignore: no_logic_in_create_state
      _PayInfoModalState(totalMoneyFromTicket, warehouseId, reason);
}

class _PayInfoModalState extends ConsumerState<PayInfoModal> with TickerProviderStateMixin {
  late TabController _tabController;

  final double totalMoneyFromTicket;

  final int warehouseId;

  final int reason;

  int tabActive = 0;

  double totalMoney = 0;

  double arrearsMoney = 0;

  double depositsMoney = 0;

  double refundsMoney = 0;

  bool editMoney = false;

  _PayInfoModalState(this.totalMoneyFromTicket, this.warehouseId, this.reason);

  WidgetsToImageController controller = WidgetsToImageController();

  @override
  void initState() {
    super.initState();
    setState(() {
      totalMoney = totalMoneyFromTicket;
    });

    _tabController = TabController(length: 2, vsync: this);
  }

  bool checkMaxDebt(double maxDebt, double currentDebt) {
    bool disable = true;
    if (tabActive == 1) {
      if (maxDebt >= currentDebt) {
        disable = false;
      }
    } else if (tabActive == 0) {
      disable = false;
    }
    return disable;
  }

  Widget receipt() {
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Hóa đơn"),
          ),
        ),
        Container(
          height: 30,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                  child: Text(
                    "Hàng",
                    style: AppTypographies.styBlack11W400Opacity40,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                  child: Text(
                    "Giá",
                    style: AppTypographies.styBlack11W400Opacity40,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                  child: Text(
                    "SL",
                    style: AppTypographies.styBlack11W400Opacity40,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                  child: Text(
                    "%",
                    style: AppTypographies.styBlack11W400Opacity40,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.14,
                  child: Text(
                    "Giá + %",
                    style: AppTypographies.styBlack11W400Opacity40,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.20,
                  child: Text(
                    "Tiền",
                    style: AppTypographies.styBlack11W400Opacity40,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const CustomBouncingScrollPhysics(),
            itemCount: statePos.listTicket!.isNotEmpty ? statePos.listTicket![statePos.selectTicket!].ticketlines!.length : 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  notifierPos.updateIndex("ticketLine", index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                  child: Container(
                    height: 30,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: Text(
                              "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                              style: AppTypographies.styBlack11W400,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Text(
                              notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                              style: AppTypographies.styBlack11W400,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Text(
                              notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit!),
                              style: AppTypographies.styBlack11W400,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              (notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) * 100).toStringAsFixed(2),
                              style: AppTypographies.styBlack11W400,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.14,
                            child: Text(
                              notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! * (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100)),
                              style: AppTypographies.styBlack11W400,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.2,
                            child: Text(
                              notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! *
                                  (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100) *
                                  double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}")),
                              style: AppTypographies.styBlack11W400,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tổng tiền", textAlign: TextAlign.right, style: AppTypographies.styBlack11W400),
              Text(notifierPos.totalMoneyCalculator(statePos.selectTicket!, true), textAlign: TextAlign.right, style: AppTypographies.styBlack11W400),
            ],
          ),
        ),
      ],
    );
  }

  Widget debt() {
    final stateCustomer = ref.watch(customersProvider);
    return Material(
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
                child: SizedBox(
                  height: 350,
                  width: 400,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Nợ",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(
                              width: 300,
                              child: TextFormField(
                                initialValue: totalMoney.toString(),
                                onChanged: (e) {
                                  setState(() {
                                    if (e.isNotEmpty) {
                                      totalMoney = double.parse(e);
                                    }
                                  });
                                },
                                style: AppTypographies.styBlack14W400,
                                textAlign: TextAlign.end,
                              ))
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Tên",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(width: 300, child: Text(stateCustomer.customerSelected != null ? stateCustomer.customerSelected!.name! : "", style: AppTypographies.styBlack14W400))
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Ghi chú",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(width: 300, child: Text(stateCustomer.customerSelected != null ? "${stateCustomer.customerSelected!.note}" : "", style: AppTypographies.styBlack14W400))
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Nợ tối đa",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(
                              width: 300,
                              child: Text(
                                "${stateCustomer.customerSelected != null ? stateCustomer.customerSelected!.maxDebt : 0}",
                                style: AppTypographies.styBlack14W400,
                                textAlign: TextAlign.end,
                              ))
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Nợ hiện tại",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(
                              width: 300,
                              child: Text(
                                "${stateCustomer.customerSelected != null ? stateCustomer.customerSelected!.curDebt!.toStringAsFixed(2) : 0}",
                                style: AppTypographies.styBlack14W400,
                                textAlign: TextAlign.end,
                              ))
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "TT cuối",
                              style: AppTypographies.styBlack14W400,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              stateCustomer.customerSelected != null ? DateFormat.yMd().add_Hms().format(stateCustomer.customerSelected!.curdate!) : "",
                              style: AppTypographies.styBlack14W400,
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
  }

  Widget payment() {
    double screenHeight = MediaQuery.of(context).size.height;
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Column(
      children: [
        WidgetsToImage(
          controller: controller,
          child: receipt(),
        ),
        Row(
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              width: 250,
              child: ListView(
                physics: const CustomBouncingScrollPhysics(),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: notifier.money.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 1,
                      crossAxisCount: 3,
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
              height: screenHeight * 0.27,
              width: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đưa",
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
                        "Thối",
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
                        "Tổng số",
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
                        "Tiền còn",
                        style: AppTypographies.styBlack14W400,
                      ),
                      Text(notifier.convertNumberZero(arrearsMoney), style: AppTypographies.styBlack14W400)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(posSystemPASProvider.notifier);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    final notifierCustomer = ref.read(customersProvider.notifier);
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: tabActive == 0 ? screenHeight : screenHeight * 0.6,
      child: Column(
        children: [
          10.verticalSpace,
          Text(
            AppHelpers.getTranslation("Thanh toán"),
            style: AppTypographies.styBlack22W500,
          ),
          10.verticalSpace,
          Container(
            color: AppColors.white,
            child: TabBar(
              onTap: (e) {
                setState(() {
                  tabActive = e;
                });
              },
              indicatorColor: AppColors.greenMain,
              indicatorWeight: 2,
              labelPadding: EdgeInsets.zero,
              controller: _tabController,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.unselectedTabBar,
              unselectedLabelStyle: AppTypographies.styUnselected14W500,
              labelStyle: AppTypographies.styBlack14W500,
              tabs: [
                Tab(text: AppHelpers.getTranslation("Tiền mặt")),
                Tab(text: AppHelpers.getTranslation("Công nợ")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const CustomBouncingScrollPhysics(),
              children: [payment(), debt()],
            ),
          ),
          10.verticalSpace,
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
                          disable: stateCustomer.customerSelected != null ? checkMaxDebt(stateCustomer.customerSelected!.maxDebt!, (totalMoney + stateCustomer.customerSelected!.curDebt!)) : checkMaxDebt(0, totalMoney),
                          title: AppHelpers.getTranslation(TrKeys.ok),
                          height: 40,
                          width: 100,
                          onPressed: () async {
                            Uint8List? bytes = await controller.capture();
                            String keyEmail = "${stateBase.baseRootInfomation["email"]}_${stateBase.baseInfomation["email"]}";
                            if (tabActive == 0) {
                              context.popRoute();
                              await notifier.createOrder(totalMoney, reason, warehouseId, "cash", keyEmail);
                              notifierBase.getMoneyWallet(keyEmail);
                              await notifierProducts.fetchProductsPos();
                            } else if (tabActive == 1) {
                              context.popRoute();
                              await notifier.createOrder(totalMoney, reason, warehouseId, "debt", keyEmail);
                              notifierBase.getMoneyWallet(keyEmail);
                              await notifierProducts.fetchProductsPos();
                              await notifierCustomer.fetchListCustomers();
                              notifierCustomer.selectCustomer(stateCustomer.customerSelected!.id!);
                            }
                            if (stateCustomer.customerSelected!.email != "") {
                              String customerEmail = stateCustomer.customerSelected!.email!;
                              var receiptData = {"image_base64": base64Encode(bytes!).toString(), "customer_email": customerEmail};
                              await notifierPos.sendEmailReceipt(receiptData);
                            }
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
          20.verticalSpace,
        ],
      ),
    );
  }
}
