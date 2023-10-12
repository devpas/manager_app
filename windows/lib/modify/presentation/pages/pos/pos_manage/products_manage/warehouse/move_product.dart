import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/products_edit_modal.dart';

import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:intl/intl.dart';
import '../../../../../../models/data/product_data.dart';
import '../../../../../theme/theme.dart';
import '../../../../../components/components.dart';
import '../../../pos_manage/products_manage/products/widgets/products_product_item_pos.dart';
import '../../../widgets/product_short_infomation_modal.dart';
import '../products/widgets/products_filter_modal.dart';
import 'stock_diary/widgets/select_with_option_mini_button.dart';

class MoveProductPage extends ConsumerStatefulWidget {
  const MoveProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MoveProductPage> createState() => _MoveProductPageState();
}

class _MoveProductPageState extends ConsumerState<MoveProductPage> {
  String message = "";
  int selectWarehouseId = 0;
  bool keyboardVisible = false;
  late FocusNode focusNode;
  bool keyboardActive = false;
  double heightContainerProduct = 40;
  List<String> reason = ["(Nhập)mua vào", "(Nhập)trả hàng", "(Nhập)chuyển kho", "(Xuất)bán hàng", "(Xuất)trả hàng", "(Xuất)hong vo", "(Xuất)chuyển kho"];

  DateTime dateMoveProduct = DateTime.now();

  int reasonSelected = 0;
  int warehouse1Index = 0;
  int warehouse2Index = 0;
  TextEditingController barCodeController = TextEditingController();

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
        ref.read(productsPASProvider.notifier).resetSearch();
        ref.read(posSystemPASProvider.notifier).initListTicketMoveProduct();
        ref.read(categoriesPASProvider.notifier).fetchCategoriesAppscript();
        ref.read(productsPASProvider.notifier).fetchProductsPos();
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
    final notifierProducts = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final notifierCategories = ref.read(categoriesPASProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        notifierPos.deleteTicket(statePos.selectTicket);
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.mainBackground,
          appBar: CustomAppbarPOS(
            title: Text(
              "Chuyển hàng nội bộ - chuyển kho",
              style: AppTypographies.styBlack16W500,
              textAlign: TextAlign.center,
            ),
            leading: Builder(
              builder: (context) => SmallIconButton(
                icon: Icon(
                  FlutterRemix.arrow_left_s_line,
                  size: 24.r,
                  color: AppColors.black,
                ),
                onPressed: () {
                  context.popRoute();
                },
              ),
            ),
          ),
          body: notifierBase.checkAccessPage("pos-system", "pos-page")
              ? Column(
                  children: [
                    1.verticalSpace,
                    Container(
                      height: 30,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                "Hàng",
                                style: AppTypographies.styBlack11W400Opacity40,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                              child: Text(
                                "Giá",
                                style: AppTypographies.styBlack11W400Opacity40,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Text(
                                "SL",
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
                                          width: screenWidth * 0.5,
                                          child: Text(
                                            "${notifierProducts.listProductCache.where((product) => product.id == statePos.listTicket![statePos.selectTicket!].ticketlines![index].productId).toList().first.name}",
                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.15,
                                          child: Text(
                                            notifierPos.convertNumberZero(double.parse("${statePos.listTicket![statePos.selectTicket!].ticketlines![index].price}")),
                                            style: statePos.selectTicketLine == index ? AppTypographies.styGreen11W400 : AppTypographies.styBlack11W400,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.25,
                                          child: Text(
                                            "${statePos.listTicket![statePos.selectTicket!].ticketlines![index].unit}",
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
                        child: stateProducts.warehouse!.isEmpty
                            ? const Center(child: Text("Loading..."))
                            : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return CustomDatePickerModal(onDateSaved: (DateTime? date) {
                                            setState(() {
                                              dateMoveProduct = date!;
                                            });
                                          });
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Container(
                                          width: screenWidth * 0.24,
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
                                                Expanded(
                                                    child: Text(
                                                  DateFormat.yMd().add_Hms().format(dateMoveProduct),
                                                  style: AppTypographies.styBlack12W400,
                                                ))
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  1.horizontalSpace,
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.355,
                                        child: SelectWithOptionMiniButton(
                                          iconData: FlutterRemix.arrow_down_s_line,
                                          label: 'Kho hàng',
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
                                                        "Chọn kho hàng",
                                                        style: AppTypographies.styBlack22W500,
                                                      ),
                                                      24.verticalSpace,
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const CustomBouncingScrollPhysics(),
                                                        itemCount: stateProducts.warehouse!.length,
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            leading: Container(
                                                              height: 20.r,
                                                              width: 20.r,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.r),
                                                                color: warehouse1Index == index ? AppColors.white : AppColors.transparent,
                                                                border: Border.all(
                                                                  color: warehouse1Index == index ? AppColors.greenMain : AppColors.productBorder,
                                                                  width: warehouse1Index == index ? 6.r : 2.r,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                selectWarehouseId = index;
                                                                warehouse1Index = index;
                                                              });
                                                              context.popRoute();
                                                            },
                                                            title: Text(stateProducts.warehouse![index]["name"].toString()),
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
                                          title: stateProducts.warehouse![warehouse1Index]["name"],
                                        ),
                                      ),
                                    ],
                                  ),
                                  2.horizontalSpace,
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.355,
                                        child: SelectWithOptionMiniButton(
                                          iconData: FlutterRemix.arrow_down_s_line,
                                          label: 'Kho hàng',
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
                                                        "Chọn kho hàng",
                                                        style: AppTypographies.styBlack22W500,
                                                      ),
                                                      24.verticalSpace,
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const CustomBouncingScrollPhysics(),
                                                        itemCount: stateProducts.warehouse!.length,
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            leading: Container(
                                                              height: 20.r,
                                                              width: 20.r,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.r),
                                                                color: warehouse2Index == index ? AppColors.white : AppColors.transparent,
                                                                border: Border.all(
                                                                  color: warehouse2Index == index ? AppColors.greenMain : AppColors.productBorder,
                                                                  width: warehouse2Index == index ? 6.r : 2.r,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                warehouse2Index = index;
                                                              });
                                                              context.popRoute();
                                                            },
                                                            title: Text(stateProducts.warehouse![index]["name"].toString()),
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
                                          title: stateProducts.warehouse![warehouse2Index]["name"],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                                  childAspectRatio: 2.1,
                                                  crossAxisCount: 2,
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
                                                      if (product.stocks!.where((warehouse) => warehouse.id == selectWarehouseId).toList().first.stockCurrent! > 0) {
                                                        notifierPos.moveProductTicketline(product, statePos.selectTicket, selectWarehouseId);
                                                      }
                                                    },
                                                    child: ProductsProductItemPOS(
                                                      selectWarehouseId: selectWarehouseId,
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
                          GestureDetector(
                            onTap: () {
                              if (statePos.listTicket![statePos.selectTicket!].ticketlines!.isNotEmpty && !statePos.createTicketLoading!) {
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
                          GestureDetector(
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
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: TextField(
                              controller: barCodeController,
                              onChanged: (v) {
                                setState(() {
                                  barCodeController.text = v;
                                });
                              },
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
                          GestureDetector(
                            onTap: () {
                              if (barCodeController.text != "") {
                                List<ProductPasData> result = notifierProducts.searchAndAddProductInTicketByRefCode(barCodeController.text);
                                print(result.length);
                                if (result.isNotEmpty) {
                                  notifierPos.addTicketline(result[0], statePos.selectTicket);
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                  width: 60.r,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.blueAccent.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "iilllii",
                                    style: TextStyle(fontSize: 20, color: Colors.blue),
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (warehouse1Index != warehouse2Index) {
                                notifierPos.moveProduct(warehouse1Index, warehouse2Index, "${stateBase.baseRootInfomation["email"]}_${stateBase.baseInfomation["email"]}");
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
              : const SizedBox()),
    );
  }
}
