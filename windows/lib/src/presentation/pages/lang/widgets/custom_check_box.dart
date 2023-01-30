import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme.dart';

class CustomCheckbox extends ConsumerWidget {
  final bool? isChecked;

  const CustomCheckbox({Key? key, this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      isChecked! ? Icons.check_circle : Icons.circle_outlined,
      size: 24,
      color: isChecked! ? AppColors.greenMain : AppColors.black,
    );
  }
}
