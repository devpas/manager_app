import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'widgets/edit_back_image_button.dart';
import 'widgets/edit_logo_button.dart';
import 'widgets/edit_shop_status_modal.dart';

class ShopEditPage extends ConsumerStatefulWidget {
  final String? uuid;

  const ShopEditPage({Key? key, required this.uuid}) : super(key: key);

  @override
  ConsumerState<ShopEditPage> createState() => _ShopEditPageState();
}

class _ShopEditPageState extends ConsumerState<ShopEditPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(shopEditProvider.notifier).fetchShopDetails(widget.uuid);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shopEditProvider);
    final notifier = ref.read(shopEditProvider.notifier);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: Scaffold(
        backgroundColor: AppColors.shopsPageBack,
        appBar: CustomAppbar(
          title: AppHelpers.getTranslation(TrKeys.shopEdit),
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
            : SingleChildScrollView(
                physics: const CustomBouncingScrollPhysics(),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.verticalSpace,
                      MainStatusButton(
                        onTap: () => showCupertinoModalBottomSheet(
                          context: context,
                          expand: false,
                          builder: (context) => const EditShopStatusModal(),
                        ),
                        title: AppHelpers.getTranslation(TrKeys.shopStatus),
                        statusColor: state.statusColor,
                        statusText: state.statusText,
                      ),
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.logo),
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      12.verticalSpace,
                      EditLogoButton(
                        onChangePhoto: notifier.setLogoFile,
                        imageUrl: state.logoUrl,
                        statusColor: AppColors.greenMain,
                        logoFile: state.logoFile,
                        onDelete: () {
                          notifier.setLogoFile(null);
                          notifier.setLogoUrl(null);
                        },
                      ),
                      12.verticalSpace,
                      EditBackImageButton(
                        onChangePhoto: notifier.setBackFile,
                        imageUrl: state.backUrl,
                        statusColor: AppColors.greenMain,
                        file: state.backFile,
                        onDelete: () {
                          notifier.setBackFile(null);
                        },
                      ),
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.shopName),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setShopName,
                        initialValue: state.title,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.shopUsers),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setUserId,
                        initialValue: state.shopUserId,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.phone),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setPhone,
                        initialValue: state.phone,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.description),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setDescription,
                        initialValue: state.description,
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
                      24.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppHelpers.getTranslation(TrKeys.openHours),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: -0.4,
                                    color: AppColors.black.withOpacity(0.3),
                                  ),
                                ),
                                TextFormField(
                                  controller: state.openController,
                                  onTap: () async {
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    notifier.setOpenTime(pickedTime);
                                  },
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: '00:00',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          13.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppHelpers.getTranslation(TrKeys.closeHours),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: -0.4,
                                    color: AppColors.black.withOpacity(0.3),
                                  ),
                                ),
                                TextFormField(
                                  controller: state.closeController,
                                  onTap: () async {
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    notifier.setCloseTime(pickedTime);
                                  },
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: '00:00',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.visibility),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          RoundedCheckBox(
                            value: state.visibility,
                            onChanged: (value) {
                              notifier.setVisibility(!state.visibility);
                            },
                          ),
                          10.horizontalSpace,
                          Text(
                            state.visibility
                                ? AppHelpers.getTranslation(TrKeys.on)
                                : AppHelpers.getTranslation(TrKeys.off),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: state.visibility
                                  ? AppColors.black
                                  : AppColors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.minimumAmount),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setMinAmount,
                        initialValue: state.minAmount,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.tax),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setTax,
                        initialValue: state.tax,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.percentage),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setPercentage,
                        initialValue: state.percentage,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.address),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setAddress,
                        initialValue: state.address,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.deliveryRange),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: notifier.setDeliveryRange,
                        initialValue: state.deliveryRange,
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
                      24.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.selectShopLocation),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.4,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      12.verticalSpace,
                      const SizedBox(
                        height: 513,
                        width: double.infinity,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            bearing: 192.8334901395799,
                            target:
                                LatLng(37.43296265331129, -122.08832357078792),
                            tilt: 59.440717697143555,
                            zoom: 19.151926040649414,
                          ),
                        ),
                      ),
                      50.verticalSpace,
                      CommonAccentButton(
                        isLoading: state.isSaving,
                        title: AppHelpers.getTranslation(TrKeys.save),
                        onPressed: () =>
                            notifier.updateShop(context, widget.uuid),
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
