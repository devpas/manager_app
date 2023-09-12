import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add_modify/widgets/client/client_info_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add_modify/widgets/order_detail/pay_info_modal_pas.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add_modify/widgets/order_detail/tickets/list_ticket_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/products_edit_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/products_filter_modal.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:marquee/marquee.dart';

import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import '../../theme/theme.dart';
import '../../components/components.dart';
import 'pos_manage/products_manage/products/widgets/products_product_item_pos.dart';
import 'widgets/product_short_infomation_modal.dart';

class DashboardPASPage extends ConsumerStatefulWidget {
  const DashboardPASPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPASPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPASPage> {
  String message = "";
  int selectWarehouseId = 0;
  bool keyboardVisible = false;
  late FocusNode focusNode;
  bool keyboardActive = false;
  double heightContainerProduct = 40;

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
        ref.read(posSystemPASProvider.notifier).initListTicket();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateCategories = ref.watch(categoriesPASProvider);
    final stateProducts = ref.watch(productsPASProvider);
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierCategories = ref.read(categoriesPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateCustomer = ref.watch(customersProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                            width: screenWidth * 0.25,
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
                            width: screenWidth * 0.2,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                    child: SizedBox(
                      height: screenHeight * 0.25,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const CustomBouncingScrollPhysics(),
                        itemCount: statePos.listTicket!.isNotEmpty
                            ? statePos.listTicket![statePos.selectTicket!]
                                .ticketlines!.length
                            : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              notifierPos.updateIndex("ticketLine", index);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                              child: Container(
                                height: 30,
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.25,
                                        child: Text(
                                          "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.1,
                                        child: Text(
                                          notifierPos.convertNumberZero(
                                              double.parse(
                                                  "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.1,
                                        child: Text(
                                          "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}",
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Text(
                                          "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}",
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.2,
                                        child: Text(
                                          notifierPos.convertNumberZero(statePos
                                                  .listTicket![
                                                      statePos.selectTicket!]
                                                  .ticketlines![index]
                                                  .price! *
                                              (1 +
                                                  int.parse(
                                                          "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}") /
                                                      100)),
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.2,
                                        child: Text(
                                          notifierPos.convertNumberZero(statePos
                                                  .listTicket![
                                                      statePos.selectTicket!]
                                                  .ticketlines![index]
                                                  .price! *
                                              (1 +
                                                  int.parse(
                                                          "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}") /
                                                      100) *
                                              double.parse(
                                                  "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}")),
                                          style: statePos.selectTicketLine ==
                                                  index
                                              ? AppTypographies.styGreen11W400
                                              : AppTypographies.styBlack11W400,
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
                                  width: screenWidth * 0.35,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.inProgressOrders
                                        .withOpacity(0.1),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Row(
                                      children: [
                                        statePos.infoSelected!.isNotEmpty
                                            ? statePos.infoSelected![0][1] !=
                                                    "Khách lẻ"
                                                ? Expanded(
                                                    child: stateCustomer
                                                                .customerSelected!
                                                                .name
                                                                .toString()
                                                                .length <
                                                            30
                                                        ? Text(stateCustomer
                                                            .customerSelected!
                                                            .name
                                                            .toString())
                                                        : Marquee(
                                                            text: stateCustomer
                                                                .customerSelected!
                                                                .name
                                                                .toString(),
                                                            blankSpace: 90,
                                                            velocity: 50,
                                                            accelerationCurve:
                                                                Curves.linear,
                                                            decelerationCurve:
                                                                Curves.easeOut,
                                                          ),
                                                  )
                                                : const Text("khách lẻ")
                                            : const Text("Khách lẻ"),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              notifierCategories.setCategorySelected(
                                  notifierCategories.noCategory);
                              Future.delayed(const Duration(milliseconds: 30),
                                  () {
                                notifierProducts.setProductSelected(
                                    ProductPasData().initProduct());
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
                                    color: AppColors.canceledOrders
                                        .withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    size: 20.r,
                                    color: AppColors.canceledOrders,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                width: 30.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: AppColors.deliveredOrders
                                      .withOpacity(0.1),
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
                          GestureDetector(
                            onTap: () {
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
                          Text("TS: ", style: AppTypographies.styBlack11W400),
                          Expanded(
                            child: Text(
                                notifierPos.totalMoneyCalculator(
                                    statePos.selectTicket!, true),
                                textAlign: TextAlign.right,
                                style: AppTypographies.styBlack11W400),
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
                                    physics:
                                        const CustomBouncingScrollPhysics(),
                                    itemCount:
                                        stateCategories.categories!.length,
                                    shrinkWrap: false,
                                    itemBuilder: (context, index) {
                                      return CategoryPosItem(
                                        title:
                                            '${stateCategories.categories![index].name}',
                                        isSelected:
                                            statePos.selectCategory == index
                                                ? true
                                                : false,
                                        onTap: () {
                                          setState(() {
                                            notifierPos.updateIndex(
                                                "category", index);
                                            notifierProducts
                                                .getProductByCategory(
                                                    stateCategories
                                                        .categories![index].id);
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
                                    physics:
                                        const CustomBouncingScrollPhysics(),
                                    children: [
                                      stateProducts.products!.isNotEmpty
                                          ? GridView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: stateProducts
                                                  .products!.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 2.1,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder: (context, index) {
                                                final product = stateProducts
                                                    .products![index];
                                                return GestureDetector(
                                                  onLongPress: () {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return ProductShortInfoModal(
                                                            product: product);
                                                      },
                                                    );
                                                  },
                                                  onTap: () {
                                                    if (product
                                                            .stocks![
                                                                selectWarehouseId]
                                                            .stockCurrent !=
                                                        0) {
                                                      notifierPos.addTicketline(
                                                          product,
                                                          statePos
                                                              .selectTicket);
                                                    }
                                                  },
                                                  child: ProductsProductItemPOS(
                                                    selectWarehouseId:
                                                        selectWarehouseId,
                                                    product: product,
                                                  ),
                                                );
                                              },
                                            )
                                          : const Text(
                                              "Không tìm thấy sản phẩm",
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
                        GestureDetector(
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
                                statePos.listTicket!.isNotEmpty
                                    ? statePos.listTicket!.length.toString()
                                    : "1",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        keyboardVisible
                            ? GestureDetector(
                                onTap: () {
                                  dismissKeyboard();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                            : GestureDetector(
                                onTap: () {
                                  showKeyboard();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                        GestureDetector(
                          onTap: () {
                            if (!statePos.createTicketLoading!) {
                              notifierPos.deleteTicketline(
                                  statePos.selectTicket,
                                  statePos.selectTicketLine);
                              setState(() {
                                statePos.selectTicketLine;
                                if (statePos.selectTicketLine! > 0) {
                                  notifierPos.updateIndex("ticketLine",
                                      statePos.selectTicketLine! - 1);
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
                                color: statePos.createTicketLoading!
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close,
                                size: 20.r,
                                color: statePos.createTicketLoading!
                                    ? Colors.grey
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (statePos.listTicket![statePos.selectTicket!]
                                    .ticketlines!.isNotEmpty &&
                                !statePos.createTicketLoading!) {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => ProductEditModal(
                                    statePos.listTicket![statePos.selectTicket!]
                                            .ticketlines![
                                        statePos.selectTicketLine!],
                                    statePos.selectTicketLine,
                                    statePos.selectTicket),
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
                                color: statePos.createTicketLoading!
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.edit,
                                size: 20.r,
                                color: statePos.createTicketLoading!
                                    ? Colors.grey
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
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
                                color: statePos.createTicketLoading!
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.purple.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                size: 20.r,
                                color: statePos.createTicketLoading!
                                    ? Colors.grey
                                    : Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
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
                                color: statePos.createTicketLoading!
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.blue.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.delete,
                                size: 20.r,
                                color: statePos.createTicketLoading!
                                    ? Colors.grey
                                    : Colors.blue,
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
                        GestureDetector(
                          onTap: () {
                            if (statePos.listTicket![statePos.selectTicket!]
                                    .ticketlines!.isNotEmpty &&
                                !statePos.createTicketLoading!) {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                      height: 550,
                                      child: PayInfoModal(double.parse(
                                          notifierPos.totalMoneyCalculator(
                                              statePos.selectTicket!, false))));
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
                                  color: notifierPos.listTicket.isNotEmpty
                                      ? (notifierPos
                                              .listTicket[
                                                  statePos.selectTicket!]
                                              .ticketlines!
                                              .isNotEmpty
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.grey.withOpacity(0.1))
                                      : Colors.grey.withOpacity(0.1),
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
                                          color: notifierPos
                                                  .listTicket.isNotEmpty
                                              ? (notifierPos
                                                      .listTicket[statePos
                                                          .selectTicket!]
                                                      .ticketlines!
                                                      .isNotEmpty
                                                  ? Colors.green
                                                  : Colors.grey)
                                              : Colors.grey.withOpacity(0.1),
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
