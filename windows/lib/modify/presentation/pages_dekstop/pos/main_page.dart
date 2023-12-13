import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/calculator.dart';
import 'package:marquee/marquee.dart';

import '../../../../src/core/utils/utils.dart';
import '../../../models/data/product_data.dart';
import '../../../riverpob/providers/providers.dart';
import '../../components/components.dart';
import '../../pages/orders/add_modify/widgets/client/client_info_modal.dart';
import '../../pages/orders/add_modify/widgets/order_detail/tickets/list_ticket_modal.dart';
import '../../pages/pos/pos_manage/products_manage/products/widgets/product_item_pos.dart';
import '../../pages/pos/pos_manage/products_manage/products/widgets/products_edit_modal.dart';
import '../../pages/pos/pos_manage/products_manage/products/widgets/products_filter_modal.dart';
import '../../pages/pos/pos_manage/products_manage/warehouse/stock_diary/widgets/select_with_option_mini_button.dart';
import '../../pages/pos/widgets/pay_info_modal_pas.dart';
import '../../pages/pos/widgets/product_short_infomation_modal.dart';
import '../../theme/theme.dart';
import '../widgets/drawer_tablet.dart';

class MainPageDeskTop extends ConsumerStatefulWidget {
  const MainPageDeskTop({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPageDeskTop> createState() => _MainPageDeskTopState();
}

class _MainPageDeskTopState extends ConsumerState<MainPageDeskTop> with TickerProviderStateMixin {
  late TabController _tabController;
  String message = "";
  bool keyboardVisible = false;
  late FocusNode focusNode;
  bool keyboardActive = false;
  double heightContainerProduct = 40;

  int reasonSelected = -1;

  void showKeyboard() {
    focusNode.requestFocus();
    setState(() {
      keyboardVisible = true;
    });
  }

  void dismissKeyboard() {
    focusNode.unfocus();
    setState(() {
      keyboardVisible = false;
    });
  }

  double setHeighProductContainer(double height) {
    setState(() {
      if (keyboardActive) {
        heightContainerProduct = height * 0.1;
      } else {
        heightContainerProduct = height * 0.425;
      }
    });
    return heightContainerProduct;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 2);
    focusNode = FocusNode();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      setState(() {
        if (isVisible) {
          keyboardActive = true;
        } else {
          keyboardActive = false;
        }
      });
    });
    Future.delayed(
      Duration.zero,
      () {
        ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
        ref.read(productsPASProvider.notifier).fetchProductsPos();
        ref.read(productsPASProvider.notifier).getListTaxes();
        ref.read(posSystemPASProvider.notifier).initListTicket();
        ref.read(productsPASProvider.notifier).getListWarehouses();
      },
    );
  }

  Widget posPage() {
    final stateCategories = ref.watch(categoriesPASProvider);
    final stateProducts = ref.watch(productsPASProvider);
    final statePos = ref.watch(posSystemPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierCategories = ref.read(categoriesPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<List> reason = [
      [stateBase.translate[stateBase.languageSelected]["in"], -1],
      [stateBase.translate[stateBase.languageSelected]["out"], 2],
    ];
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Material(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
                child: Builder(
                  builder: (BuildContext context) => InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: Scaffold.of(context).openDrawer,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90.r,
                      height: 60.r,
                      child: Icon(
                        FlutterRemix.menu_line,
                        size: 20.r,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Container(
                  height: 60.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white,
                  ),
                  alignment: Alignment.center,
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return const ClientInfoModal();
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                  width: screenWidth * 0.15,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.inProgressOrders.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Row(
                                      children: [
                                        statePos.infoSelected!.isNotEmpty
                                            ? statePos.infoSelected![0][1] != stateBase.translate[stateBase.languageSelected]["guest"]
                                                ? Expanded(
                                                    child: statePos.infoSelected![0][1].toString().length < 30
                                                        ? Text(statePos.infoSelected![0][1].toString())
                                                        : Marquee(
                                                            text: statePos.infoSelected![0][1].toString(),
                                                            blankSpace: 90,
                                                            velocity: 50,
                                                            accelerationCurve: Curves.linear,
                                                            decelerationCurve: Curves.easeOut,
                                                          ),
                                                  )
                                                : Text(stateBase.translate[stateBase.languageSelected]["guest"])
                                            : Text(stateBase.translate[stateBase.languageSelected]["guest"]),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          15.horizontalSpace,
                          CircleIconButton(
                            backgroundColor: AppColors.blue.withOpacity(0.07),
                            iconData: FlutterRemix.add_line,
                            iconColor: AppColors.blue,
                            onTap: () {
                              if (!statePos.createTicketLoading!) {
                                notifierPos.addTicket();
                              }
                            },
                          ),
                          15.horizontalSpace,
                          CircleIconButton(
                            backgroundColor: AppColors.red.withOpacity(0.07),
                            iconData: FlutterRemix.delete_bin_2_line,
                            iconColor: AppColors.red,
                            onTap: () {
                              if (!statePos.createTicketLoading!) {
                                notifierPos.deleteTicket(statePos.selectTicket);
                              }
                            },
                          ),
                          15.horizontalSpace,
                          CircleIconButton(
                            backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                            iconData: FlutterRemix.menu_2_line,
                            iconColor: AppColors.canceledOrders,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const ListTicketModal();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconTextButton(
                            backgroundColor: AppColors.greenMain.withOpacity(0.07),
                            iconData: FlutterRemix.delete_bin_fill,
                            iconColor: AppColors.greenMain,
                            title: AppHelpers.getTranslation("In"),
                            textColor: AppColors.greenMain,
                            onPressed: () {
                              notifierBase.printEscpos(notifierPos.receipt(statePos.listTicket![statePos.selectTicket!], stateProducts.products!, stateBase.baseInfomation["base_name"]));
                            },
                          ),
                          15.horizontalSpace,
                          IconTextButton(
                            backgroundColor: AppColors.greenMain.withOpacity(0.07),
                            iconData: FlutterRemix.delete_bin_fill,
                            iconColor: AppColors.greenMain,
                            title: AppHelpers.getTranslation("Mở ngăn kéo"),
                            textColor: AppColors.greenMain,
                            onPressed: () {
                              // notifierBase.loadTranslate();
                              print("Mở ngăn kéo");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Container(
                                      width: 825,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        color: AppColors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.15,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: screenWidth * 0.08,
                                                    child: Text(
                                                      stateBase.translate[stateBase.languageSelected]["product_name"],
                                                      style: AppTypographies.styBlack11W400Opacity40,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: SelectWithOptionMiniButton(
                                                      iconData: FlutterRemix.arrow_down_s_line,
                                                      label: stateBase.translate[stateBase.languageSelected]["category"],
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) => Material(
                                                            color: AppColors.white,
                                                            child: Padding(
                                                              padding: REdgeInsets.symmetric(horizontal: 15.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  24.verticalSpace,
                                                                  Text(
                                                                    stateBase.translate[stateBase.languageSelected]["select_reason"],
                                                                    style: AppTypographies.styBlack22W500,
                                                                  ),
                                                                  24.verticalSpace,
                                                                  ListView.builder(
                                                                    shrinkWrap: true,
                                                                    physics: const CustomBouncingScrollPhysics(),
                                                                    itemCount: reason.length,
                                                                    itemBuilder: (context, index) {
                                                                      return ListTile(
                                                                        leading: Container(
                                                                          height: 20.r,
                                                                          width: 20.r,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10.r),
                                                                            color: reasonSelected == reason[index][1] ? AppColors.white : AppColors.transparent,
                                                                            border: Border.all(
                                                                              color: reasonSelected == reason[index][1] ? AppColors.greenMain : AppColors.productBorder,
                                                                              width: reasonSelected == reason[index][1] ? 6.r : 2.r,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onTap: () {
                                                                          setState(() {
                                                                            reasonSelected = reason[index][1];
                                                                          });
                                                                          context.popRoute();
                                                                        },
                                                                        title: Text(reason[index][0].toString()),
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
                                                      title: reason.where((r) => r[1] == reasonSelected).first[0],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.08,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["price"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.08,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["quantity"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.08,
                                              child: Text(
                                                "%",
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                              child: Text(
                                                "${stateBase.translate[stateBase.languageSelected]["price"]} %",
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.2,
                                              child: Text(
                                                stateBase.translate[stateBase.languageSelected]["money"],
                                                style: AppTypographies.styBlack11W400Opacity40,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 245,
                                    width: 825,
                                    child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
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
                                                        width: screenWidth * 0.15,
                                                        child: Text(
                                                          "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.08,
                                                        child: Text(
                                                          notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                          textAlign: TextAlign.right,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.08,
                                                        child: Text(
                                                          notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit!),
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                          textAlign: TextAlign.right,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.08,
                                                        child: Text(
                                                          (notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) * 100).toStringAsFixed(2),
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                          textAlign: TextAlign.right,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.1,
                                                        child: Text(
                                                          notifierPos.convertNumberZero(
                                                              statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! * (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100)),
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                                          textAlign: TextAlign.right,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.2,
                                                        child: Text(
                                                          notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! *
                                                              (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100) *
                                                              double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}")),
                                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
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
                                  ),
                                ],
                              ),
                            ),
                            10.horizontalSpace,
                            Container(
                              height: 390,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                  CircleIconButton(
                                    backgroundColor: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.07) : Colors.red.withOpacity(0.07),
                                    iconData: Icons.close,
                                    iconColor: statePos.createTicketLoading! ? Colors.grey : Colors.red,
                                    onTap: () {
                                      if (!statePos.createTicketLoading!) {
                                        notifierPos.deleteTicketline(statePos.selectTicket, statePos.selectTicketLine);
                                        setState(() {
                                          statePos.selectTicketLine;
                                          if (statePos.selectTicketLine! > 0) {
                                            notifierPos.updateIndex("ticketLine", statePos.selectTicketLine! - 1);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                  15.verticalSpace,
                                  CircleIconButton(
                                    backgroundColor: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.07) : Colors.orange.withOpacity(0.07),
                                    iconData: Icons.edit,
                                    iconColor: statePos.createTicketLoading! ? Colors.grey : Colors.orange,
                                    onTap: () {
                                      if (statePos.listTicket![statePos.selectTicket!].ticketlines!.isNotEmpty && !statePos.createTicketLoading!) {
                                        print(statePos.listTicket![statePos.selectTicket!].ticketlines!.length);
                                        print(statePos.selectTicket);
                                        print(statePos.selectTicketLine);
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => ProductEditModal(statePos.listTicket![statePos.selectTicket!].ticketlines![statePos.selectTicketLine!], statePos.selectTicketLine, statePos.selectTicket),
                                        );
                                      }
                                    },
                                  ),
                                  15.verticalSpace,
                                  CircleIconButton(
                                    backgroundColor: Colors.purple.withOpacity(0.07),
                                    iconData: Icons.search,
                                    iconColor: Colors.purple,
                                    onTap: () {
                                      notifierCategories.setCategorySelected(notifierCategories.noCategory);
                                      Future.delayed(const Duration(milliseconds: 30), () {
                                        notifierProducts.setProductSelected(ProductPasData().initProduct());
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => ProductsFilterModal(),
                                        );
                                      });
                                    },
                                  ),
                                ]),
                              ),
                            )
                          ],
                        )),
                        10.verticalSpace,
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white,
                              ),
                              alignment: Alignment.center,
                              height: 60.r,
                              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Chiết khấu: "),
                                        Expanded(child: TextField()),
                                        VerticalDivider(),
                                        // 10.horizontalSpace,
                                        Text("Tổng: "),
                                        Expanded(child: TextField()),
                                        VerticalDivider(),
                                        // 10.horizontalSpace,
                                        Text("Tổng số: "),
                                        Expanded(child: TextField()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Calculator(
                    onPayment: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return PayInfoModal(
                            totalMoneyFromTicket: double.parse(notifierPos.totalMoneyCalculator(statePos.selectTicket!, false)),
                            warehouseId: notifierBase.checkShareMode() ? stateBase.baseInfomation["warehouse_id"] : stateProducts.warehouseSelected["id"],
                            reason: reasonSelected,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: SizedBox(
                  width: 290,
                  height: 300,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const CustomBouncingScrollPhysics(),
                      itemCount: stateCategories.categories!.length,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return CategoryPosItem(
                          title: '${stateCategories.categories![index].name}',
                          isSelected: statePos.selectCategory == index ? true : false,
                          onTap: () {
                            setState(() {
                              notifierPos.updateIndex("category", index);
                              notifierProducts.getProductByCategory(stateCategories.categories![index].id);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: SizedBox(
                  width: screenWidth * 0.72,
                  height: 300,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      physics: const CustomBouncingScrollPhysics(),
                      children: [
                        stateProducts.products!.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: stateProducts.products!.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.7,
                                  crossAxisCount: 4,
                                ),
                                itemBuilder: (context, index) {
                                  final product = stateProducts.products![index];
                                  return GestureDetector(
                                    onLongPress: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return ProductShortInfoModal(product: product);
                                        },
                                      );
                                    },
                                    onTap: () {
                                      if ((reasonSelected == 2) || (reasonSelected == -1)) {
                                        notifierPos.addTicketline(product, statePos.selectTicket!);
                                        notifierPos.updateIndex("ticketLine", statePos.listTicket![statePos.selectTicket!].ticketlines!.length - 1);
                                      }
                                      notifierProducts.taxCalculate(stateCustomer.customerSelected != null ? statePos.infoSelected![0][4] : "", product.taxCat!);
                                    },
                                    child: ProductItemPOS(
                                      selectWarehouseId: notifierBase.checkShareMode() ? stateBase.baseInfomation["warehouse_id"] : stateProducts.warehouseSelected["id"],
                                      product: product,
                                    ),
                                  );
                                },
                              )
                            : Text(
                                stateBase.translate[stateBase.languageSelected]["product_not_found"],
                                textAlign: TextAlign.center,
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          10.verticalSpace,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBack,
      drawer: const WMainDrawerPosDesktop(),
      //  Drawer(
      //   child: Padding(
      //     padding: REdgeInsets.symmetric(horizontal: 15, vertical: 50),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             CommonImage(
      //               imageUrl: "https://www.clipartmax.com/png/full/319-3191274_male-avatar-admin-profile.png",
      //               width: 50.r,
      //               height: 50.r,
      //               radius: 25,
      //             ),
      //             16.horizontalSpace,
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(
      //                   'user last name',
      //                   style: GoogleFonts.inter(
      //                     fontSize: 14.sp,
      //                     fontWeight: FontWeight.w600,
      //                     letterSpacing: -14 * 0.02,
      //                     color: AppColors.black,
      //                   ),
      //                 ),
      //                 Text(
      //                   'role',
      //                   style: GoogleFonts.inter(
      //                     fontSize: 12.sp,
      //                     fontWeight: FontWeight.w400,
      //                     letterSpacing: -14 * 0.02,
      //                     color: AppColors.black,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //         IconTextButton(
      //           backgroundColor: AppColors.red.withOpacity(0.07),
      //           iconData: FlutterRemix.delete_bin_fill,
      //           iconColor: AppColors.red,
      //           title: AppHelpers.getTranslation("logout"),
      //           textColor: AppColors.red,
      //           onPressed: () {
      //             // LocalStorage.instance.deleteToken();
      //             // LocalStorage.instance.deleteUser();
      //             // LocalStorage.instance.deleteCartProducts();
      //             // context.replaceRoute(const LoginRoute());
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // endDrawer: DeliveriesDrawer(bagShops: rightSideState.bagShops),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.mainBackground),
        child: Column(
          children: [
            20.verticalSpace,
            const SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 700, child: Center(child: Text("POS -abc"))),
                  Text("Logo"),
                ],
              ),
            ),
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
                tabs: const [
                  Tab(text: "profile"),
                  Tab(text: "base"),
                  Tab(text: "pos"),
                  Tab(text: "video"),
                  Tab(text: "chat"),
                  Tab(text: "setting"),
                ],
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const CustomBouncingScrollPhysics(),
                children: [posPage(), posPage(), posPage(), posPage(), posPage(), posPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
