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
import '../../../models/models.dart';
import '../../../riverpob/states/base/base_state.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';

class PayInfoModal extends ConsumerStatefulWidget {
  final int warehouseId;
  const PayInfoModal({Key? key, required this.warehouseId}) : super(key: key);

  @override
  ConsumerState<PayInfoModal> createState() =>
      // ignore: no_logic_in_create_state
      _PayInfoModalState(warehouseId);
}

class _PayInfoModalState extends ConsumerState<PayInfoModal> with TickerProviderStateMixin {
  late TabController _tabController;

  final int warehouseId;

  int tabActive = 0;

  double totalMoney = 0;

  double arrearsMoney = 0;

  double depositsMoney = 0;

  double refundsMoney = 0;

  bool editMoney = false;

  CustomerData? customerSelected;

  _PayInfoModalState(this.warehouseId);

  WidgetsToImageController controller = WidgetsToImageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        getCustomerInfomation();
      },
    );

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

  void getCustomerInfomation() {
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierCustomer = ref.read(customersProvider.notifier);
    final statePos = ref.watch(posSystemPASProvider);
    setState(() {
      if (notifierPos.infoSelected[0][1] != "Khách lẻ") {
        customerSelected = notifierCustomer.getCustomeById(notifierPos.infoSelected[0][0]);
      } else {
        customerSelected = CustomerData().initCustomer();
      }
      totalMoney = double.parse(notifierPos.totalMoneyCalculator(statePos.selectTicket!, false));
    });
  }

  Widget debt(BaseState stateBase) {
    final stateCustomer = ref.watch(customersProvider);
    return Material(
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["debt"],
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
                            stateBase.translate[stateBase.languageSelected]["name"],
                            style: AppTypographies.styBlack14W400,
                          ),
                        ),
                        SizedBox(width: 300, child: Text(customerSelected != null ? customerSelected!.name! : "", style: AppTypographies.styBlack14W400))
                      ],
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["notes"],
                            style: AppTypographies.styBlack14W400,
                          ),
                        ),
                        SizedBox(width: 300, child: Text(customerSelected != null ? "${customerSelected!.note}" : "", style: AppTypographies.styBlack14W400))
                      ],
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["max_debt"],
                            style: AppTypographies.styBlack14W400,
                          ),
                        ),
                        SizedBox(
                            width: 300,
                            child: Text(
                              "${customerSelected != null ? customerSelected!.maxDebt : 0}",
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
                            stateBase.translate[stateBase.languageSelected]["current_debt"],
                            style: AppTypographies.styBlack14W400,
                          ),
                        ),
                        SizedBox(
                            width: 300,
                            child: Text(
                              "${customerSelected != null ? customerSelected!.curDebt!.toStringAsFixed(2) : 0}",
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
                            stateBase.translate[stateBase.languageSelected]["debt_expire_time"],
                            style: AppTypographies.styBlack14W400,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            customerSelected != null ? DateFormat.yMd().add_Hms().format(customerSelected!.curdate!) : "",
                            style: AppTypographies.styBlack14W400,
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
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
    final statePos = ref.watch(posSystemPASProvider);
    final stateProduct = ref.watch(productsPASProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          10.verticalSpace,
          Text(
            stateBase.translate[stateBase.languageSelected]["payment"],
            style: AppTypographies.styBlack22W500,
          ),
          10.verticalSpace,
          WidgetsToImage(
            controller: controller,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(stateBase.translate[stateBase.languageSelected]["receipt"]),
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
                          width: screenWidth * 0.15,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["product_name"],
                            style: AppTypographies.styBlack11W400Opacity40,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["price"],
                            style: AppTypographies.styBlack11W400Opacity40,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["quantity"],
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
                          width: screenWidth * 0.07,
                          child: Text(
                            "${stateBase.translate[stateBase.languageSelected]["price"]} + %",
                            style: AppTypographies.styBlack11W400Opacity40,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                          child: Text(
                            stateBase.translate[stateBase.languageSelected]["price"],
                            style: AppTypographies.styBlack11W400Opacity40,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const CustomBouncingScrollPhysics(),
                    itemCount: statePos.listTicket!.isNotEmpty ? statePos.listTicket![statePos.selectTicket!].ticketlines!.length : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
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
                                    width: screenWidth * 0.15,
                                    child: Text(
                                      "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                      style: AppTypographies.styBlack11W400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.05,
                                    child: Text(
                                      notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                      style: AppTypographies.styBlack11W400,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.05,
                                    child: Text(
                                      notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit!),
                                      style: AppTypographies.styBlack11W400,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.1,
                                    child: Text(
                                      (notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) * 100).toStringAsFixed(2),
                                      style: AppTypographies.styBlack11W400,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.07,
                                    child: Text(
                                      notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! * (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100)),
                                      style: AppTypographies.styBlack11W400,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.1,
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
                      Text(stateBase.translate[stateBase.languageSelected]["total_money"], textAlign: TextAlign.right, style: AppTypographies.styBlack11W400),
                      Text(notifierPos.totalMoneyCalculator(statePos.selectTicket!, true), textAlign: TextAlign.right, style: AppTypographies.styBlack11W400),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                Tab(text: stateBase.translate[stateBase.languageSelected]["cash"]),
                Tab(text: stateBase.translate[stateBase.languageSelected]["debt"]),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const CustomBouncingScrollPhysics(),
              children: [payment(stateBase), debt(stateBase)],
            ),
          ),
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
                          disable: customerSelected != null ? checkMaxDebt(customerSelected!.maxDebt!, (totalMoney + customerSelected!.curDebt!)) : true,
                          title: AppHelpers.getTranslation(TrKeys.ok),
                          height: 40,
                          width: 100,
                          onPressed: () async {
                            // notifierBase.printEscpos(notifierPos.receipt(statePos.listTicket![statePos.selectTicket!], stateProduct.products!, stateBase.baseInfomation["base_name"]));

                            Uint8List? bytes = await controller.capture();
                            String keyEmail = "${stateBase.baseRootInfomation["email"]}_${stateBase.baseInfomation["email"]}";
                            if (tabActive == 0) {
                              context.popRoute();
                              print("total money :$totalMoney");
                              await notifier.createOrder(totalMoney, statePos.selectReason!, warehouseId, "cash", keyEmail);
                              notifierBase.getMoneyWallet(keyEmail);
                              await notifierProducts.fetchProductsPos();
                            } else if (tabActive == 1 && checkMaxDebt(customerSelected!.maxDebt!, (totalMoney + customerSelected!.curDebt!))) {
                              context.popRoute();
                              await notifier.createOrder(totalMoney, statePos.selectReason!, warehouseId, "debt", keyEmail);
                              notifierBase.getMoneyWallet(keyEmail);
                              await notifierProducts.fetchProductsPos();
                              await notifierCustomer.fetchListCustomers();
                              notifierCustomer.selectCustomer(customerSelected!.id!);
                            }
                            if (customerSelected!.email != "") {
                              String customerEmail = customerSelected!.email!;
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
        ],
      ),
    );
  }
}
