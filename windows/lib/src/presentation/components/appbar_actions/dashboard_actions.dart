import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../small_icon_button.dart';
import '../../theme/theme.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';

List<Widget> getDashboardActions(BuildContext context) => [
      SmallIconButton(
        icon: SvgPicture.asset(
          AppAssets.svgIcNotification,
          color: AppColors.darkBlue.withOpacity(0.3),
        ),
        onPressed: () => context.pushRoute(const NotificationsRoute()),
      ),
    ];
