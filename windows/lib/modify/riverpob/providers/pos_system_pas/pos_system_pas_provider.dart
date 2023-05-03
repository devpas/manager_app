import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifiers/notifiers.dart';
import '../../states/states.dart';

final posSystemPASProvider =
    StateNotifierProvider<PosSystemNotifier, PosSystemState>(
  (ref) => PosSystemNotifier(),
);
