import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';

class EditBrandPage extends ConsumerWidget {
  final int id;

  const EditBrandPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editBrandProvider);
    final notifier = ref.read(editBrandProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: CustomAppbar(
            title: AppHelpers.getTranslation(TrKeys.editBrand),
            leading: SmallIconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: context.popRoute,
            ),
          ),
          body: state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 3.r,
                  ),
                )
              : Padding(
                  padding: REdgeInsets.symmetric(horizontal: 15.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        physics: const CustomBouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                40.verticalSpace,
                                Align(
                                  alignment: Alignment.center,
                                  child: SelectImage(
                                    imageUrl: state.imageUrl,
                                    file: state.brandFile,
                                    onChangePhoto: (XFile brandFile) {
                                      notifier.setBrandFile(brandFile);
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
                                  initialValue: state.brandName,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: notifier.setBrandName,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    letterSpacing: -0.4,
                                    color: AppColors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppHelpers.getTranslation(
                                        TrKeys.inputName),
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: -0.4,
                                      color: AppColors.inputNameHint,
                                    ),
                                  ),
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
                                      value: state.brandStatus,
                                      onChanged: (value) {
                                        notifier
                                            .setBrandStatus(!state.brandStatus);
                                      },
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      state.brandStatus
                                          ? AppHelpers.getTranslation(
                                              TrKeys.active)
                                          : AppHelpers.getTranslation(
                                              TrKeys.inactive),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: state.brandStatus
                                            ? AppColors.black
                                            : AppColors.black.withOpacity(0.5),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                10.horizontalSpace,
                                CommonAccentButton(
                                  isLoading: state.isSaving,
                                  title: AppHelpers.getTranslation(TrKeys.save),
                                  onPressed: () {
                                    notifier.updateBrand(context, id);
                                  },
                                ),
                                30.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
