import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/stocks.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/riverpob/notifiers/notifiers.dart';
import 'package:g_manager_app/modify/riverpob/states/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../../../riverpob/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../../products/widgets/list_products_filter_modal.dart';
import 'widgets/product_in_warehouse.dart';
import 'widgets/select_warehouse_modal.dart';
import 'widgets/select_with_option_mini_button.dart';

class StockDiaryPage extends ConsumerStatefulWidget {
  const StockDiaryPage({Key? key}) : super(key: key);
  @override
  ConsumerState<StockDiaryPage> createState() => _StockDiaryPageState();
}

class _StockDiaryPageState extends ConsumerState<StockDiaryPage> {
  late ScrollController _scrollController;

  TextEditingController priceController = TextEditingController();

  TextEditingController qualityController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  String stockCurrent = "0";

  DateTime dateDiary = DateTime.now();

  List<String> reason = ["(Nhập)mua vào", "(Nhập)trả hàng", "(Nhập)chuyển kho", "(Xuất)bán hàng", "(Xuất)trả hàng", "(Xuất)hong vo", "(Xuất)chuyển kho"];

  int reasonSelected = 0;

  ProductPasData? productSelected;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).resetSearch();
        ref.read(productsPASProvider.notifier).fetchProductsByCategory(ref.read(productsPASProvider.notifier).minCategoryId);
        if (ref.watch(categoriesPASProvider).categorySelected == null) {
          ref.read(categoriesPASProvider.notifier).setCategorySelected(ref.watch(categoriesPASProvider).categories![0]);
        }
        ref.read(productsPASProvider.notifier).getListWarehouses();
        qualityController.text = "0";
        priceController.text = "0";
      },
    );
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void getStock(ProductsPasNotifier notifier, ProductsPasState state, ProductPasData product) {
    List<StockData> productInWarehouse = [];
    print(product.stocks![0].id);
    if (state.warehouseSelected != null) {
      productInWarehouse = product.stocks!.where((warehouse) => warehouse.id == state.warehouseSelected["id"]).toList();
    } else {
      productInWarehouse = state.products![0].stocks!.where((warehouse) => warehouse.id == 0).toList();
    }
    setState(() {
      print(productInWarehouse);
      qualityController.text = "0";
      if (productInWarehouse.isNotEmpty) {
        priceController.text = productSelected!.priceBuy.toString();
        stockCurrent = productInWarehouse.first.stockCurrent.toString();
      } else {
        priceController.text = "0";
        stockCurrent = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final stateBase = ref.watch(baseProvider);
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
            center: false,
            title: Text(
              stateBase.translate[stateBase.languageSelected]["stock_diary"],
              style: AppTypographies.styBlack12W400,
            ),
            leading: Builder(
              builder: (context) => SmallIconButton(
                icon: Icon(
                  FlutterRemix.arrow_left_s_line,
                  size: 24.r,
                  color: AppColors.black,
                ),
                onPressed: context.popRoute,
              ),
            ),
            actions: [
              Padding(
                padding: REdgeInsets.fromLTRB(0, 10, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.greenMain,
                    minimumSize: Size(110.r, 35.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(43.r),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SelectWarehouseModal(),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 16.r,
                      ),
                      4.horizontalSpace,
                      Text(
                        state.warehouseSelected["name"] ?? "",
                        style: AppTypographies.styWhite12W500,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          3.verticalSpace,
          SearchTextField(
            textEditingController: searchController,
            onChanged: (e) {
              if (e.length >= 3) {
                notifier.productName = e;
                notifier.searchProducts(-1);
              } else {
                if (state.productsAfterFilter!.isNotEmpty) {
                  notifier.resetSearch();
                }
              }
            },
            hintText: stateBase.translate[stateBase.languageSelected]["titel_product_name"],
            suffixIcon: SmallIconButton(
              onPressed: () {
                notifier.productName = "";
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ListProductsFilterModal(),
                );
              },
              icon: Icon(
                FlutterRemix.sound_module_line,
                size: 24.r,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: state.productsLoading! || state.warehouse!.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenMain,
                      strokeWidth: 3.r,
                    ),
                  )
                : state.products!.isEmpty
                    ? Center(
                        child: Text(
                          stateBase.translate[stateBase.languageSelected]["product_not_found"],
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView(
                        physics: const CustomBouncingScrollPhysics(),
                        controller: _scrollController,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: REdgeInsets.all(8),
                            shrinkWrap: true,
                            itemCount: state.productsAfterFilter!.isEmpty ? state.products!.length : state.productsAfterFilter!.length,
                            itemBuilder: (context, index) {
                              ProductPasData product;
                              if (state.productsAfterFilter!.isEmpty) {
                                product = state.products![index];
                              } else {
                                product = state.productsAfterFilter![index];
                              }
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ProductByWarehouse(
                                  product: product,
                                  selected: productSelected != null && product.id == productSelected!.id ? true : false,
                                  onTap: () async {
                                    setState(() {
                                      productSelected = product;
                                    });
                                    getStock(notifier, state, product);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
          ),
          10.verticalSpace,
          Container(
            height: screenHeight * 0.3,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: state.products!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.3, child: Text(stateBase.translate[stateBase.languageSelected]["stock_current"])),
                          SizedBox(width: screenWidth * 0.50, child: Text(stockCurrent)),
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                print("new line");
                              },
                              child: const Icon(Icons.new_label_outlined),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          !state.updateStockLoading!
                              ? SizedBox(
                                  child: InkWell(
                                    onTap: () {
                                      if (productSelected != null) {
                                        var diaryData = {"index": productSelected!.index, "reason": reasonSelected + 1, "product_id": productSelected!.id, "warehouse_id": state.warehouseSelected["id"], "price": double.parse(priceController.text), "quantity": int.parse(qualityController.text)};
                                        notifier.addStockDiary(diaryData);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.save,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.greenMain,
                                  )),
                                )
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.15, child: Text(stateBase.translate[stateBase.languageSelected]["quantity"])),
                          SizedBox(
                              height: 30,
                              width: screenWidth * 0.25,
                              child: TextFormField(
                                controller: qualityController,
                                cursorWidth: 1.r,
                                cursorColor: AppColors.black,
                                decoration: InputDecoration(
                                  hintStyle: AppTypographies.styBlack14W400Opacity30,
                                  hintText: "",
                                  contentPadding: EdgeInsetsDirectional.only(start: 5.r),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.greenMain),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.white),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: SizedBox(
                              width: screenWidth * 0.2,
                              child: Text(stateBase.translate[stateBase.languageSelected]["price"]),
                            ),
                          ),
                          SizedBox(
                              height: 30,
                              width: screenWidth * 0.25,
                              child: TextFormField(
                                controller: priceController,
                                cursorWidth: 1.r,
                                cursorColor: AppColors.black,
                                decoration: InputDecoration(
                                  hintStyle: AppTypographies.styBlack14W400Opacity30,
                                  hintText: "",
                                  contentPadding: EdgeInsetsDirectional.only(start: 5.r),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.greenMain),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.white),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.15, child: Text(stateBase.translate[stateBase.languageSelected]["barcode"])),
                          SizedBox(width: screenWidth * 0.25, child: Text(productSelected != null ? productSelected!.reference.toString() : "")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: SizedBox(
                              width: screenWidth * 0.2,
                              child: Text(stateBase.translate[stateBase.languageSelected]["warehouse_code"]),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.25, child: Text(productSelected != null ? productSelected!.code.toString() : "")),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.10, child: Text(stateBase.translate[stateBase.languageSelected]["day"])),
                          SizedBox(width: screenWidth * 0.70, child: Text(DateFormat("yyyy-MM-dd HH:mm:ss").format(dateDiary))),
                          SizedBox(
                              width: 25,
                              height: 25,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 450.r,
                                          ),
                                          child: CustomDatePickerModal(onDateSaved: (DateTime? date) {
                                            setState(() {
                                              dateDiary = date!;
                                            });
                                          }),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.date_range_outlined),
                              ))
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.10, child: Text(stateBase.translate[stateBase.languageSelected]["reason"])),
                          SizedBox(
                            width: screenWidth * 0.4,
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
                                            "Chọn lý do",
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
                                                    color: reasonSelected == index ? AppColors.white : AppColors.transparent,
                                                    border: Border.all(
                                                      color: reasonSelected == index ? AppColors.greenMain : AppColors.productBorder,
                                                      width: reasonSelected == index ? 6.r : 2.r,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    reasonSelected = index;
                                                  });
                                                  context.popRoute();
                                                },
                                                title: Text(reason[index].toString()),
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
                              title: reason[reasonSelected],
                            ),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.10, child: Text(stateBase.translate[stateBase.languageSelected]["name"])),
                          SizedBox(width: screenWidth * 0.70, child: Text(productSelected != null ? productSelected!.name.toString() : "")),
                        ],
                      ),
                    ]),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
