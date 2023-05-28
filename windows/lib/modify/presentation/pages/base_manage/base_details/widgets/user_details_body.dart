import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/core/constants/constants.dart';
import '../../../../../../src/core/utils/utils.dart';
import '../../../../../../src/riverpod/providers/providers.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'user_roles_modal_in_edit_user.dart';

class UserDetailsBody extends ConsumerWidget {
  final OpenEditUserFrom from;

  const UserDetailsBody({Key? key, required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editUserProvider);
    final notifier = ref.read(editUserProvider.notifier);
    return state.isLoading
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
                  Align(
                    alignment: Alignment.center,
                    child: SelectImage(
                      imageUrl: state.imageUrl,
                      file: state.image,
                      onChangePhoto: notifier.setImage,
                    ),
                  ),
                  38.verticalSpace,
                  CommonInputField(
                    initialValue: state.firstname,
                    label: AppHelpers.getTranslation(TrKeys.firstname),
                    onChanged: notifier.setFirstname,
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.lastname,
                    label: AppHelpers.getTranslation(TrKeys.lastname),
                    onChanged: notifier.setLastname,
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.email,
                    label: AppHelpers.getTranslation(TrKeys.email),
                    onChanged: notifier.setEmail,
                    inputType: TextInputType.emailAddress,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.phone,
                    label: AppHelpers.getTranslation(TrKeys.phone),
                    onChanged: notifier.setPhone,
                    inputType: TextInputType.phone,
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: AppHelpers.getTranslation(TrKeys.role),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => UserRolesModalInEditUser(
                        userRole: state.activeRole,
                      ),
                    ),
                    title: AppHelpers.getUserRoleText(state.activeRole),
                  ),
                  30.verticalSpace,
                  Theme(
                    data: Theme.of(context).copyWith(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                    ),
                    child: PopupMenuButton<String>(
                      initialValue: state.gender,
                      elevation: 0,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'male',
                            child: Text(
                              AppHelpers.getTranslation(TrKeys.male),
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'female',
                            child: Text(
                              AppHelpers.getTranslation(TrKeys.female),
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ];
                      },
                      onSelected: notifier.setGender,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppHelpers.getTranslation(TrKeys.gender),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              letterSpacing: -0.4,
                              color: AppColors.black.withOpacity(0.3),
                            ),
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.dropdownFill,
                            ),
                            padding: REdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    state.gender == 'male'
                                        ? AppHelpers.getTranslation(TrKeys.male)
                                        : AppHelpers.getTranslation(
                                            TrKeys.female),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  FlutterRemix.arrow_down_s_line,
                                  size: 24.r,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: AppHelpers.getTranslation(TrKeys.dateOfBirth),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => DateOfBirthModal(
                        onDateSaved: notifier.setDob,
                        initialDate: state.dob,
                      ),
                    ),
                    title: state.dob.isEmpty
                        ? AppHelpers.getTranslation(TrKeys.dateOfBirth)
                        : state.dob,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.password,
                    label: AppHelpers.getTranslation(TrKeys.password),
                    onChanged: notifier.setPassword,
                    inputType: TextInputType.text,
                    obscure: true,
                    hintText: '********',
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: state.confirmPassword,
                    label: AppHelpers.getTranslation(TrKeys.confirmPassword),
                    onChanged: notifier.setConfirmPassword,
                    inputType: TextInputType.text,
                    obscure: true,
                    hintText: '********',
                  ),
                  30.verticalSpace,
                  CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () => notifier.updateUser(
                      checkYourNetwork: () {
                        AppHelpers.showCheckFlash(
                          context,
                          AppHelpers.getTranslation(
                              TrKeys.checkYourNetworkConnection),
                        );
                      },
                      afterUpdating: () {
                        context.popRoute();
                        switch (from) {
                          case OpenEditUserFrom.deliveryBoys:
                            ref
                                .read(deliveryBoysProvider.notifier)
                                .updateDeliveryMen(context);
                            break;
                          case OpenEditUserFrom.dashboard:
                            ref
                                .read(dashboardProvider.notifier)
                                .updateCustomers(context);
                            break;
                          case OpenEditUserFrom.users:
                            ref
                                .read(usersProvider.notifier)
                                .updateUsers(context);
                            break;
                        }
                      },
                    ),
                    isLoading: state.isSaving,
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          );
  }
}
