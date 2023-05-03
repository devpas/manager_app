import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modify/presentation/theme/theme.dart';

class CustomAppbarPOS extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppbarPOS({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: leading != null ? 0 : 15.r,
      title: Center(
        child: Column(
          children: [
            Text(
              "VTNN-CẨM CHÂU HẬU GIANG",
              style: AppTypographies.styBlack12W400,
            ),
            Text(
              "Admin - kho 1",
              style: AppTypographies.styBlack12W400,
            ),
          ],
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
