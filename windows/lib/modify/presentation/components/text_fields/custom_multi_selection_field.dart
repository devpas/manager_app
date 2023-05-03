import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src/presentation/theme/theme.dart';
import 'custom_chips_list.dart';

class CustomMultiSelectionField<T> extends StatefulWidget {
  final ValueChanged<List> onChanged;
  final List<String> values;

  const CustomMultiSelectionField({
    Key? key,
    required this.onChanged,
    required this.values,
  }) : super(key: key);

  @override
  State<CustomMultiSelectionField<T>> createState() =>
      _CustomMultiSelectionFieldState<T>();
}

class _CustomMultiSelectionFieldState<T>
    extends State<CustomMultiSelectionField<T>> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Input keywords',
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: -0.4,
              color: AppColors.inputNameHint,
            ),
          ),
          controller: _controller,
          onFieldSubmitted: (String value) {
            _controller.clear();
            widget.values.add(value);
            widget.onChanged(widget.values);
          },
        ),
        CustomChipList(
          values: widget.values,
          chipBuilder: (String value) {
            return Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Chip(
                deleteIcon: Icon(
                  FlutterRemix.close_line,
                  size: 20.r,
                  color: AppColors.black,
                ),
                label: Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onDeleted: () {
                  widget.values.remove(value);
                  widget.onChanged(widget.values);
                },
              ),
            );
          },
        )
      ],
    );
  }
}
