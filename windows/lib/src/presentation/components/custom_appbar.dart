import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppbar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.appbarShadowColor,
            blurRadius: 2.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        titleSpacing: leading != null ? 0 : 15.r,
        title: Text(
          title,
          style: AppTypographies.styBlack16W500,
        ),
        leading: leading,
        actions: actions,
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
