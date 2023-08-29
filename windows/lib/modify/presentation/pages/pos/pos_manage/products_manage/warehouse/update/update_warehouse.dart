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

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';

class UpdateWarehousePage extends ConsumerStatefulWidget {
  const UpdateWarehousePage(this.warehouse, {Key? key}) : super(key: key);
  final dynamic warehouse;

  @override
  ConsumerState<UpdateWarehousePage> createState() =>
      _UpdateWarehousePageState(warehouse);
}

class _UpdateWarehousePageState extends ConsumerState<UpdateWarehousePage> {
  final _formKey = GlobalKey<FormState>();

  final dynamic warehouse;
  String address = "";
  String warehouseName = "";
  XFile? image;
  bool active = true;

  _UpdateWarehousePageState(this.warehouse);

  @override
  void initState() {
    setState(() {
      warehouseName = warehouse["name"];
      address = warehouse["address"] ?? "";
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
              "Thông tin kho chứa",
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
                      initialValue: warehouseName,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          warehouseName = e;
                        });
                      },
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.4,
                        color: AppColors.black,
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      "Địa chỉ",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.4,
                        color: AppColors.black.withOpacity(0.3),
                      ),
                    ),
                    TextFormField(
                      initialValue: address,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (e) {
                        setState(() {
                          address = e;
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
                      isLoading: state.warehouseLoading! ? true : false,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () async {
                        if (warehouseName != "") {
                          var dataWarehouse = {
                            "id": warehouse["id"],
                            "name": warehouseName,
                            "address": address,
                          };
                          await notifier.updateWarehouse(dataWarehouse);
                          if (context.mounted) {
                            if (state.warehouseLoading! == false) {
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
