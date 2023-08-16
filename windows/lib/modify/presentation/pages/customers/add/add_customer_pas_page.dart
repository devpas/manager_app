import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/presentation/pages/customers/widgets/select_type_customer_modal.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../src/core/constants/constants.dart';
import '../../../../../src/core/utils/utils.dart';
import '../../../../../src/riverpod/providers/providers.dart';
import '../../../../models/models.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class AddCustomerPasPage extends ConsumerStatefulWidget {
  const AddCustomerPasPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCustomerPasPage> createState() => _AddCustomerPasPageState();
}

class _AddCustomerPasPageState extends ConsumerState<AddCustomerPasPage> {
  final _formKey = GlobalKey<FormState>();

  String parentCategoryName = "";
  List<CategoryPasData>? categoriesSearch = [];
  String categoryName = "";
  int parentCategoryId = -1;
  XFile? image;
  bool active = true;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(categoriesPASProvider.notifier);
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
                      onChanged: (e) {},
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
                    30.verticalSpace,
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
                      onChanged: (e) {},
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
                    30.verticalSpace,
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
                      onChanged: (e) {},
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
                    30.verticalSpace,
                    SelectWithAddButton(
                      label: "Nhóm khách hàng",
                      title: "Nhóm khách hàng",
                      onSelectTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SelectTypeCustomerModal(),
                        );
                      },
                    ),
                    200.verticalSpace,
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
