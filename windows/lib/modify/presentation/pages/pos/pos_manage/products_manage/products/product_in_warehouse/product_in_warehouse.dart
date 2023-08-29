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
import '../../../../../../../riverpob/providers/providers.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import 'widgets/list_warehouse_actions.dart';
import 'widgets/product_in_warehouse.dart';

class ProductsInWarehousePage extends ConsumerStatefulWidget {
  const ProductsInWarehousePage({Key? key}) : super(key: key);
  @override
  ConsumerState<ProductsInWarehousePage> createState() =>
      _ProductsInWarehousePageState();
}

class _ProductsInWarehousePageState
    extends ConsumerState<ProductsInWarehousePage> {
  late ScrollController _scrollController;

  TextEditingController stockMinController = TextEditingController();

  TextEditingController stockMaxController = TextEditingController();

  String stockCurrent = "0";

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListWarehouses();
        ref.read(productsPASProvider.notifier).fetchProducts();
        stockMaxController.text = "0";
        stockMinController.text = "0";
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

  void getStock(ProductsPasNotifier notifier, ProductsPasState state,
      ProductPasData product) {
    List<StockData> productInWarehouse = [];
    print(product.stocks![0].id);
    if (state.warehouseSelected != null) {
      productInWarehouse = product.stocks!
          .where((warehouse) => warehouse.id == state.warehouseSelected["id"])
          .toList();
    } else {
      productInWarehouse = state.products![0].stocks!
          .where((warehouse) => warehouse.id == 0)
          .toList();
    }
    setState(() {
      print(productInWarehouse);
      if (productInWarehouse.isNotEmpty) {
        stockMinController.text = productInWarehouse[0].stockMin.toString();
        stockMaxController.text = productInWarehouse[0].stockMax.toString();
        stockCurrent = productInWarehouse.first.stockCurrent.toString();
      } else {
        stockMinController.text = "0";
        stockMaxController.text = "0";
        stockCurrent = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomAppbarPOS(
            center: false,
            title: Text(
              "Sản phẩm theo kho",
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
            actions: getListWarehouse(context)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          3.verticalSpace,
          SearchTextField(
            onChanged: (input) {
              // notifier.filterBaseByNameOrEmail(input);
            },
            hintText: "Tên cơ sở hoặc email",
            suffixIcon: SmallIconButton(
              onPressed: () {
                notifier.fetchProducts();
              },
              icon: Icon(
                FlutterRemix.refresh_line,
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
                          "Không tìm thấy cơ sở",
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
                            itemCount: state.products!.length,
                            itemBuilder: (context, index) {
                              final product = state.products![index];
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ProductByWarehouse(
                                  product: product,
                                  onTap: () async {
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
            height: screenHeight * 0.12,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: state.products!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.verticalSpace,
                          Row(
                            children: [
                              SizedBox(
                                  width: screenWidth * 0.3,
                                  child: const Text("Số lượng hiện có")),
                              SizedBox(
                                  width: screenWidth * 0.58,
                                  child: Text(stockCurrent)),
                              SizedBox(
                                child: GestureDetector(
                                  onTap: () {
                                    print("save");
                                  },
                                  child: const Icon(
                                    Icons.save,
                                  ),
                                ),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              SizedBox(
                                  width: screenWidth * 0.15,
                                  child: const Text("SL tối đa")),
                              SizedBox(
                                  width: screenWidth * 0.25,
                                  child: TextFormField(
                                    controller: stockMaxController,
                                    cursorWidth: 1.r,
                                    cursorColor: AppColors.black,
                                    decoration: InputDecoration(
                                      hintStyle: AppTypographies
                                          .styBlack14W400Opacity30,
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsetsDirectional.only(
                                              start: 5.r),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.greenMain),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: SizedBox(
                                  width: screenWidth * 0.2,
                                  child: const Text("SL tối thiểu"),
                                ),
                              ),
                              SizedBox(
                                  width: screenWidth * 0.25,
                                  child: TextFormField(
                                    controller: stockMinController,
                                    cursorWidth: 1.r,
                                    cursorColor: AppColors.black,
                                    decoration: InputDecoration(
                                      hintStyle: AppTypographies
                                          .styBlack14W400Opacity30,
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsetsDirectional.only(
                                              start: 5.r),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.greenMain),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          // 5.verticalSpace,
                          // Row(
                          //   children: [
                          //     const SizedBox(width: 70, child: Text("Loại cs")),
                          //     SizedBox(
                          //         width: 150,
                          //         child: Text(
                          //             "${state.base![state.baseSelected!].baseType}")),
                          //     const SizedBox(width: 70, child: Text("SĐT")),
                          //     SizedBox(
                          //         width: 100,
                          //         child: Text(
                          //             "${state.base![state.baseSelected!].phone}")),
                          //   ],
                          // ),
                        ]),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
