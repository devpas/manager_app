import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../../models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class AddCategoryPasPage extends ConsumerStatefulWidget {
  const AddCategoryPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCategoryPasPage> createState() => _AddCategoryPasPageState();
}

class _AddCategoryPasPageState extends ConsumerState<AddCategoryPasPage> {
  final _formKey = GlobalKey<FormState>();

  String parentCategoryName = "";
  List<CategoryPasData>? categoriesSearch = [];
  String categoryName = "";
  int parentCategoryId = -1;
  XFile? image;
  bool active = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesPASProvider);
    final notifier = ref.read(categoriesPASProvider.notifier);
    final categoriesNotifier = ref.read(categoriesProvider.notifier);
    return AbsorbPointer(
      absorbing: false,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: AppColors.shopsPageBack,
          appBar: CustomAppbarPOS(
            title: Text(
              "Thêm danh mục",
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
                        setState(() {
                          categoryName = e;
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: AppHelpers.getTranslation(TrKeys.inputName),
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
                                                      .contains(
                                                          v.toLowerCase()))
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
                          value: active,
                          onChanged: (value) {
                            setState(() {
                              active = value!;
                            });
                          },
                        ),
                        10.horizontalSpace,
                        Text(
                          active
                              ? AppHelpers.getTranslation(TrKeys.active)
                              : AppHelpers.getTranslation(TrKeys.inactive),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: active
                                ? AppColors.black
                                : AppColors.black.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                    categoryName == ""
                        ? const SizedBox(
                            child: Text("Xin nhập đầy đủ thông tin"),
                          )
                        : const SizedBox(),
                    220.verticalSpace,
                    CommonAccentButton(
                      isLoading: false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () {
                        if (categoryName != "") {
                          var base64 = "";
                          if (image != null) {
                            final bytes = File(image!.path).readAsBytesSync();
                            base64 = base64Encode(bytes);
                          }

                          var dataCategory = {
                            "name": categoryName,
                            "parent_id": parentCategoryId,
                            "image": base64,
                            "active": active
                          };
                          notifier.addCategory(dataCategory);
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
