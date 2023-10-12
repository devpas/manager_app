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

class UpdateTaxPage extends ConsumerStatefulWidget {
  const UpdateTaxPage(this.tax, {Key? key}) : super(key: key);
  final dynamic tax;

  @override
  ConsumerState<UpdateTaxPage> createState() => _UpdateTaxPageState(tax);
}

class _UpdateTaxPageState extends ConsumerState<UpdateTaxPage> {
  final _formKey = GlobalKey<FormState>();

  final dynamic tax;
  String taxName = "";
  XFile? image;
  bool active = true;

  _UpdateTaxPageState(this.tax);

  @override
  void initState() {
    setState(() {
      taxName = tax["name"];
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
                      initialValue: taxName,
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
                    500.verticalSpace,
                    CommonAccentButton(
                      isLoading: state.taxLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (taxName != "") {
                          var taxData = {
                            "index": tax["index"],
                            "id": tax["id"],
                            "name": taxName,
                          };
                          await notifier.updateTax(taxData);
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
