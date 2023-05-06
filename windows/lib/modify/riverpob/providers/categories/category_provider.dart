import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/di/dependency_manager.dart';
import '../../notifiers/notifiers.dart';
import '../../states/states.dart';

final categoriesPASProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>(
  (ref) => CategoriesNotifier(categoriesPASRepository),
);
