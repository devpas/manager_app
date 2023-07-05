import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/notifiers/notifiers.dart';
import 'package:g_manager_app/modify/riverpob/states/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../widgets/are_you_sure_modal_in_properties.dart';
import '../widgets/product_properties_item.dart';
import 'widgets/search_discount_modal_in_add_product.dart';
import 'widgets/search_property_modal_in_add_product.dart';

class AddProductPasPage extends ConsumerStatefulWidget {
  const AddProductPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddProductPasPage> createState() => _AddProductPasPage();
}

class _AddProductPasPage extends ConsumerState<AddProductPasPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<dynamic> listProperties = [];

  String keyProperties = "";

  String valueProperties = "";

  bool subsidiaryCheckBox = false;
  bool measuresCheckBox = false;
  bool showCategoryCheckBox = true;
  bool typeDataCheckBox = true;
  bool activeCheckBox = true;

  String parentCategoryName = "";
  List<CategoryPasData>? categoriesSearch = [];
  String categoryName = "";
  int parentCategoryId = 1;

  XFile? image;

  ProductPasData? product = ProductPasData().initProduct();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget mainTab(
      ProductsPasState productsState, ProductsPasNotifier productsNotifier) {
    final state = ref.watch(categoriesPASProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
    return SingleChildScrollView(
      physics: const CustomBouncingScrollPhysics(),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: SelectImage(
                file: image,
                onChangePhoto: (XFile file) {
                  setState(() {
                    image = file;
                  });
                },
              ),
            ),
            CommonInputField(
              initialValue: product!.reference,
              label: "Mã kho",
              onChanged: (v) {
                product = product!.copyWith(reference: v);
              },
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: product!.name,
              label: "Tên",
              onChanged: (v) {
                product = product!.copyWith(name: v);
              },
              inputAction: TextInputAction.next,
            ),
            38.verticalSpace,
            CommonInputField(
              initialValue: product!.code,
              label: "Mã vạch",
              onChanged: (v) {
                product = product!.copyWith(code: v);
              },
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: product!.priceBuy.toString(),
              label: "Giá mua",
              onChanged: (v) {
                product = product!.copyWith(priceBuy: double.parse(v));
              },
              inputType: TextInputType.number,
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: product!.priceSell.toString(),
              label: "Giá bán",
              onChanged: (v) {
                product = product!.copyWith(priceSell: double.parse(v));
              },
              inputType: TextInputType.number,
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: CommonInputField(
                      initialValue: product!.priceBuy.toString(),
                      label: "Giá sau chiết khấu",
                      onChanged: (v) {
                        product = product!.copyWith(priceSell: double.parse(v));
                      },
                      inputAction: TextInputAction.next,
                    ),
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: 100,
                    child: CommonInputField(
                      label: "% chiết khấu",
                      initialValue: "0",
                      onChanged: (v) {
                        product = product!.copyWith(priceSell: double.parse(v));
                      },
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: "Loại chiếc khấu",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const SearchDiscountModalInAddProduct(),
                );
              },
              title: "Chọn loại chiếc khấu",
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: AppHelpers.getTranslation(TrKeys.parentCategory),
              title: parentCategoryId == -1
                  ? "Chọn danh mục cấp trên"
                  : parentCategoryName,
              onTap: () {
                categoriesSearch = state.categories!;
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setModelState) {
                        return Material(
                          color: AppColors.mainBackground,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SearchTextField(
                                  onChanged: (v) {
                                    setModelState(() {
                                      categoriesSearch = state.categories!
                                          .where((e) => e.name!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                  hintText: AppHelpers.getTranslation(
                                      TrKeys.searchCategory),
                                ),
                                10.verticalSpace,
                                SearchedItem(
                                  title: AppHelpers.getTranslation(
                                      TrKeys.noCategory),
                                  isSelected: false,
                                  onTap: () {
                                    setState(() {
                                      parentCategoryId = -1;
                                    });

                                    // notifier.setSelectedParentId(0);
                                    // notifier.setParentCategoryName(
                                    //     AppHelpers.getTranslation(TrKeys.noCategory));
                                    Navigator.pop(context);
                                  },
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    physics:
                                        const CustomBouncingScrollPhysics(),
                                    itemCount: categoriesSearch!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final parentCategory =
                                          categoriesSearch![index];
                                      return SearchedItem(
                                        title: '${parentCategory.name}',
                                        isSelected: false,
                                        onTap: () {
                                          setState(() {
                                            parentCategoryId =
                                                parentCategory.id!;
                                            parentCategoryName =
                                                parentCategory.name!;
                                          });
                                          print(parentCategoryId);
                                          print(parentCategoryName);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                30.verticalSpace,
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
            ),
            30.verticalSpace,
            SelectWithSearchButton(
              label: "Thuộc tính",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const SearchPropertyModalInAddProduct(),
                );
              },
              title: "chọn thuộc tính",
            ),
            30.verticalSpace,
            Text(
              AppHelpers.getTranslation(TrKeys.active),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            Row(
              children: [
                RoundedCheckBox(
                  value: activeCheckBox,
                  onChanged: (value) {
                    setState(() {
                      activeCheckBox = !activeCheckBox;
                      product =
                          product!.copyWith(active: activeCheckBox ? 1 : 0);
                    });
                  },
                ),
                10.horizontalSpace,
                Text(
                  activeCheckBox ? 'On' : 'Off',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: activeCheckBox
                        ? AppColors.black
                        : AppColors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onPressed: () {
                var base64 = "";
                if (image != null) {
                  final bytes = File(image!.path).readAsBytesSync();
                  base64 = base64Encode(bytes);
                }
                setState(() {
                  product = product!.copyWith(
                      attributes: listProperties.toString(),
                      image: base64,
                      categoryId: parentCategoryId);
                  print(product!.toJson());
                  productsNotifier.addProduct(product!);
                });
              },
              isLoading: false,
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget stockTab(
      ProductsPasState productsState, ProductsPasNotifier productsNotifier) {
    return SingleChildScrollView(
      physics: const CustomBouncingScrollPhysics(),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            CommonInputField(
              initialValue: product!.stockCost.toString(),
              label: "Phí lưu kho",
              onChanged: (e) {},
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: product!.stockVolume.toString(),
              label: "Thể tích trong kho",
              onChanged: (e) {},
              inputAction: TextInputAction.next,
            ),
            38.verticalSpace,
            CommonInputField(
              initialValue: product!.isScale.toString(),
              label: "Thứ tự sản phẩm",
              onChanged: (e) {},
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            Row(
              children: [
                RoundedCheckBox(
                  value: showCategoryCheckBox,
                  onChanged: (value) {
                    setState(() {
                      showCategoryCheckBox = !showCategoryCheckBox;
                    });
                  },
                ),
                10.horizontalSpace,
                Text(
                  "Hiển thị trong danh mục",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: showCategoryCheckBox
                        ? AppColors.black
                        : AppColors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            Row(
              children: [
                RoundedCheckBox(
                  value: subsidiaryCheckBox,
                  onChanged: (value) {
                    setState(() {
                      subsidiaryCheckBox = !subsidiaryCheckBox;
                    });
                  },
                ),
                10.horizontalSpace,
                Text(
                  "Phụ thuộc",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: subsidiaryCheckBox
                        ? AppColors.black
                        : AppColors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            Row(
              children: [
                RoundedCheckBox(
                  value: measuresCheckBox,
                  onChanged: (value) {
                    setState(() {
                      measuresCheckBox = !measuresCheckBox;
                    });
                  },
                ),
                10.horizontalSpace,
                Text(
                  "Phải cân đo",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: measuresCheckBox
                        ? AppColors.black
                        : AppColors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget propertiesTab(
      ProductsPasState productsState, ProductsPasNotifier productsNotifier) {
    return SingleChildScrollView(
      physics: const CustomBouncingScrollPhysics(),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            CommonInputField(
              initialValue: keyProperties,
              label: "Tên thuộc tính",
              onChanged: (input) {
                setState(() {
                  keyProperties = input;
                });
              },
              inputAction: TextInputAction.next,
            ),
            30.verticalSpace,
            CommonInputField(
              initialValue: valueProperties,
              label: "Giá trị thuộc tính",
              onChanged: (input) {
                setState(() {
                  valueProperties = input;
                });
              },
              inputAction: TextInputAction.next,
            ),
            10.verticalSpace,
            Text(
              "Kiểu dữ liệu",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    RoundedCheckBox(
                      value: typeDataCheckBox,
                      onChanged: (value) {
                        setState(() {
                          typeDataCheckBox = !typeDataCheckBox;
                        });
                      },
                    ),
                    10.horizontalSpace,
                    Text(
                      "Chữ",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: typeDataCheckBox
                            ? AppColors.black
                            : AppColors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                40.horizontalSpace,
                Row(
                  children: [
                    RoundedCheckBox(
                      value: !typeDataCheckBox,
                      onChanged: (value) {
                        setState(() {
                          typeDataCheckBox = !typeDataCheckBox;
                        });
                      },
                    ),
                    10.horizontalSpace,
                    Text(
                      "Số",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: !typeDataCheckBox
                            ? AppColors.black
                            : AppColors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AccentAddButton(
                    title: "thêm",
                    onPressed: () {
                      if (keyProperties != "" &&
                          valueProperties != "" &&
                          listProperties
                              .where(
                                  (element) => element["key"] == keyProperties)
                              .toList()
                              .isEmpty) {
                        setState(() {
                          var property = {
                            "key": keyProperties,
                            "value": valueProperties,
                            "type": typeDataCheckBox ? "String" : "number"
                          };
                          listProperties.add(property);
                          keyProperties = "";
                          valueProperties = "";
                        });
                      }
                    }),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: REdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
                bottom: 0,
              ),
              shrinkWrap: true,
              itemCount: listProperties.length,
              itemBuilder: (context, index) {
                final property = listProperties[index];
                return ProductPropertiesItem(
                  keyProperties: property["key"],
                  valueProperties: property["value"],
                  onDeleteTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => AreYouSureModalInProperties(
                      index: index,
                      onDeleteTap: () {
                        setState(() {
                          listProperties.removeAt(index);
                          context.popRoute();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsPASProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: CustomAppbarPOS(
            title: Text(
              "Thêm sản phẩm",
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
                onPressed: context.popRoute,
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(color: AppColors.mainBackground),
            child: Column(
              children: [
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
                      Tab(text: "Tổng"),
                      Tab(text: "Kho"),
                      Tab(text: "Thuộc tính"),
                    ],
                  ),
                ),
                18.verticalSpace,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const CustomBouncingScrollPhysics(),
                    children: [
                      mainTab(state, notifier),
                      stockTab(state, notifier),
                      propertiesTab(state, notifier)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
