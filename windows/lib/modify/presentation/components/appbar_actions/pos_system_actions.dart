import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/presentation/pages/pos_system/widgets/pos_system_filter_modal.dart';
import '../../../../src/presentation/theme/theme.dart';
import '../components.dart';

List<Widget> getPosSystemActions(BuildContext context) => [
      SmallIconButton(
        icon: Icon(
          FlutterRemix.sound_module_fill,
          size: 24.r,
          color: AppColors.black,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => const PosSystemFilterModal(),
        ),
      ),
    ];
