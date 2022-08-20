import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'counter_plugin_method_channel.dart';

abstract class CounterPluginPlatform extends PlatformInterface {
  /// Constructs a CounterPluginPlatform.
  CounterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static CounterPluginPlatform _instance = MethodChannelCounterPlugin();

  /// The default instance of [CounterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelCounterPlugin].
  static CounterPluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CounterPluginPlatform] when
  /// they register themselves.
  static set instance(CounterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
