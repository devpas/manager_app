import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/category_data.dart';
import 'package:g_manager_app/modify/models/data/product_data.dart';
import 'package:g_manager_app/modify/presentation/pages/pos/pos_manage/products_manage/products/widgets/product_item_pas.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/notifiers/notifiers.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/states/products/products_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../src/core/routes/app_router.gr.dart';
import '../../../../../../../src/core/utils/utils.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'widgets/list_products_filter_modal.dart';
import 'widgets/list_products_sort_modal.dart';
import 'widgets/w_delete_product_dialog.dart';

class ProductsDesktopPage extends ConsumerStatefulWidget {
  const ProductsDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsDesktopPage> createState() => _ProductsDesktopPageState();
}

class _ProductsDesktopPageState extends ConsumerState<ProductsDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  int indexItemSelected = 0;

  final ItemScrollController _scrollControllerItem = ItemScrollController();

  // search text

  TextEditingController barcodeSearchController = TextEditingController();
  TextEditingController nameSearchController = TextEditingController();
  TextEditingController categoryIdSearchController = TextEditingController();
  TextEditingController priceBuySearchController = TextEditingController();
  TextEditingController priceSellSearchController = TextEditingController();
  List<String> conditionCompare = ["None", "Equals", "Wildcards", "Distinct", "Greater", "Greate or equal", "Less or equals"];

  // infomation text

  TextEditingController refcodeController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceBuyController = TextEditingController();
  TextEditingController priceSellController = TextEditingController();
  TextEditingController priceSellPercentController = TextEditingController();
  TextEditingController pricesellAfterDiscountController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  String categoryName = "";
  TextEditingController attributeController = TextEditingController();

  bool findStatus = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).fetchProducts();
        if (ref.watch(categoriesPASProvider).categorySelected == null) {
          ref.read(categoriesPASProvider.notifier).setCategorySelected(ref.watch(categoriesPASProvider).categories![0]);
        }
      },
    );
  }

  void filterList(dynamic filterValue, ProductsPasState stateProduct, ProductsPasNotifier notifierProduct) async {
    notifierProduct.codeRef = filterValue["code_ref"];
    notifierProduct.productName = filterValue["name"];

    if (filterValue["price_buy"] != "") {
      notifierProduct.priceBuy = double.parse(filterValue["price_buy"]);
    } else {
      notifierProduct.priceBuy = -1;
    }

    if (filterValue["price_sell"] != "") {
      notifierProduct.priceSell = double.parse(filterValue["price_sell"]);
    } else {
      notifierProduct.priceSell = -1;
    }
    bool result = await notifierProduct.searchProducts(filterValue["category_id"]);
    if (result == false) {
      setState(() {
        findStatus = false;
      });
    }
    print(findStatus);
  }

  XFile? image;

  Widget summary() {
    final state = ref.watch(productsPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    final stateCategory = ref.watch(categoriesPASProvider);
    final notifierCategory = ref.read(categoriesPASProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth * 0.48,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: Text("Mã vạch:")),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: barcodeController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  )),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá mua:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: priceBuyController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá bán:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: priceSellController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: priceSellPercentController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: screenWidth * 0.1, child: const Text("Giá sau CK:")),
                  ),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: pricesellAfterDiscountController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.1, child: const Text("Loại chiết khấu:")),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        DropdownButton(
                            items: state.taxes!.map<DropdownMenuItem<dynamic>>((dynamic value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: SizedBox(width: screenWidth * 0.160, child: Text(value["name"])),
                              );
                            }).toList(),
                            onChanged: (e) {}),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.1, child: const Text("Cấp trên:")),
                  SizedBox(
                    width: screenWidth * 0.185,
                    child: Column(
                      children: [
                        DropdownButton(
                            items: stateCategory.categories!.map<DropdownMenuItem<CategoryPasData>>((CategoryPasData value) {
                              return DropdownMenuItem<CategoryPasData>(
                                value: value,
                                child: SizedBox(width: screenWidth * 0.160, child: Text(value.name!)),
                              );
                            }).toList(),
                            onChanged: (e) {}),
                      ],
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
              // Row(
              //   children: [
              //     SizedBox(width: screenWidth * 0.1, child: const Text("Thuộc tính:")),
              //     SizedBox(
              //       width: screenWidth * 0.185,
              //       child: Column(
              //         children: [
              //           DropdownButton(
              //               items: ["A", "B", "C"].map<DropdownMenuItem<String>>((String value) {
              //                 return DropdownMenuItem<String>(
              //                   value: value,
              //                   child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
              //                 );
              //               }).toList(),
              //               onChanged: (e) {}),
              //         ],
              //       ),
              //     ),
              //     5.verticalSpace,
              //   ],
              // ),
            ],
          ),
        ),
        8.horizontalSpace,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SelectImageCustomeSize(
                    file: image,
                    heigth: screenHeight * 0.35,
                    width: screenWidth * 0.2,
                    onChangePhoto: (XFile file) {
                      setState(() {
                        image = file;
                      });
                    },
                  ),
                ),
                10.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.folder_2_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.close_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.file_search_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.zoom_in_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                    10.verticalSpace,
                    CircleIconButton(
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      iconData: FlutterRemix.zoom_out_line,
                      iconColor: AppColors.blue,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsPASProvider);
    final stateCategory = ref.watch(categoriesPASProvider);
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final notifierCategory = ref.read(categoriesPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        drawer: const WMainDrawerPosDesktop(),
        appBar: CustomAppbarPOS(
          title: Text(
            stateBase.translate[stateBase.languageSelected]["product"],
            style: AppTypographies.styBlack16W500,
            textAlign: TextAlign.center,
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
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text("Theo mã vạch"),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth * 0.1, child: const Text("Mã vạch:")),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: barcodeSearchController,
                                          decoration: const InputDecoration.collapsed(
                                            hintText: '',
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                                5.verticalSpace,
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: screenHeight * 0.18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text("Theo hình thức"),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth * 0.1, child: const Text("Tên:")),
                                SizedBox(
                                  width: screenWidth * 0.185,
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                          items: conditionCompare.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                                            );
                                          }).toList(),
                                          onChanged: (e) {}),
                                    ],
                                  ),
                                ),
                                5.horizontalSpace,
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: nameSearchController,
                                          decoration: const InputDecoration.collapsed(
                                            hintText: '',
                                          ),
                                          onChanged: (e) {
                                            setState(() {
                                              nameSearchController.text = e.toString();
                                            });
                                          },
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                                5.horizontalSpace,
                                SizedBox(width: screenWidth * 0.1, child: const Text("Cấp trên:")),
                                SizedBox(
                                  width: screenWidth * 0.185,
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                          value: stateCategory.categorySelected,
                                          items: stateCategory.categories!.map<DropdownMenuItem<CategoryPasData>>((CategoryPasData category) {
                                            return DropdownMenuItem<CategoryPasData>(
                                              value: category,
                                              child: SizedBox(width: screenWidth * 0.160, child: Text(category.name!)),
                                            );
                                          }).toList(),
                                          onChanged: (e) {
                                            notifierCategory.setCategorySelected(e!);
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth * 0.1, child: const Text("Giá mua:")),
                                SizedBox(
                                  width: screenWidth * 0.185,
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                          items: conditionCompare.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                                            );
                                          }).toList(),
                                          onChanged: (e) {}),
                                    ],
                                  ),
                                ),
                                5.horizontalSpace,
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: priceBuySearchController,
                                          decoration: const InputDecoration.collapsed(
                                            hintText: '',
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                                5.horizontalSpace,
                                SizedBox(width: screenWidth * 0.1, child: const Text("Giá bán:")),
                                SizedBox(
                                  width: screenWidth * 0.185,
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                          items: conditionCompare.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: SizedBox(width: screenWidth * 0.160, child: Text(value)),
                                            );
                                          }).toList(),
                                          onChanged: (e) {}),
                                    ],
                                  ),
                                ),
                                5.horizontalSpace,
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: screenWidth * 0.185,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: priceSellSearchController,
                                          decoration: const InputDecoration.collapsed(
                                            hintText: '',
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ]),
              ),
            ),
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
                    SizedBox(width: screenWidth * 0.235, child: Text("0/${state.products!.length}")),
                    SizedBox(
                      child: Row(children: [
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                          iconData: FlutterRemix.skip_back_line,
                          iconColor: AppColors.orderReviews,
                          onTap: () {
                            setState(() {
                              indexItemSelected = 0;
                              _scrollControllerItem.scrollTo(index: 0, duration: const Duration(milliseconds: 200));
                            });
                          },
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                          iconData: FlutterRemix.arrow_left_line,
                          iconColor: AppColors.orderReviews,
                          onTap: () {
                            setState(() {
                              if (indexItemSelected > 0) {
                                indexItemSelected = indexItemSelected - 1;
                              }
                            });
                          },
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                          iconData: FlutterRemix.arrow_down_line,
                          iconColor: AppColors.orderReviews,
                          onTap: () {},
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                          iconData: FlutterRemix.arrow_right_line,
                          iconColor: AppColors.orderReviews,
                          onTap: () {
                            setState(() {
                              indexItemSelected = indexItemSelected + 1;
                            });
                          },
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                          iconData: FlutterRemix.skip_forward_line,
                          iconColor: AppColors.orderReviews,
                          onTap: () {
                            setState(() {
                              indexItemSelected = state.products!.length - 1;
                              _scrollControllerItem.scrollTo(index: state.products!.length - 1, duration: const Duration(milliseconds: 200));
                            });
                          },
                        ),
                        25.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                          iconData: FlutterRemix.refresh_line,
                          iconColor: AppColors.canceledOrders,
                          onTap: () {
                            var filterValue = {"code_ref": barcodeSearchController.text, "name": nameSearchController.text, "price_buy": priceBuySearchController.text, "price_sell": priceSellSearchController.text, "category_id": stateCategory.categorySelected!.id};
                            filterList(filterValue, state, notifier);
                          },
                        ),
                        25.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.search_2_line,
                          iconColor: AppColors.blue,
                          onTap: () {
                            notifier.productName = "";
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => ListProductsFilterModal(),
                            );
                          },
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.greenMain.withOpacity(0.07),
                          iconData: FlutterRemix.sort_desc,
                          iconColor: AppColors.greenMain,
                          onTap: () {
                            notifier.productName = "";
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => ListProductsSortModal(),
                            );
                          },
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: Colors.deepOrange.withOpacity(0.07),
                          iconData: FlutterRemix.add_line,
                          iconColor: Colors.deepOrange,
                          onTap: () {},
                        ),
                        20.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.red.withOpacity(0.07),
                          iconData: FlutterRemix.close_line,
                          iconColor: AppColors.red,
                          onTap: () {},
                        ),
                        25.horizontalSpace,
                        CircleIconButton(
                          backgroundColor: AppColors.blue.withOpacity(0.07),
                          iconData: FlutterRemix.save_line,
                          iconColor: AppColors.blue,
                          onTap: () {},
                        ),
                        15.horizontalSpace,
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: state.productsLoading!
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenMain,
                              strokeWidth: 3.r,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ScrollablePositionedList.builder(
                              itemScrollController: _scrollControllerItem,
                              itemCount: state.productsAfterFilter!.isEmpty && findStatus == true ? state.products!.length : state.productsAfterFilter!.length,
                              itemBuilder: (context, index) {
                                ProductPasData product;
                                if (state.productsAfterFilter!.isEmpty) {
                                  product = state.products![index];
                                } else {
                                  product = state.productsAfterFilter![index];
                                }
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      indexItemSelected = index;
                                    });
                                  },
                                  child: Container(
                                    width: 500,
                                    color: index == indexItemSelected ? Colors.blue : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name!,
                                            style: TextStyle(color: index == indexItemSelected ? Colors.white : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  8.horizontalSpace,
                  Container(
                    width: screenWidth * 0.735,
                    height: screenHeight * 0.53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: state.productsLoading!
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenMain,
                              strokeWidth: 2,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${state.productSelected!.code!}-${state.productSelected!.name!}"),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(width: screenWidth * 0.05, child: const Text("Mã kho:")),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      child: TextFormField(
                                        controller: refcodeController,
                                        decoration: const InputDecoration.collapsed(hintText: ''),
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(width: screenWidth * 0.03, child: const Text("Tên:")),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration.collapsed(hintText: ''),
                                      ),
                                    ))
                                  ],
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
                                    tabs: [
                                      Tab(text: stateBase.translate[stateBase.languageSelected]["total"]),
                                      Tab(text: stateBase.translate[stateBase.languageSelected]["warehouse"]),
                                      Tab(text: stateBase.translate[stateBase.languageSelected]["attribute"]),
                                    ],
                                  ),
                                ),
                                18.verticalSpace,
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    physics: const CustomBouncingScrollPhysics(),
                                    children: [summary(), summary(), summary()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
