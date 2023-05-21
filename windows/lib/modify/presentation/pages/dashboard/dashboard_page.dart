import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add/widgets/client/client_info_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add/widgets/order_detail/pay_info_modal_pas.dart';
import 'package:g_manager_app/modify/presentation/pages/orders/add/widgets/order_detail/tickets/list_ticket_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/products/widgets/products_edit_modal.dart';
import 'package:g_manager_app/modify/presentation/pages/products/widgets/products_filter_modal.dart';

import '../../../../src/riverpod/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import '../../../../modify/presentation/theme/theme.dart';
import '../../../../modify/presentation/components/components.dart';
import '../products/widgets/products_product_item_pos.dart';

class DashboardPASPage extends ConsumerStatefulWidget {
  const DashboardPASPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPASPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPASPage> {
  String message = "";
  double heightContainerProduct = 340;
  String selectWarehouse = "warehouse_1";
  bool keyboardVisible = false;
  late FocusNode focusNode;

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

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      if (isVisible) {
        setState(() {
          heightContainerProduct = 70;
        });
      } else {
        setState(() {
          heightContainerProduct = 340;
        });
      }
    });
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).fetchProductsPos();
        ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
        ref.read(posSystemPASProvider.notifier).initListTicket();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final stateCategories = ref.watch(categoriesPASProvider);
    final stateProducts = ref.watch(productsPASProvider);
    final statePos = ref.watch(posSystemPASProvider);
    final notifierPos = ref.read(posSystemPASProvider.notifier);
    final notifierCategories = ref.read(categoriesPASProvider.notifier);
    final notifierProducts = ref.read(productsPASProvider.notifier);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.mainBackground,
        body: Column(
          children: [
            Container(
              height: 30,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Hàng",
                        style: AppTypographies.styBlack11W400Opacity40,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "Giá",
                        style: AppTypographies.styBlack11W400Opacity40,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        "SL",
                        style: AppTypographies.styBlack11W400Opacity40,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        "%",
                        style: AppTypographies.styBlack11W400Opacity40,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Giá + %",
                        style: AppTypographies.styBlack11W400Opacity40,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: 80,
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
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
              child: SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const CustomBouncingScrollPhysics(),
                  itemCount: statePos.listTicket != null
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
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: Container(
                          height: 30,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "${notifierProducts.listProductPos.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    notifierPos.convertNumberZero(double.parse(
                                        "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}",
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}%",
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    notifierPos.convertNumberZero(statePos
                                            .listTicket![statePos.selectTicket!]
                                            .ticketlines![index]
                                            .price! *
                                        (1 +
                                            int.parse(
                                                    "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}") /
                                                100)),
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    notifierPos.convertNumberZero(statePos
                                            .listTicket![statePos.selectTicket!]
                                            .ticketlines![index]
                                            .price! *
                                        (1 +
                                            int.parse(
                                                    "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].taxId}") /
                                                100) *
                                        int.parse(
                                            "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}")),
                                    style: statePos.selectTicketLine == index
                                        ? AppTypographies.styGreen11W700
                                        : AppTypographies.styBlack11W700,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
              child: Container(
                height: 40,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    children: [
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
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            padding: REdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(53.r),
                              color: const Color.fromARGB(255, 202, 199, 199),
                            ),
                            child: Text(
                              statePos.listTicket != null
                                  ? "${statePos.listTicket![statePos.selectTicket!].title}"
                                  : "",
                              textAlign: TextAlign.center,
                              style: AppTypographies.styBlack10W500,
                            ),
                          ),
                        ),
                      ),
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
                              width: 30.r,
                              height: 30.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color:
                                    AppColors.inProgressOrders.withOpacity(0.1),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person,
                                size: 20.r,
                                color: AppColors.inProgressOrders,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          notifierCategories.setCategorySelected(
                              notifierCategories.noCategory);
                          Future.delayed(const Duration(milliseconds: 30), () {
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
                                color:
                                    AppColors.canceledOrders.withOpacity(0.1),
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
                            textAlign: TextAlign.center,
                            style: AppTypographies.styBlack11W400),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(0, 5, 0, 0),
              child: (stateCategories.categories!.isNotEmpty &&
                      stateProducts.products!.isNotEmpty)
                  ? SizedBox(
                      height: heightContainerProduct,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: REdgeInsets.symmetric(vertical: 5),
                              physics: const CustomBouncingScrollPhysics(),
                              itemCount: stateCategories.categories!.length,
                              shrinkWrap: false,
                              itemBuilder: (context, index) {
                                return CategoryPosItem(
                                  title:
                                      '${stateCategories.categories![index].name}',
                                  isSelected: statePos.selectCategory == index
                                      ? true
                                      : false,
                                  onTap: () {
                                    setState(() {
                                      notifierPos.updateIndex(
                                          "category", index);
                                      // notifierProducts.fetchProductsByCategory(
                                      //     stateCategories
                                      //         .categories![index].id);
                                      notifierProducts.getProductByCategory(
                                          stateCategories
                                              .categories![index].id);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 310,
                            child: ListView(
                              physics: const CustomBouncingScrollPhysics(),
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: stateProducts.products!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.75,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product =
                                        stateProducts.products![index];
                                    return TextButton(
                                      onPressed: () {
                                        TicketLineData ticketline = TicketLineData(
                                            id: notifierPos
                                                    .listTicket[
                                                        statePos.selectTicket!]
                                                    .ticketlines!
                                                    .isNotEmpty
                                                ? notifierPos
                                                        .listTicket[statePos
                                                            .selectTicket!]
                                                        .ticketlines!
                                                        .length +
                                                    1
                                                : 1,
                                            ticketId: notifierPos
                                                .listTicket[
                                                    statePos.selectTicket!]
                                                .ticketId,
                                            line: 1,
                                            productId: stateProducts
                                                .products![index].id,
                                            attributesetInstanceId: 1,
                                            unit: 1,
                                            price: double.parse(
                                                "${stateProducts.products![index].priceSell}"),
                                            taxId: int.parse(
                                                "${stateProducts.products![index].taxCat}"),
                                            attributes: "");
                                        notifierPos.addTicketline(
                                            product, statePos.selectTicket);
                                      },
                                      child: ProductsProductItemPOS(
                                        selectWarehouse: selectWarehouse,
                                        product: product,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppColors.greenMain,
                    ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                height: 40,
                color: Colors.white,
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if (statePos.listTicket![statePos.selectTicket!]
                          .ticketlines!.isNotEmpty) {
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
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: notifierPos.listTicket.isNotEmpty
                              ? (notifierPos.listTicket[statePos.selectTicket!]
                                      .ticketlines!.isNotEmpty
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
                            : Icon(
                                FlutterRemix.money_dollar_box_line,
                                size: 20.r,
                                color: notifierPos.listTicket.isNotEmpty
                                    ? (notifierPos
                                            .listTicket[statePos.selectTicket!]
                                            .ticketlines!
                                            .isNotEmpty
                                        ? Colors.green
                                        : Colors.grey)
                                    : Colors.grey.withOpacity(0.1),
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
                      : GestureDetector(
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
                  GestureDetector(
                    onTap: () {
                      notifierPos.deleteTicketline(
                          statePos.selectTicket, statePos.selectTicketLine);
                      setState(() {
                        statePos.selectTicketLine;
                        if (statePos.selectTicketLine! > 0) {
                          notifierPos.updateIndex(
                              "ticketLine", statePos.selectTicketLine! - 1);
                        }
                      });
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
                          Icons.close,
                          size: 20.r,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(statePos.selectTicketLine);
                      if (statePos.listTicket![statePos.selectTicket!]
                          .ticketlines!.isNotEmpty) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ProductEditModal(
                              statePos.listTicket![statePos.selectTicket!]
                                  .ticketlines![statePos.selectTicketLine!],
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
                          color: Colors.orange.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.edit,
                          size: 20.r,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      notifierPos.addTicket();
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
                          Icons.add,
                          size: 20.r,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      notifierPos.deleteTicket(statePos.selectTicket);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Container(
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.blue.withOpacity(0.1),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.delete,
                          size: 20.r,
                          color: Colors.blue,
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
                    width: 60,
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
                ]),
              ),
            )
          ],
        ));
  }
}
