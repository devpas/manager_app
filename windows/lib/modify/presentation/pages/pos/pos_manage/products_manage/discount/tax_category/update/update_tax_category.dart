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

import '../../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/theme.dart';

class UpdateTaxCategoryPage extends ConsumerStatefulWidget {
  const UpdateTaxCategoryPage(this.taxCategory, {Key? key}) : super(key: key);
  final dynamic taxCategory;

  @override
  ConsumerState<UpdateTaxCategoryPage> createState() => _UpdateTaxCategoryPageState(taxCategory);
}

class _UpdateTaxCategoryPageState extends ConsumerState<UpdateTaxCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  final dynamic taxCategory;
  String taxCategoryName = "";
  XFile? image;
  bool active = true;

  _UpdateTaxCategoryPageState(this.taxCategory);

  @override
  void initState() {
    setState(() {
      taxCategoryName = taxCategory["name"];
    });
    super.initState();
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
              "Thông tin chiếc khấu",
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
                    30.verticalSpace,
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
                      initialValue: taxCategoryName,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          taxCategoryName = e;
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                    500.verticalSpace,
                    CommonAccentButton(
                      isLoading: state.taxCategoryLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (taxCategoryName != "") {
                          var taxCategoryData = {
                            "index": taxCategory["index"],
                            "id": taxCategory["id"],
                            "name": taxCategoryName,
                          };
                          await notifier.updateTaxCategory(taxCategoryData);
                          if (context.mounted) {
                            if (state.taxCategoryLoading! == false) {
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
