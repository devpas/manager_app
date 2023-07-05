import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/models/data/category_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../modify/riverpob/providers/providers.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'widgets/search_category_modal_in_edit_category.dart';

class EditCategoryPasPage extends ConsumerStatefulWidget {
  final CategoryPasData category;

  const EditCategoryPasPage({Key? key, required this.category})
      : super(key: key);

  @override
  ConsumerState<EditCategoryPasPage> createState() =>
      // ignore: no_logic_in_create_state
      _EditCategoryPasPageState(category);
}

class _EditCategoryPasPageState extends ConsumerState<EditCategoryPasPage> {
  final _formKey = GlobalKey<FormState>();

  late CategoryPasData category;
  CategoryPasData? categoryAfterEdit;
  XFile? image;
  String parentCategoryName = "";
  List<CategoryPasData>? categoriesSearch = [];

  _EditCategoryPasPageState(this.category);

  @override
  void initState() {
    super.initState();
    categoryAfterEdit = category;
    Future.delayed(
      Duration.zero,
      () {
        if (category.parentId != -1) {
          setState(() {
            categoriesSearch = ref.watch(categoriesPASProvider).categories;
            parentCategoryName = ref
                .watch(categoriesPASProvider)
                .categories!
                .where((e) => e.id == category.parentId)
                .toList()
                .first
                .name!;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesPASProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.shopsPageBack,
          appBar: CustomAppbarPOS(
            title: Text(
              "Chỉnh sửa danh mục",
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
          body: category.id == -1
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 3.r,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SingleChildScrollView(
                    physics: const CustomBouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          Align(
                            alignment: Alignment.center,
                            child: SelectImage(
                              imageUrl: categoryAfterEdit!.img,
                              file: image,
                              onChangePhoto: (XFile file) {
                                setState(() {
                                  image = file;
                                });
                              },
                            ),
                          ),
                          30.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.name),
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
                              categoryAfterEdit =
                                  categoryAfterEdit!.copyWith(name: e);
                            },
                            initialValue: categoryAfterEdit!.name,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: -0.4,
                              color: AppColors.black,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  AppHelpers.getTranslation(TrKeys.inputName),
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: -0.4,
                                color: AppColors.inputNameHint,
                              ),
                            ),
                          ),
                          30.verticalSpace,
                          SelectWithSearchButton(
                            label: AppHelpers.getTranslation(
                                TrKeys.parentCategory),
                            title: categoryAfterEdit!.parentId == -1
                                ? "Chọn danh mục cấp trên"
                                : parentCategoryName,
                            onTap: () {
                              categoriesSearch = state.categories!;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setModelState) {
                                      return Material(
                                        color: AppColors.mainBackground,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            left: 15,
                                            right: 15,
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SearchTextField(
                                                onChanged: (v) {
                                                  setModelState(() {
                                                    categoriesSearch = state
                                                        .categories!
                                                        .where((e) => e.name!
                                                            .toLowerCase()
                                                            .contains(v
                                                                .toLowerCase()))
                                                        .toList();
                                                  });
                                                },
                                                hintText:
                                                    AppHelpers.getTranslation(
                                                        TrKeys.searchCategory),
                                              ),
                                              10.verticalSpace,
                                              SearchedItem(
                                                title:
                                                    AppHelpers.getTranslation(
                                                        TrKeys.noCategory),
                                                isSelected: false,
                                                onTap: () {
                                                  setState(() {
                                                    categoryAfterEdit =
                                                        categoryAfterEdit!
                                                            .copyWith(
                                                                parentId: -1);
                                                  });

                                                  // notifier.setSelectedParentId(0);
                                                  // notifier.setParentCategoryName(
                                                  //     AppHelpers.getTranslation(TrKeys.noCategory));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  physics:
                                                      const CustomBouncingScrollPhysics(),
                                                  itemCount:
                                                      categoriesSearch!.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final parentCategory =
                                                        categoriesSearch![
                                                            index];
                                                    return SearchedItem(
                                                      title:
                                                          '${parentCategory.name}',
                                                      isSelected: false,
                                                      onTap: () {
                                                        setState(() {
                                                          categoryAfterEdit =
                                                              categoryAfterEdit!
                                                                  .copyWith(
                                                                      parentId:
                                                                          parentCategory
                                                                              .id);
                                                          parentCategoryName =
                                                              parentCategory
                                                                  .name!;
                                                        });
                                                        print(categoryAfterEdit!
                                                            .parentId);
                                                        print(
                                                            parentCategoryName);
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
                          39.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.status),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ),
                          17.verticalSpace,
                          Row(
                            children: [
                              RoundedCheckBox(
                                value: category.active == 1 ? true : false,
                                onChanged: (value) {
                                  category.copyWith(
                                      active: value == true ? 1 : 0);
                                },
                              ),
                              10.horizontalSpace,
                              Text(
                                category.active == 1
                                    ? AppHelpers.getTranslation(TrKeys.active)
                                    : AppHelpers.getTranslation(
                                        TrKeys.inactive),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: category.active == 1
                                      ? AppColors.black
                                      : AppColors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          210.verticalSpace,
                          CommonAccentButton(
                            isLoading: false,
                            title: AppHelpers.getTranslation(TrKeys.save),
                            onPressed: () {
                              if (categoryAfterEdit!.name != "") {
                                var base64 = "";
                                if (image != null) {
                                  final bytes =
                                      File(image!.path).readAsBytesSync();
                                  base64 = base64Encode(bytes);
                                }
                                var dataCategory = {
                                  "id": categoryAfterEdit!.id,
                                  "name": categoryAfterEdit!.name,
                                  "parent_id": categoryAfterEdit!.parentId,
                                  "image": base64,
                                  "active": categoryAfterEdit!.active
                                };
                                notifier.updateCategory(dataCategory);
                                context.popRoute();
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
