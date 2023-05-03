import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

Route<T> modalsPageRoute<T>(
  BuildContext context,
  Widget child,
  CustomPage<T> page,
) {
  return MaterialPageRoute(
    fullscreenDialog: page.fullscreenDialog,
    settings: page,
    builder: (_) => child,
  );
}
