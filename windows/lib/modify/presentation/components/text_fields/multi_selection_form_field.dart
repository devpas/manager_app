import 'package:flutter/material.dart';

import 'custom_multi_selection_field.dart';

class CustomMultiSelectionFormField<T> extends FormField<List<T>> {
  CustomMultiSelectionFormField({
    Key? key,
    FormFieldSetter<List>? onSaved,
    List<T>? initialValues,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValues,
          builder: (FormFieldState<List> field) {
            return CustomMultiSelectionField(
              values: field.value?.map((e) => e.toString()).toList() ?? [],
              onChanged: field.didChange,
            );
          },
        );
}
