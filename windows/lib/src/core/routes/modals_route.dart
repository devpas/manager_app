import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Route<T> modalsPageRoute<T>(
    BuildContext context,
    Widget child,
    CustomPage<T> page,
    ) {
  return MaterialWithModalsPageRoute(
    fullscreenDialog: page.fullscreenDialog,
    settings: page,
    builder: (_) => child,
  );
}
