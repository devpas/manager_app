import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/notifiers.dart';
import '../states/states.dart';

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(),
);
