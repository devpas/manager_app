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

class UpdateTaxCusCategoryPage extends ConsumerStatefulWidget {
  const UpdateTaxCusCategoryPage(this.taxCusCategory, {Key? key}) : super(key: key);
  final dynamic taxCusCategory;

  @override
  ConsumerState<UpdateTaxCusCategoryPage> createState() => _UpdateTaxCusCategoryPageState(taxCusCategory);
}

class _UpdateTaxCusCategoryPageState extends ConsumerState<UpdateTaxCusCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  final dynamic taxCusCategory;
  String taxCusCategoryName = "";
  XFile? image;
  bool active = true;

  _UpdateTaxCusCategoryPageState(this.taxCusCategory);

  @override
  void initState() {
    setState(() {
      taxCusCategoryName = taxCusCategory["name"];
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
              "Thông tin loại khách hàng",
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
                      initialValue: taxCusCategoryName,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          taxCusCategoryName = e;
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
                      isLoading: state.taxCusCategoryLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (taxCusCategoryName != "") {
                          var taxCusCategoryData = {
                            "index": taxCusCategory["index"],
                            "id": taxCusCategory["id"],
                            "name": taxCusCategoryName,
                          };
                          await notifier.updateTaxCusCategory(taxCusCategoryData);
                          if (context.mounted) {
                            if (state.taxCusCategoryLoading! == false) {
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
