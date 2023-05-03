import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../src/presentation/theme/theme.dart';

class SmallIconButton extends StatelessWidget {
  final Widget icon;
  final Function() onPressed;

  const SmallIconButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 18.r,
      padding: EdgeInsets.zero,
      splashColor: AppColors.white.withOpacity(0.1),
      icon: icon,
    );
  }
}
