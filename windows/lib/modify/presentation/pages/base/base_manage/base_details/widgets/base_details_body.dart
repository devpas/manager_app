import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_manager_app/modify/riverpob/providers/providers.dart';

import '../../../../../../../../src/core/constants/constants.dart';
import '../../../../../../../../src/core/utils/utils.dart';
import '../../../../../../../../src/riverpod/providers/providers.dart';
import '../../../../../../models/models.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'sub_page/base_type_modal.dart';

class BaseDetailsBody extends ConsumerWidget {
  final OpenEditUserFrom from;
  final BaseData base;

  const BaseDetailsBody({Key? key, required this.from, required this.base})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseProvider);
    final notifier = ref.read(baseProvider.notifier);
    return state.baseLoading!
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
                  10.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: SelectImage(
                      imageUrl: "",
                      file: state.image,
                      onChangePhoto: notifier.setImage,
                    ),
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: base.baseName,
                    label: "Tên cơ sở",
                    onChanged: (input) => {},
                    inputType: TextInputType.name,
                  ),
                  30.verticalSpace,
                  CommonInputField(
                    initialValue: base.phone,
                    label: AppHelpers.getTranslation(TrKeys.phone),
                    onChanged: (input) => {},
                    inputType: TextInputType.phone,
                  ),
                  30.verticalSpace,
                  SelectWithSearchButton(
                    label: "Loại cơ sở",
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => BaseTypesModal(
                        baseTypeActive: base.baseType!,
                      ),
                    ),
                    title: "Trồng trọt",
                  ),
                  170.verticalSpace,
                  CommonAccentButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    onPressed: () {},
                    isLoading: false,
                  ),
                ],
              ),
            ),
          );
  }
}
