import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../pages/pos_system/widgets/pos_system_filter_modal.dart';
import '../../theme/theme.dart';
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
