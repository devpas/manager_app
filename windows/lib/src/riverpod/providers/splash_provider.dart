import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/notifiers.dart';
import '../states/states.dart';
import '../../core/di/dependency_manager.dart';

final splashProvider =
    StateNotifierProvider<SplashNotifier, SplashState>(
  (ref) => SplashNotifier(settingsRepository),
);
