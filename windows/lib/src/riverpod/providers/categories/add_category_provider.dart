import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/dependency_manager.dart';
import '../../notifiers/notifiers.dart';
import '../../states/states.dart';

final addCategoryProvider =
    StateNotifierProvider.autoDispose<AddCategoryNotifier, AddCategoryState>(
  (ref) => AddCategoryNotifier(categoriesRepository, galleryRepository),
);
