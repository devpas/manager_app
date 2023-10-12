import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:intl/intl.dart';

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
                  height: 400,
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
    final notifier = ref.read(posSystemPASProvider.notifier);
    return Material(
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                height: 400,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                child: SizedBox(
                  height: 400,
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
              ),
            ],
          ),
          const BlurLoadingWidget(isLoading: false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(posSystemPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    final notifierCustomer = ref.read(customersProvider.notifier);
    final stateBase = ref.watch(baseProvider);
    final notifierBase = ref.read(baseProvider.notifier);
    return Column(
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
    );
  }
}
