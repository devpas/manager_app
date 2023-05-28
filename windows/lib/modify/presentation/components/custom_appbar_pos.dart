import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modify/presentation/theme/theme.dart';

class CustomAppbarPOS extends StatelessWidget implements PreferredSize {
  final Text title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? center;

  const CustomAppbarPOS({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: leading != null ? 0 : 15.r,
      title: center!
          ? Center(
              child: Column(
                children: [
                  title,
                  subtitle != null
                      ? Text(
                          subtitle!,
                          style: AppTypographies.styBlack12W400,
                        )
                      : const SizedBox(),
                ],
              ),
            )
          : Column(
              children: [
                title,
                subtitle != null
                    ? Text(
                        subtitle!,
                        style: AppTypographies.styBlack12W400,
                      )
                    : const SizedBox(),
              ],
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
