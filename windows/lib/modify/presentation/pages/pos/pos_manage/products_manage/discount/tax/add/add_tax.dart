import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../../src/core/utils/app_helpers.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/theme.dart';

class AddTaxPage extends ConsumerStatefulWidget {
  const AddTaxPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTaxPage> createState() => _AddTaxPageState();
}

class _AddTaxPageState extends ConsumerState<AddTaxPage> {
  final _formKey = GlobalKey<FormState>();

  String taxName = "";
  bool active = true;
  String parentName = "";
  List<dynamic>? taxesSearch = [];
  int parentId = 1;
  DateTime dateExpire = DateTime.now();

  String taxCusCategoryName = "";
  List<dynamic>? taxCusCategorySearch = [];
  int taxCusCategoryId = 1;

  String taxCategoryName = "";
  List<dynamic>? taxCategorySearch = [];
  int taxCategoryId = 1;

  bool activeCheckBoxCascade = false;

  double price = 0;

  int order = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListCustomerType();
        ref.read(productsPASProvider.notifier).getListTaxCategories();
        ref.read(productsPASProvider.notifier).getListTaxes();
      },
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
          backgroundColor: AppColors.shopsPageBack,
          appBar: CustomAppbarPOS(
            title: Text(
              "Thêm chiếc khấu",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              physics: const CustomBouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Text(
                      "Tên",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.4,
                        color: AppColors.black.withOpacity(0.3),
                      ),
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          taxName = e;
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                    10.verticalSpace,
                    SelectWithSearchButton(
                      label: "Mục khách hàng",
                      title: taxCusCategoryId == -1 ? "" : taxCusCategoryName,
                      onTap: () {
                        taxCusCategorySearch = state.taxCusCategories!;
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setModelState) {
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
                                              taxCusCategorySearch = state.taxCusCategories!.where((e) => e["name"].toString().toLowerCase().contains(v.toLowerCase())).toList();
                                            });
                                          },
                                          hintText: AppHelpers.getTranslation(TrKeys.search),
                                        ),
                                        10.verticalSpace,
                                        SearchedItem(
                                          title: "Tax customer category",
                                          isSelected: false,
                                          onTap: () {
                                            setState(() {
                                              parentId = -1;
                                            });

                                            // notifier.setSelectedParentId(0);
                                            // notifier.setParentName(
                                            //     AppHelpers.getTranslation(TrKeys.no));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            physics: const CustomBouncingScrollPhysics(),
                                            itemCount: taxCusCategorySearch!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final taxCusCategory = taxCusCategorySearch![index];
                                              return SearchedItem(
                                                title: '${taxCusCategory["name"]}',
                                                isSelected: false,
                                                onTap: () {
                                                  setState(() {
                                                    taxCusCategoryId = taxCusCategory["index"];
                                                    taxCusCategoryName = taxCusCategory["name"];
                                                  });
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
                    10.verticalSpace,
                    SelectWithSearchButton(
                      label: "Mục chiếc khấu",
                      title: taxCategoryId == -1 ? "" : taxCategoryName,
                      onTap: () {
                        taxCategorySearch = state.taxCategories!;
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setModelState) {
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
                                              taxCategorySearch = state.taxCategories!.where((e) => e["name"].toString().toLowerCase().contains(v.toLowerCase())).toList();
                                            });
                                          },
                                          hintText: AppHelpers.getTranslation(TrKeys.search),
                                        ),
                                        10.verticalSpace,
                                        SearchedItem(
                                          title: "Tax category",
                                          isSelected: false,
                                          onTap: () {
                                            setState(() {
                                              parentId = -1;
                                            });

                                            // notifier.setSelectedParentId(0);
                                            // notifier.setParentName(
                                            //     AppHelpers.getTranslation(TrKeys.no));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            physics: const CustomBouncingScrollPhysics(),
                                            itemCount: taxCategorySearch!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final taxCategory = taxCategorySearch![index];
                                              return SearchedItem(
                                                title: '${taxCategory["name"]}',
                                                isSelected: false,
                                                onTap: () {
                                                  setState(() {
                                                    taxCategoryId = taxCategory["index"];
                                                    taxCategoryName = taxCategory["name"];
                                                  });
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
                    10.verticalSpace,
                    SelectWithSearchButton(
                      label: "Cấp trên",
                      title: parentId == -1 ? "" : parentName,
                      onTap: () {
                        taxesSearch = state.taxes!;
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setModelState) {
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
                                              taxesSearch = state.taxes!.where((e) => e["name"].toString().toLowerCase().contains(v.toLowerCase())).toList();
                                            });
                                          },
                                          hintText: AppHelpers.getTranslation(TrKeys.search),
                                        ),
                                        10.verticalSpace,
                                        SearchedItem(
                                          title: "No tax parent",
                                          isSelected: false,
                                          onTap: () {
                                            setState(() {
                                              parentId = -1;
                                            });

                                            // notifier.setSelectedParentId(0);
                                            // notifier.setParentName(
                                            //     AppHelpers.getTranslation(TrKeys.no));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            physics: const CustomBouncingScrollPhysics(),
                                            itemCount: taxesSearch!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final parent = taxesSearch![index];
                                              return SearchedItem(
                                                title: '${parent["name"]}',
                                                isSelected: false,
                                                onTap: () {
                                                  setState(() {
                                                    parentId = parent["index"];
                                                    parentName = parent["name"];
                                                  });
                                                  print(parentId);
                                                  print(parentName);
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
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: CommonInputField(
                          initialValue: "0",
                          label: "Giá",
                          onChanged: (v) {
                            setState(() {
                              if (v.isNotEmpty) {
                                price = double.parse(v);
                              }
                            });
                          },
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                        )),
                        10.horizontalSpace,
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  RoundedCheckBox(
                                    value: activeCheckBoxCascade,
                                    onChanged: (value) {
                                      setState(() {
                                        activeCheckBoxCascade = !activeCheckBoxCascade;
                                        // product = product!.copyWith(active: activeCheckBoxAuto ? 1 : 0);
                                      });
                                    },
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    'Xếp cạnh',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: activeCheckBoxCascade ? AppColors.black : AppColors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: CommonInputField(
                          initialValue: "0",
                          label: "Thứ tự",
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              setState(() {
                                order = int.parse(v);
                              });
                            }
                          },
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                        )),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: Text(
                            'Hiệu lực: $dateExpire',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              letterSpacing: -0.4,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        IconButton(
                            color: AppColors.greenMain,
                            onPressed: () {
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
                                          dateExpire = date!;
                                        });
                                      }),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    150.verticalSpace,
                    CommonAccentButton(
                      isLoading: state.taxLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (taxName != "") {
                          var taxData = {
                            "name": taxName,
                            "tax_customer_category_id": taxCusCategoryId,
                            "tax_category_id": taxCategoryId,
                            "tax_id": parentId,
                            "rate": price,
                            "rate_cascade": activeCheckBoxCascade ? 1 : 0,
                            "rate_order": order,
                            "valid_from": DateFormat.yMd().add_Hms().format(dateExpire),
                          };
                          await notifier.addTax(taxData);
                          if (context.mounted) {
                            if (state.taxLoading! == false) {
                              context.popRoute();
                            }
                          }
                        }
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
