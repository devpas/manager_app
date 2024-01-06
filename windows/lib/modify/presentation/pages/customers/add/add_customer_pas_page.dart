import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/customers/customer_provider.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:g_manager_app/modify/riverpob/states/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class AddCustomerPasPage extends ConsumerStatefulWidget {
  const AddCustomerPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCustomerPasPage> createState() => _AddCustomerPasPageState();
}

class _AddCustomerPasPageState extends ConsumerState<AddCustomerPasPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String parentCategoryName = "";
  List<CategoryPasData>? categoriesSearch = [];
  bool active = true;
  late TabController _tabController;

  String taxCusCategoryName = "";
  List<dynamic>? taxCusCategorySearch = [];
  int taxCusCategoryId = 1;
  bool hideCheckBox = false;
  late CustomerData customer = CustomerData().initCustomer();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print(customer.toJson());
    Future.delayed(
      Duration.zero,
      () {
        ref.read(productsPASProvider.notifier).getListCustomerType();
      },
    );
  }

  Widget subTab(ProductsPasState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        physics: const CustomBouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Địa chỉ 1",
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
                  customer = customer.copyWith(address: e);
                });
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
            Text(
              "Địa chỉ 2",
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
                  customer = customer.copyWith(address2: e);
                });
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
            Text(
              "Mã bưu chính",
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
                  customer = customer.copyWith(postal: e);
                });
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
            Text(
              "Ghi chú",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.4,
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            TextFormField(
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              initialValue: customer.note,
              onChanged: (e) {
                setState(() {
                  customer = customer.copyWith(note: e);
                });
              },
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.4,
                  color: AppColors.inputNameHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainTab(ProductsPasState state) {
    final notifier = ref.read(customersProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        physics: const CustomBouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: CommonInputField(
                    initialValue: customer.searchkey,
                    label: "Mã số",
                    onChanged: (v) {
                      setState(() {
                        customer = customer.copyWith(searchkey: v);
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
                              value: hideCheckBox,
                              onChanged: (value) {
                                setState(() {
                                  hideCheckBox = !hideCheckBox;
                                  customer = customer.copyWith(visible: hideCheckBox ? 1 : 0);
                                });
                              },
                            ),
                            10.horizontalSpace,
                            Text(
                              'Thấy được',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: hideCheckBox ? AppColors.black : AppColors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              20.verticalSpace,
              Text(
                "Người giới thiệu",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: -0.4,
                  color: AppColors.black.withOpacity(0.3),
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: customer.ngt,
                onChanged: (e) {
                  setState(() {
                    customer = customer.copyWith(ngt: e);
                  });
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
              Text(
                "Tên khách hàng",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: -0.4,
                  color: AppColors.black.withOpacity(0.3),
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: customer.name,
                onChanged: (e) {
                  setState(() {
                    customer = customer.copyWith(name: e);
                  });
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
              Text(
                "email",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: -0.4,
                  color: AppColors.black.withOpacity(0.3),
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: customer.email,
                onChanged: (e) {
                  setState(() {
                    customer = customer.copyWith(email: e);
                  });
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
              Text(
                "SĐT",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: -0.4,
                  color: AppColors.black.withOpacity(0.3),
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: customer.phone,
                onChanged: (e) {
                  customer = customer.copyWith(phone: e);
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
              Row(
                children: [
                  Expanded(
                      child: CommonInputField(
                    initialValue: customer.maxDebt.toString(),
                    label: "Nợ tối đa",
                    onChanged: (v) {
                      setState(() {
                        if (v.isNotEmpty) {
                          customer = customer.copyWith(maxDebt: double.parse(v));
                        }
                      });
                    },
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                  )),
                  10.horizontalSpace,
                  Expanded(
                      child: AbsorbPointer(
                    absorbing: true,
                    child: CommonInputField(
                      initialValue: customer.curDebt.toString(),
                      label: "Nợ hiện tại",
                      onChanged: (v) {
                        setState(() {
                          if (v.isNotEmpty) {
                            customer = customer.copyWith(curDebt: double.parse(v));
                          }
                        });
                      },
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                  )),
                  10.horizontalSpace,
                  Expanded(
                      child: AbsorbPointer(
                    absorbing: true,
                    child: CommonInputField(
                      initialValue: DateFormat.yMd().format(DateTime.now()),
                      label: "Ngày tạo",
                      onChanged: (v) {
                        customer = customer.copyWith(createDate: DateTime.now());
                      },
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                  )),
                ],
              ),
              20.verticalSpace,
              SelectWithAddButton(
                label: "Mục khách hàng",
                title: taxCusCategoryId == -1 ? "" : taxCusCategoryName,
                onSelectTap: () {
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
                                        taxCusCategoryId = -1;
                                      });
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
                                            print(taxCusCategory);
                                            setState(() {
                                              taxCusCategoryId = taxCusCategory["index"];
                                              taxCusCategoryName = taxCusCategory["name"];
                                              customer = customer.copyWith(taxCusCategory: taxCusCategory["id"]);
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  20.verticalSpace,
                                ],
                              ),
                            ),
                          );
                        });
                      });
                },
              ),
              120.verticalSpace,
              CommonAccentButton(
                isLoading: false,
                title: AppHelpers.getTranslation(TrKeys.save),
                onPressed: () {
                  print(customer.toJson());
                  notifier.addCustomer(customer.toJson());
                  context.popRoute();
                },
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(productsPASProvider.notifier);
    final state = ref.watch(productsPASProvider);
    return AbsorbPointer(
        absorbing: false,
        child: KeyboardDismisser(
          child: Scaffold(
            backgroundColor: AppColors.shopsPageBack,
            appBar: CustomAppbarPOS(
              title: Text(
                "Thêm khách hàng",
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
            body: Column(children: [
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
                    Tab(text: "Thông tin Chính"),
                    Tab(text: "Thông tin phụ"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const CustomBouncingScrollPhysics(),
                  children: [mainTab(state), subTab(state)],
                ),
              )
            ]),
          ),
        ));
  }
}
