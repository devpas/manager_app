import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/dependency_manager.dart';
import '../../notifiers/notifiers.dart';
import '../../states/states.dart';

final shopEditProvider = StateNotifierProvider<ShopEditNotifier, ShopEditState>(
  (ref) => ShopEditNotifier(shopsRepository, galleryRepository),
);
