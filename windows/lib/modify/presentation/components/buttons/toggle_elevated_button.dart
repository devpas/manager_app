import 'package:flutter/material.dart';

import '../../../../src/presentation/theme/theme.dart';

class ToggleElevatedButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onPressed;

  const ToggleElevatedButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: isSelected
            ? AppTypographies.styWhite12W500
            : AppTypographies.styToggleUnselected12W500,
      ),
    );
  }
}
