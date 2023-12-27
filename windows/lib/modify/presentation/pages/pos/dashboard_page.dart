import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add_modify/widgets/client/client_info_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/product_in_warehouse/widgets/select_warehouse_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/widgets/pay_info_modal_pas.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add_modify/widgets/order_detail/tickets/list_ticket_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/products_edit_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/products_filter_modal.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:marquee/marquee.dart';

import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';
import 'pos_manage/products_manage/products/widgets/product_item_pos.dart';
import 'pos_manage/products_manage/warehouse/stock_diary/widgets/select_with_option_mini_button.dart';
import 'widgets/product_short_infomation_modal.dart';

class DashboardPASPage extends ConsumerStatefulWidget {
  const DashboardPASPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPASPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPASPage> {
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

  @override
  Widget build(BuildContext context) {
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
      [stateBase.translate[stateBase.languageSelected]["out"], -1],
      [stateBase.translate[stateBase.languageSelected]["in"], 2],
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.mainBackground,
        body: notifierBase.checkAccessPage("pos-system", "pos-page")
            ? Column(
                children: [
                  Container(
                    height: 30,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.1,
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
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Text(
                              stateBase.translate[stateBase.languageSelected]["price"],
                              style: AppTypographies.styBlack11W400Opacity40,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
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
                            width: screenWidth * 0.14,
                            child: Text(
                              "${stateBase.translate[stateBase.languageSelected]["price"]} %",
                              style: AppTypographies.styBlack11W400Opacity40,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.20,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                    child: SizedBox(
                      height: screenHeight * 0.25,
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
                                        width: screenWidth * 0.3,
                                        child: Text(
                                          "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.1,
                                        child: Text(
                                          notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.1,
                                        child: Text(
                                          notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit!),
                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Text(
                                          (notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) * 100).toStringAsFixed(2),
                                          style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.14,
                                        child: Text(
                                          notifierPos.convertNumberZero(statePos.listTicket![statePos.selectTicket!].ticketlines![index].price! * (1 + notifierProducts.taxCalculate(statePos.infoSelected![0][4], statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId!) / 100)),
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
                  Container(
                    height: screenHeight * 0.045,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Row(
                        children: [
                          InkWell(
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
                                  width: screenWidth * 0.35,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.inProgressOrders.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                          InkWell(
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
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                  width: 30.r,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.canceledOrders.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    size: 20.r,
                                    color: AppColors.canceledOrders,
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              notifierBase.printEscpos(notifierPos.receipt(statePos.listTicket![statePos.selectTicket!], stateProducts.products!, stateBase.baseInfomation["base_name"]));
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                width: 30.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: AppColors.deliveredOrders.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.print,
                                  size: 20.r,
                                  color: AppColors.deliveredOrders,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              notifierBase.loadTranslate();
                              print("Mở ngăn kéo");
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                width: 30.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.red.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.wallet,
                                  size: 20.r,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          notifierBase.checkShareMode()
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => const SelectWarehouseModal(),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Container(
                                      width: 30.r,
                                      height: 30.r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: Colors.purple.withOpacity(0.1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.warehouse,
                                        size: 20.r,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                          Text("${stateBase.translate[stateBase.languageSelected]["total_money_short"]}: ", style: AppTypographies.styBlack11W400),
                          Expanded(
                            child: Text(notifierPos.totalMoneyCalculator(statePos.selectTicket!, true), textAlign: TextAlign.right, style: AppTypographies.styBlack11W400),
                          )
                        ],
                      ),
                    ),
                  ),
                  stateCategories.categories!.isNotEmpty
                      ? SizedBox(
                          height: setHeighProductContainer(screenHeight),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: SizedBox(
                                  width: screenWidth * 0.25,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: SizedBox(
                                  width: screenWidth * 0.75,
                                  child: ListView(
                                    physics: const CustomBouncingScrollPhysics(),
                                    children: [
                                      stateProducts.products!.isNotEmpty
                                          ? GridView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: stateProducts.products!.length,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1.9,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder: (context, index) {
                                                final product = stateProducts.products![index];
                                                return InkWell(
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
                              )
                            ],
                          ),
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppColors.greenMain,
                        ),
                  Padding(
                    padding: REdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Container(
                      height: screenHeight * 0.045,
                      color: Colors.white,
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const ListTicketModal();
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.pinkAccent.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                statePos.listTicket!.isNotEmpty ? statePos.listTicket!.length.toString() : "1",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.pinkAccent, fontSize: 11.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        keyboardVisible
                            ? InkWell(
                                onTap: () {
                                  dismissKeyboard();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Container(
                                    width: 30.r,
                                    height: 30.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20.r,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  showKeyboard();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Container(
                                    width: 30.r,
                                    height: 30.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.keyboard,
                                      size: 20.r,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              ),
                        InkWell(
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close,
                                size: 20.r,
                                color: statePos.createTicketLoading! ? Colors.grey : Colors.red,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.edit,
                                size: 20.r,
                                color: statePos.createTicketLoading! ? Colors.grey : Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (!statePos.createTicketLoading!) {
                              notifierPos.addTicket();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.1) : Colors.purple.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                size: 20.r,
                                color: statePos.createTicketLoading! ? Colors.grey : Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (!statePos.createTicketLoading!) {
                              notifierPos.deleteTicket(statePos.selectTicket);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: statePos.createTicketLoading! ? Colors.grey.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.delete,
                                size: 20.r,
                                color: statePos.createTicketLoading! ? Colors.grey : Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: TextField(
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 40,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (statePos.listTicket![statePos.selectTicket!].ticketlines!.isNotEmpty && !statePos.createTicketLoading!) {
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
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Container(
                                width: 50.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: notifierPos.listTicket.isNotEmpty ? (notifierPos.listTicket[statePos.selectTicket!].ticketlines!.isNotEmpty ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1)) : Colors.grey.withOpacity(0.1),
                                ),
                                alignment: Alignment.center,
                                child: statePos.createTicketLoading!
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.greenMain,
                                      )
                                    : Text(
                                        "=",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: notifierPos.listTicket.isNotEmpty ? (notifierPos.listTicket[statePos.selectTicket!].ticketlines!.isNotEmpty ? Colors.green : Colors.grey) : Colors.grey.withOpacity(0.1),
                                        ),
                                      )),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              )
            : const SizedBox());
  }
}
