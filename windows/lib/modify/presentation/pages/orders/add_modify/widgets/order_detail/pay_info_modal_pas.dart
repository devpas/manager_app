import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import '../../../../pos/pos_manage/products_manage/warehouse/stock_diary/widgets/select_with_option_mini_button.dart';

class PayInfoModal extends ConsumerStatefulWidget {
  final double totalMoneyFromTicket;
  const PayInfoModal(this.totalMoneyFromTicket, {Key? key}) : super(key: key);

  @override
  ConsumerState<PayInfoModal> createState() =>
      // ignore: no_logic_in_create_state
      _PayInfoModalState(totalMoneyFromTicket);
}

class _PayInfoModalState extends ConsumerState<PayInfoModal>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final double totalMoneyFromTicket;

  double totalMoney = 0;

  double arrearsMoney = 0;

  double depositsMoney = 0;

  double refundsMoney = 0;

  bool editMoney = false;

  List<List> reason = [
    ["(Xuất)bán hàng", -1],
    ["(Xuất)trả hàng", -2],
    ["(Xuất)hỏng vỡ", -3],
    ["(Nhập)mua vào", 1],
    ["(Nhập)hàng trả", 2],
  ];

  int reasonSelected = -1;

  _PayInfoModalState(this.totalMoneyFromTicket);

  @override
  void initState() {
    super.initState();
    setState(() {
      totalMoney = totalMoneyFromTicket;
    });

    _tabController = TabController(length: 1, vsync: this);
  }

  Widget payment() {
    final state = ref.watch(posSystemPASProvider);
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  depositsMoney +=
                                      notifier.money[index]["price"];
                                } else {
                                  depositsMoney =
                                      notifier.money[index]["price"];
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
                          Text(
                              editMoney
                                  ? notifier.convertNumberZero(depositsMoney)
                                  : notifier.convertNumberZero(totalMoney),
                              style: AppTypographies.styBlack14W400)
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
                          Text(notifier.convertNumberZero(refundsMoney),
                              style: AppTypographies.styBlack14W400)
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
                          Text(notifier.convertNumberZero(totalMoney),
                              style: AppTypographies.styBlack14W400)
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
                          Text(notifier.convertNumberZero(arrearsMoney),
                              style: AppTypographies.styBlack14W400)
                        ],
                      ),
                      40.verticalSpace,
                      SizedBox(
                        child: SelectWithOptionMiniButton(
                          iconData: FlutterRemix.arrow_down_s_line,
                          label: 'Danh mục',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Material(
                                color: AppColors.white,
                                child: Padding(
                                  padding:
                                      REdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      24.verticalSpace,
                                      Text(
                                        "Chọn lý do",
                                        style: AppTypographies.styBlack22W500,
                                      ),
                                      24.verticalSpace,
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const CustomBouncingScrollPhysics(),
                                        itemCount: reason.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Container(
                                              height: 20.r,
                                              width: 20.r,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: reasonSelected ==
                                                        reason[index][1]
                                                    ? AppColors.white
                                                    : AppColors.transparent,
                                                border: Border.all(
                                                  color: reasonSelected ==
                                                          reason[index][1]
                                                      ? AppColors.greenMain
                                                      : AppColors.productBorder,
                                                  width: reasonSelected ==
                                                          reason[index][1]
                                                      ? 6.r
                                                      : 2.r,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                reasonSelected =
                                                    reason[index][1];
                                              });
                                              context.popRoute();
                                            },
                                            title: Text(
                                                reason[index][0].toString()),
                                          );
                                        },
                                      ),
                                      50.verticalSpace,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          title: reason
                              .where((r) => r[1] == reasonSelected)
                              .first[0],
                        ),
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
              // Tab(text: AppHelpers.getTranslation("Công nợ")),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const CustomBouncingScrollPhysics(),
            children: [
              payment()
              // , payment()
            ],
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
                        disable: false,
                        title: AppHelpers.getTranslation(TrKeys.ok),
                        height: 40,
                        width: 100,
                        onPressed: () {
                          notifier.createOrder(totalMoney, reasonSelected);
                          notifierProducts.fetchProductsPos();
                          context.popRoute();
                        })
                    : AccentButtonCustom(
                        disable: true,
                        title: AppHelpers.getTranslation(TrKeys.ok),
                        height: 40,
                        width: 100,
                        onPressed: () {}),
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
