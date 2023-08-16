import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/widgets/order_filter_modal.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/core/constants/constants.dart';
import '../../../../src/core/routes/app_router.gr.dart';
import '../../../../src/core/utils/utils.dart';
import '../../../riverpob/providers/providers.dart';
import '../../../riverpob/states/orders/orders_state.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';
import '../pos/widgets/w_main_drawer_pos.dart';

class OrdersPasPage extends ConsumerStatefulWidget {
  const OrdersPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersPasPage> createState() => _OrdersPasPageState();
}

class _OrdersPasPageState extends ConsumerState<OrdersPasPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        // ref.read(ordersProvider.notifier).setTabController(_tabController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    // ref.read(ordersProvider.notifier).setTabController(_tabController);
  }

  int limitItemLoaded = 50;

  int pageIndexExtend = 1;

  int pageIndexSelected = 0;

  int lengthPage = 0;

  int valueCurrentPage = 1;

  List<int> listLimitItemPerPage = [50, 100, 150, 200];

  int getLengthItem(OrdersPasState state) {
    // print(pageSelected);
    int lengthItem = 0;
    if (state.ticketsAfterFilter!.isNotEmpty) {
      if (state.ticketsAfterFilter!.length <= limitItemLoaded) {
        lengthItem = state.ticketsAfterFilter!.length;
      } else {
        if (state.ticketsAfterFilter!.length <
            limitItemLoaded * pageIndexSelected) {
          lengthItem = state.ticketsAfterFilter!.length -
              limitItemLoaded * (pageIndexSelected - 1);
        } else {
          lengthItem = limitItemLoaded;
        }
      }
    } else {
      if (state.tickets!.length <= limitItemLoaded) {
        lengthItem = state.tickets!.length;
      } else {
        print(state.tickets!.length);
        print(limitItemLoaded * valueCurrentPage);
        if (state.tickets!.length < limitItemLoaded * valueCurrentPage) {
          lengthItem =
              state.tickets!.length - limitItemLoaded * (valueCurrentPage - 1);
        } else {
          lengthItem = limitItemLoaded;
        }
      }
    }
    return lengthItem;
  }

  int getLengthPage(OrdersPasState state, bool limit) {
    if (state.isTicketsLoading) {
      lengthPage = 0;
      pageIndexExtend = 1;
      pageIndexSelected = 0;
    } else {
      if (state.ticketsAfterFilter!.isNotEmpty) {
        lengthPage =
            (state.ticketsAfterFilter!.length / limitItemLoaded).ceil();
      } else {
        lengthPage = (state.tickets!.length / limitItemLoaded).ceil();
      }
      if (lengthPage > 5 && limit == true) {
        lengthPage = 5;
      }
    }
    return lengthPage;
  }

  void getMorePage(int index, int value) {
    // print("pageIndex: $pageIndexExtend");
    // print("index: $index");
    // print("pageSelected: $pageIndexSelected");
    // print("value: $value");
    int maxPage = getLengthPage(ref.watch(orderPasProvider), false) - 1;
    if (index == 4 && (pageIndexExtend < maxPage - 3)) {
      setState(() {
        int pageCalulate = pageIndexExtend + 3;
        int page_wrong = maxPage - pageCalulate;
        if (page_wrong > 0 && page_wrong < 3) {
          pageIndexExtend = pageIndexExtend + page_wrong;
        } else {
          pageIndexExtend = pageCalulate;
        }
        pageIndexSelected = 1;
      });
    } else if (index == 0 && pageIndexExtend > 1) {
      setState(() {
        pageIndexExtend = pageIndexExtend - 3;
        pageIndexSelected = 3;
      });
    }
    // print("------------------------------");
    // print("pageIndex: $pageIndexExtend");
    // print("index: $index");
    // print("pageSelected: $pageIndexSelected");
    // print("value: $value");
  }

  int getIndexFirstItemOfPage(int index) {
    int indexItem = 0;
    if (valueCurrentPage == 1) {
      indexItem = index;
    } else {
      indexItem = index + ((valueCurrentPage - 1) * limitItemLoaded);
    }
    return indexItem;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderPasProvider);
    final notifier = ref.read(orderPasProvider.notifier);
    return Scaffold(
      appBar: CustomAppbarPOS(
        title: Text(
          "Quản lý đơn hàng",
          style: AppTypographies.styBlack16W400,
        ),
        leading: Builder(
          builder: (context) => SmallIconButton(
            icon: Icon(
              FlutterRemix.menu_line,
              size: 24.r,
              color: AppColors.black,
            ),
            onPressed: Scaffold.of(context).openDrawer,
          ),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Kết quả ${state.ticketsAfterFilter!.length}/${state.tickets!.length}",
                style: AppTypographies.styBlack16W400,
              ),
            ),
          )
        ],
      ),
      drawer: const WMainDrawerPos(),
      body: Container(
        color: AppColors.mainBackground,
        child: Column(
          children: [
            SearchTextField(
              onChanged: (e) {
                if (e.length >= 3) {
                  notifier.textSearch = e;
                  notifier.quickSearchOrders();
                } else {
                  notifier.resetSearch();
                }
              },
              hintText: "Lọc đơn hàng",
              suffixIcon: SmallIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => OrderFilterModal(
                      ontap: () {
                        notifier.searchOrders();
                        valueCurrentPage = 1;
                        pageIndexSelected = 0;
                        context.popRoute();
                      },
                    ),
                  );
                },
                icon: Icon(
                  FlutterRemix.sound_module_line,
                  size: 24.r,
                  color: AppColors.black,
                ),
              ),
            ),
            Container(
              height: 40,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: getLengthPage(state, true),
                        itemBuilder: (context, index) {
                          return TextButton(
                              onPressed: () {
                                setState(() {
                                  pageIndexSelected = index;
                                  valueCurrentPage = index + pageIndexExtend;
                                });
                                getMorePage(index, pageIndexExtend);
                              },
                              child: Text(
                                "${index + pageIndexExtend}",
                                style: TextStyle(
                                    color: pageIndexSelected == index
                                        ? AppColors.greenMain
                                        : Colors.black),
                              ));
                        }),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Material(
                            color: AppColors.mainBackground,
                            child: Container(
                              padding: REdgeInsets.only(
                                top: 20,
                                left: 15,
                                right: 15,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonInputField(
                                          initialValue:
                                              notifier.ticketId.toString(),
                                          label: "Đến Trang",
                                          onChanged: (e) {
                                            if (e != "") {
                                              notifier.ticketId = int.parse(e);
                                            }
                                            print(notifier.ticketId);
                                          },
                                          inputType: TextInputType.number,
                                          inputAction: TextInputAction.next,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          "/${getLengthPage(state, false)}",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.4,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        initialValue: 50.toString(),
                                        elevation: 0,
                                        itemBuilder: (context) {
                                          final listProfile =
                                              listLimitItemPerPage;
                                          return List.generate(
                                              listProfile.length,
                                              (index) => PopupMenuItem<String>(
                                                    onTap: () {
                                                      setState(() {
                                                        limitItemLoaded =
                                                            listLimitItemPerPage[
                                                                index];
                                                      });
                                                    },
                                                    child: Text(
                                                      listProfile[index]
                                                          .toString(),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors.black,
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 20, 10, 0),
                                          child: Text(
                                            "Đơn hàng/trang: ${limitItemLoaded.toString()}",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              letterSpacing: -0.4,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "$valueCurrentPage/${getLengthPage(state, false)}",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: state.isTicketsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.greenMain,
                        strokeWidth: 3.r,
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
                          itemCount: getLengthItem(state),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var order;
                            if (state.ticketsAfterFilter!.isNotEmpty) {
                              order = state.ticketsAfterFilter![index];
                            } else {
                              order = state
                                  .tickets![getIndexFirstItemOfPage(index)];
                            }
                            return OrderPasItem(
                              order: order,
                              onTap: () => context.pushRoute(
                                  OrderDetailsPasRoute(order: order)),
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
