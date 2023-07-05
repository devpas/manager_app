import 'package:flutter/material.dart';

import '../../../../../src/presentation/theme/theme.dart';

class SettingsButton extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;

  const SettingsButton({Key? key, required this.iconData, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.settingsButtonBack,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          width: 72,
          height: 72,
          child: Icon(
            iconData,
            color: AppColors.settingsButtonIcon,
          ),
        ),
      ),
    );
  }
}
