import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/models.dart';
import '../../components/components.dart';
import '../../pages/orders/widgets/order_filter_modal.dart';
import '../../theme/theme.dart';

class OrdersDesktopPage extends ConsumerStatefulWidget {
  const OrdersDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersDesktopPage> createState() => _OrdersDesktopPageState();
}

class _OrdersDesktopPageState extends ConsumerState<OrdersDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();
  late TabController _tabController;
  bool activeCheckBox = true;

  String inputText = "";

  TicketData ticketSelected = TicketData();
  int indexItemSelected = -1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    Future.delayed(
      Duration.zero,
      () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  String valueTime = "q-1-2024";

  String getNameSellerByPersonId(String personId) {
    String sellerName = "";
    final stateBase = ref.watch(baseProvider);
    if (md5.convert(utf8.encode("${stateBase.baseRootInfomation["email"]}_${stateBase.baseRootInfomation["email"]}")).toString() == personId) {
      sellerName = "${stateBase.baseRootInfomation["base_name"]}-${stateBase.baseRootInfomation["email"]}";
    } else {
      List<EmployeeData> listEmployee = stateBase.employees!;
      for (int i = 0; i < listEmployee.length; i++) {
        if (md5.convert(utf8.encode("${stateBase.baseRootInfomation["email"]}_${listEmployee[i].email}")).toString() == personId) {
          sellerName = "${stateBase.employees![i].name}-${stateBase.employees![i].email}";
        }
      }
    }
    return sellerName;
  }

  Widget calculatorAccount(BuildContext context) {
    final state = ref.watch(orderPasProvider);
    final notifier = ref.read(orderPasProvider.notifier);
    return Container(
      width: 230,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
                        width: 128,
                        height: 60,
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
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
                        width: 128,
                        height: 60,
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
                        width: 60,
                        height: 60,
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
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 128,
                      height: 60,
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
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 5, 3),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.check_line,
                        size: 20,
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderPasProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(customersProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateOrder = ref.watch(orderPasProvider);
    final notifierOrder = ref.read(orderPasProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        drawer: const WMainDrawerPosDesktop(),
        appBar: CustomAppbarPOS(
          title: Text(
            stateBase.translate[stateBase.languageSelected]["order"],
            style: AppTypographies.styBlack16W500,
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (context) => SmallIconButton(
              icon: Icon(
                FlutterRemix.menu_line,
                size: 24,
                color: AppColors.black,
              ),
              onPressed: Scaffold.of(context).openDrawer,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(children: [
                    Container(
                        width: screenWidth * 0.15,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.inProgressOrders.withOpacity(0.1),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: Row(
                            children: [
                              DropdownButton(
                                  value: valueTime,
                                  items: ["q-1-2023", "q-2-2023", "q-3-2023", "q-4-2023", "q-1-2024"].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(width: screenWidth * 0.1, child: Text(value)),
                                    );
                                  }).toList(),
                                  onChanged: (e) {
                                    setState(() {
                                      valueTime = e!;
                                    });
                                  }),
                            ],
                          ),
                        )),
                    SizedBox(
                      child: Row(children: [
                        30.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Tìm kiếm",
                          textColor: AppColors.blue,
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => OrderFilterModal(
                                ontap: () {
                                  notifierOrder.searchOrders();
                                  context.popRoute();
                                },
                              ),
                            );
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Chỉnh sửa",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "Trả lại",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                        20.horizontalSpace,
                        IconTextButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.delete_bin_fill,
                          iconColor: AppColors.blue,
                          title: "In",
                          textColor: AppColors.blue,
                          onPressed: () {
                            // notifierBase.loadTranslate();
                          },
                        ),
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
            //write widget container white , height 500, with 300
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: screenHeight * 0.815,
                    width: screenWidth * 0.735,
                    child: Row(
                      children: [
                        state.listTicketShortData!.length < state.tickets!.length
                            ? SizedBox(
                                width: screenWidth * 0.35,
                                child: state.isTicketsLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.greenMain,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : ListView(
                                        physics: const CustomBouncingScrollPhysics(),
                                        children: [
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: REdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 14,
                                              bottom: 0,
                                            ),
                                            itemCount: state.tickets!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              TicketData order;
                                              if (state.ticketsAfterFilter!.isNotEmpty) {
                                                order = state.ticketsAfterFilter![index];
                                              } else {
                                                order = state.tickets![index];
                                              }
                                              return Column(
                                                children: [
                                                  OrderPasItem(
                                                    order: order,
                                                    onTap: () {
                                                      setState(() {
                                                        print(order.runtimeType);
                                                        ticketSelected = order;
                                                        indexItemSelected = index;
                                                        print(ticketSelected.toJson());
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ))
                            : SizedBox(
                                width: screenWidth * 0.35,
                                child: state.isTicketsLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.greenMain,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : ListView(
                                        physics: const CustomBouncingScrollPhysics(),
                                        children: [
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: REdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 14,
                                              bottom: 0,
                                            ),
                                            itemCount: state.listTicketShortData!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              var order;
                                              order = state.listTicketShortData![index];
                                              return Column(
                                                children: [
                                                  OrderPasShortDataItem(
                                                    order: order,
                                                    onTap: () {
                                                      if (state.ticketInfomationLoading == false) {
                                                        notifierOrder.ticketId = order["ticket_id"];
                                                        setState(() async {
                                                          print(order.runtimeType);
                                                          ticketSelected = (await notifierOrder.searchOrder())!;
                                                          indexItemSelected = index;
                                                          print(ticketSelected.toJson());
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      )),
                        VerticalDivider(),
                        state.ticketInfomationLoading
                            ? const Flexible(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.greenMain,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : SizedBox(
                                child: indexItemSelected != -1
                                    ? Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Đơn hàng-#${ticketSelected.ticketId}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Người xuất phiếu: ${getNameSellerByPersonId(ticketSelected.personId!)}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Khách hàng: ${notifier.getNameCustomeById(ticketSelected.customerId!)}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Ngày xuất phiếu: ${ticketSelected.datenew}"),
                                        const Divider(),
                                        Container(
                                          width: screenWidth * 0.36,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                          child: Row(
                                            children: [
                                              SizedBox(width: screenWidth * 0.15, child: Text("Sản phẩm")),
                                              SizedBox(width: screenWidth * 0.1, child: Text("giá+%")),
                                              SizedBox(width: screenWidth * 0.05, child: Text("SL")),
                                              SizedBox(child: Text("Tổng")),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.36,
                                          height: screenHeight * 0.3,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                          child: ListView(
                                            physics: const CustomBouncingScrollPhysics(),
                                            padding: EdgeInsets.all(3),
                                            children: [
                                              ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: ticketSelected.ticketlines!.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  TicketLineData ticketline = ticketSelected.ticketlines![index];
                                                  TaxlineData taxline = ticketSelected.taxlines![index];
                                                  return Row(
                                                    children: [
                                                      SizedBox(width: screenWidth * 0.15, child: Text("${ticketline.productId}")),
                                                      SizedBox(width: screenWidth * 0.1, child: Text("${taxline.amount!}")),
                                                      SizedBox(width: screenWidth * 0.05, child: Text("${ticketline.unit}")),
                                                      SizedBox(child: Text("${taxline.amount! * ticketline.unit!}")),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("SL món hàng: ${ticketSelected.ticketlines!.length}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Tổng tiền: ${ticketSelected.payments![0].total}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Phương thức thanh toán: ${ticketSelected.payments![0].payment}"),
                                      ])
                                    : const SizedBox())
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: screenHeight * 0.815,
                    width: screenWidth * 0.25,
                    child: Column(children: [
                      calculatorAccount(context),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bán hàng",
                              style: GoogleFonts.inter(
                                color: activeCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            RoundedCheckBox(
                              value: activeCheckBox,
                              onChanged: (value) {
                                setState(() {
                                  activeCheckBox = !activeCheckBox;
                                });
                              },
                            ),
                            10.horizontalSpace,
                            Text(
                              "Thu phí",
                              style: GoogleFonts.inter(
                                color: activeCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            RoundedCheckBox(
                              value: !activeCheckBox,
                              onChanged: (value) {
                                setState(() {
                                  activeCheckBox = !activeCheckBox;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
