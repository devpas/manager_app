import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/models.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/pos/pos_manage/product_manage/products/widgets/list_taxes_filter_modal.dart';
import 'package:g_manager_app/modify/presentation/pages_dekstop/widgets/drawer_tablet.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../components/components.dart';
import '../../../../../../pages/pos/pos_manage/products_manage/discount/widgets/w_delete_tax_dialog.dart';
import '../../../../../../theme/theme.dart';

class TaxesDesktopPage extends ConsumerStatefulWidget {
  const TaxesDesktopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaxesDesktopPage> createState() => _TaxesDesktopPageState();
}

class _TaxesDesktopPageState extends ConsumerState<TaxesDesktopPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;

  TextEditingController searchController = TextEditingController();

  TextEditingController codeController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController expireController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController squenceController = TextEditingController();

  final ItemScrollController _scrollControllerItem = ItemScrollController();

  var taxCategories = [];

  var taxCusCategories = [];

  var taxes = [];

  int itemIndex = -1;

  bool createMode = false;

  bool activeCheckBox = false;

  bool loadData = false;

  XFile? image;

  String taxIdSelected = "";
  String taxCategoryIdSelected = "";
  String taxCusCategoryIdSelected = "";

  var taxSelected = {};

  List sortCondition = [
    [0, "Tên"],
    [1, "Giá"],
    [3, "Thứ tự"]
  ];

  int conditionSelected = 0;

  void loadValue() async {
    setState(() {
      final taxess = ref.watch(productsPASProvider).taxes!;
      final taxCategoriess = ref.watch(productsPASProvider).taxCategories!;
      final taxCusCategoriess = ref.watch(productsPASProvider).taxCusCategories!;
      for (int i = 0; i < taxess.length; i++) {
        taxes.add(taxess[i]);
      }

      for (int i = 0; i < taxCategoriess.length; i++) {
        taxCategories.add(taxCategoriess[i]);
      }

      for (int i = 0; i < taxCusCategoriess.length; i++) {
        taxCusCategories.add(taxCusCategoriess[i]);
      }

      taxes.insert(0, {"index": -1, "id": "-1", "name": "", "valid_from": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()), "tax_category_id": "", "tax_customer_category_id": "", "parent_id": "", "rate": 0, "rate_cascade": 1, "rate_order": 0});
      taxCategories.insert(0, {"index": -1, "id": "-1", "name": ""});
      taxCusCategories.insert(0, {"index": -1, "id": "", "name": ""});
      print(taxes);
      loadData = true;
    });
  }

  void addTax() {
    setState(() {
      final notifier = ref.read(productsPASProvider.notifier);
      createMode = true;
      nameController.text = "";
      itemIndex = -1;
      var tax = taxes[0];
      taxSelected = taxes[0];
      notifier.setTaxSelected(tax[0]);
      nameController.text = tax["name"];
      expireController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(tax["valid_from"]));
      priceController.text = tax["rate"].toString();
      squenceController.text = tax["rate_order"] != null ? tax["rate_order"].toString() : "";
      activeCheckBox = tax["rate_cascade"] == 1 ? true : false;
      taxIdSelected = tax["id"];
      taxCategoryIdSelected = tax["tax_category_id"] ?? "";
      taxCusCategoryIdSelected = tax["tax_customer_category_id"] ?? "";
    });
  }

  void loadTax(index, tax) {
    final notifier = ref.read(productsPASProvider.notifier);
    createMode = false;
    itemIndex = index + 1;
    notifier.setTaxSelected(tax);
    nameController.text = tax["name"].toString();
    expireController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(tax["valid_from"]));
    priceController.text = tax["rate"].toString();
    squenceController.text = tax["rate_order"] != null ? tax["rate_order"].toString() : "";
    activeCheckBox = tax["rate_cascade"] == 1 ? true : false;
    taxIdSelected = tax["parent_id"].toString();
    taxCategoryIdSelected = tax["tax_category_id"] ?? "";
    taxCusCategoryIdSelected = tax["tax_customer_category_id"] ?? "";
  }

  void searchTax() {
    final notifier = ref.read(productsPASProvider.notifier);
    final state = ref.watch(productsPASProvider);
    var result = [];
    var taxesTemp = state.taxes!;
    if (conditionSelected == 0) {
      result = taxesTemp.where((e) => e["name"].toString().contains(searchController.text)).toList();
    } else if (conditionSelected == 1) {
      result = taxesTemp.where((e) => double.parse(e["rate"].toString()) == double.parse(searchController.text)).toList();
    } else if (conditionSelected == 2) {
      result = taxesTemp.where((e) => double.parse(e["rate_cascade"]) == double.parse(searchController.text)).toList();
    }
    print("asd :$result");
    setState(() {
      if (result.isNotEmpty) {
        taxSelected = result.first;
        itemIndex = taxSelected["index"];
        print(itemIndex);
        _scrollControllerItem.scrollTo(index: itemIndex - 1, duration: const Duration(milliseconds: 200));
        notifier.setTaxSelected(taxSelected);
        nameController.text = taxSelected["name"];
        expireController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(taxSelected["valid_from"]));
        priceController.text = taxSelected["rate"].toString();
        squenceController.text = taxSelected["rate_order"] != null ? taxSelected["rate_order"].toString() : "";
        activeCheckBox = taxSelected["rate_cascade"] == 1 ? true : false;
        taxIdSelected = taxSelected["id"];
        taxCategoryIdSelected = taxSelected["tax_category_id"] ?? "";
        taxCusCategoryIdSelected = taxSelected["tax_customer_category_id"] ?? "";
      } else {
        itemIndex = -1;
      }
    });
  }

  void saveTax() async {
    final notifier = ref.read(productsPASProvider.notifier);
    final state = ref.watch(productsPASProvider);
    var taxData = {
      "name": nameController.text,
      "tax_customer_category_id": taxCusCategoryIdSelected,
      "tax_category_id": taxCategoryIdSelected,
      "parent_id": taxIdSelected,
      "rate": double.parse(priceController.text),
      "rate_cascade": activeCheckBox ? 1 : 0,
      "rate_order": squenceController.text,
      "valid_from": "'${expireController.text}",
    };
    if (createMode) {
      await notifier.addTax(taxData);
    } else {
      taxData["index"] = state.taxSelected["index"];
      taxData["id"] = state.taxSelected["id"];
      print(taxData);
      await notifier.updateTax(taxData);
    }

    setState(() {
      taxes = [];
      final taxess = ref.watch(productsPASProvider).taxes!;
      for (int i = 0; i < taxess.length; i++) {
        taxes.add(taxess[i]);
      }
      taxes.insert(0, {"index": -1, "id": "-1", "name": "", "valid_from": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()), "tax_category_id": "", "tax_customer_category_id": "", "parent_id": "", "rate": 0, "rate_cascade": 1, "rate_order": 0});
      itemIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(
      Duration.zero,
      () {
        loadValue();
      },
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
    final stateBase = ref.watch(baseProvider);
    final notifier = ref.read(productsPASProvider.notifier);
    final notifierBase = ref.read(baseProvider.notifier);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      drawer: const WMainDrawerPosDesktop(),
      appBar: CustomAppbarPOS(
        title: Text(
          stateBase.translate[stateBase.languageSelected]["discount"],
          style: AppTypographies.styBlack16W500,
          textAlign: TextAlign.center,
        ),
        leading: Builder(
          builder: (context) => SmallIconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.r,
              color: AppColors.black,
            ),
            onPressed: context.popRoute,
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
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(children: [
                  SizedBox(width: screenWidth * 0.28, child: Text("0/${state.taxes!.length}")),
                  SizedBox(
                    child: Row(children: [
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.skip_back_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.arrow_left_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.orderReviews.withOpacity(0.07),
                        iconData: FlutterRemix.skip_forward_line,
                        iconColor: AppColors.orderReviews,
                        onTap: () {},
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.canceledOrders.withOpacity(0.07),
                        iconData: FlutterRemix.refresh_line,
                        iconColor: AppColors.canceledOrders,
                        onTap: () {
                          notifier.getListTaxes();
                          setState(() {
                            taxes = [];
                            taxIdSelected = "";
                            final taxess = ref.watch(productsPASProvider).taxes!;
                            for (int i = 0; i < taxess.length; i++) {
                              taxes.add(taxess[i]);
                            }
                            taxes.insert(0, {"index": -1, "id": "-1", "name": "", "valid_from": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()), "tax_category_id": "", "tax_customer_category_id": "", "parent_id": "", "rate": 0, "rate_cascade": 1, "rate_order": 0});
                            itemIndex = 0;
                          });
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
                            builder: (context) => Material(
                              color: AppColors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 23,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stateBase.translate[stateBase.languageSelected]["barcode"],
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: -0.4,
                                        color: AppColors.black.withOpacity(0.3),
                                      ),
                                    ),
                                    TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      controller: searchController,
                                      onChanged: (value) {
                                        searchController.text = value;
                                      },
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: -0.4,
                                        color: AppColors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          letterSpacing: -0.4,
                                          color: AppColors.inputNameHint,
                                        ),
                                      ),
                                    ),
                                    20.verticalSpace,
                                    SelectWithSearchPosButton(
                                      iconData: FlutterRemix.arrow_down_s_line,
                                      label: "Tìm chiết khấu",
                                      title: sortCondition.where((type) => type[0] == conditionSelected).first[1],
                                      onTap: () {
                                        notifier.keySearch = "";
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
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
                                                    Expanded(
                                                      child: ListView.builder(
                                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                                        physics: const CustomBouncingScrollPhysics(),
                                                        itemCount: sortCondition.length,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context, index) {
                                                          return SearchedItem(
                                                            title: '${sortCondition[index][1]}',
                                                            isSelected: false,
                                                            onTap: () {
                                                              conditionSelected = index;
                                                              Future.delayed(Duration(milliseconds: 100), () {
                                                                Navigator.pop(context);
                                                              });
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
                                          },
                                        );
                                      },
                                    ),
                                    40.verticalSpace,
                                    CommonAccentButton(
                                      title: stateBase.translate[stateBase.languageSelected]["show_result"],
                                      onPressed: () {
                                        searchTax();
                                        context.popRoute();
                                      },
                                    ),
                                    20.verticalSpace,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.greenMain.withOpacity(0.07),
                        iconData: FlutterRemix.sort_desc,
                        iconColor: AppColors.greenMain,
                        onTap: () {
                          notifier.sortTax();
                        },
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: Colors.deepOrange.withOpacity(0.07),
                        iconData: FlutterRemix.add_line,
                        iconColor: Colors.deepOrange,
                        onTap: () {
                          addTax();
                        },
                      ),
                      20.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.red.withOpacity(0.07),
                        iconData: FlutterRemix.close_line,
                        iconColor: AppColors.red,
                        onTap: () {
                          print(state.taxSelected["id"]);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return DeleteTaxDialog(
                                alias: state.taxSelected["id"].toString(),
                              );
                            },
                          );
                        },
                      ),
                      25.horizontalSpace,
                      CircleIconButton(
                        backgroundColor: AppColors.blue.withOpacity(0.07),
                        iconData: FlutterRemix.save_line,
                        iconColor: AppColors.blue,
                        onTap: () async {
                          saveTax();
                        },
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
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.825,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: state.taxLoading!
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.greenMain,
                            strokeWidth: 3.r,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ScrollablePositionedList.builder(
                            physics: const CustomBouncingScrollPhysics(),
                            itemScrollController: _scrollControllerItem,
                            shrinkWrap: true,
                            itemCount: state.taxes!.length,
                            itemBuilder: (context, index) {
                              var tax = state.taxes![index];
                              tax = state.taxes![index];

                              return InkWell(
                                onTap: () {
                                  loadTax(index, tax);
                                  // print(taxIdSelected);
                                  // print(taxCategoryIdSelected);
                                  // print(taxCusCategoryIdSelected);
                                },
                                child: Container(
                                  color: tax["index"] == itemIndex ? Colors.blue : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.25,
                                              child: Text(
                                                tax["name"].toString(),
                                                style: TextStyle(color: tax["index"] == itemIndex ? Colors.white : Colors.black),
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
                          ),
                        ),
                ),
                8.horizontalSpace,
                loadData
                    ? Column(
                        children: [
                          Container(
                            height: screenHeight * 0.825,
                            width: screenWidth * 0.685,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Tên:")),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: screenWidth * 0.185,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: nameController,
                                                decoration: const InputDecoration.collapsed(
                                                  hintText: '',
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      (screenWidth * 0.1).horizontalSpace,
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Loại chiết khấu:")),
                                      SizedBox(
                                        width: screenWidth * 0.185,
                                        child: Column(
                                          children: [
                                            DropdownButton(
                                                value: taxCategoryIdSelected == "" ? taxCategories[0] : taxCategories.where((e) => e["id"] == taxCategoryIdSelected).first,
                                                items: taxCategories.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                                  return DropdownMenuItem<dynamic>(
                                                    value: value,
                                                    child: SizedBox(width: screenWidth * 0.160, child: Text(value["name"].toString())),
                                                  );
                                                }).toList(),
                                                onChanged: (e) {
                                                  setState(() {
                                                    print(e);
                                                    print(taxCategoryIdSelected);
                                                    taxCategoryIdSelected = e["id"];
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                      (screenWidth * 0.1).horizontalSpace,
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Hiệu lực từ:")),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: screenWidth * 0.185,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: expireController,
                                                decoration: const InputDecoration.collapsed(
                                                  hintText: '',
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      (screenWidth * 0.01).horizontalSpace,
                                      CircleIconButton(
                                        backgroundColor: AppColors.blue.withOpacity(0.07),
                                        iconData: FlutterRemix.calendar_2_line,
                                        iconColor: AppColors.blue,
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
                                                      expireController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(date!);
                                                    });
                                                  }),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Nhóm KH:")),
                                      SizedBox(
                                        width: screenWidth * 0.185,
                                        child: Column(
                                          children: [
                                            DropdownButton(
                                                value: taxCusCategoryIdSelected == "" ? taxCusCategories[0] : taxCusCategories.where((e) => e["id"] == taxCusCategoryIdSelected).first,
                                                items: taxCusCategories.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                                  return DropdownMenuItem<dynamic>(
                                                    value: value,
                                                    child: SizedBox(width: screenWidth * 0.160, child: Text(value["name"])),
                                                  );
                                                }).toList(),
                                                onChanged: (e) {
                                                  setState(() {
                                                    taxCusCategoryIdSelected = e["id"];
                                                  });
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
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Danh mục cha CK:")),
                                      SizedBox(
                                        width: screenWidth * 0.185,
                                        child: Column(
                                          children: [
                                            DropdownButton(
                                                value: (taxIdSelected == "" || taxIdSelected == "null") ? taxes[0] : taxes.where((e) => e["id"] == taxIdSelected).first,
                                                items: taxes.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                                  return DropdownMenuItem<dynamic>(
                                                    value: value,
                                                    child: SizedBox(width: screenWidth * 0.160, child: Text(value["name"].toString())),
                                                  );
                                                }).toList(),
                                                onChanged: (e) {
                                                  setState(() {
                                                    print(taxes[0]);
                                                    taxIdSelected = e["id"].toString();
                                                    print(taxIdSelected);
                                                  });
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
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Giá:")),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: screenWidth * 0.185,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: priceController,
                                                decoration: const InputDecoration.collapsed(
                                                  hintText: '',
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      RoundedCheckBox(
                                        value: activeCheckBox,
                                        onChanged: (value) {
                                          setState(() {
                                            activeCheckBox = !activeCheckBox;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Xếp cạnh",
                                        style: GoogleFonts.inter(
                                          color: activeCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.15, child: const Text("Thứ tự:")),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: screenWidth * 0.185,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: squenceController,
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
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentGreen,
                          strokeWidth: 2,
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
