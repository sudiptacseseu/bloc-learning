import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'counter_plugin_platform_interface.dart';

/// An implementation of [CounterPluginPlatform] that uses method channels.
class MethodChannelCounterPlugin extends CounterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('counter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
