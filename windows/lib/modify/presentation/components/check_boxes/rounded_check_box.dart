import 'package:flutter/material.dart';

import '../../../../src/presentation/theme/theme.dart';

class RoundedCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const RoundedCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      splashRadius: 20,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkColor: AppColors.white,
      activeColor: AppColors.greenMain,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
