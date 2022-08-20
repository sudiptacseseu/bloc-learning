
import 'package:counter_plugin/cubit/counter_cubit.dart';

import 'counter_plugin_platform_interface.dart';

class CounterPlugin {
  static final CounterCubit _counterBloc = CounterCubit();
  Future<String?> getPlatformVersion() {
    return CounterPluginPlatform.instance.getPlatformVersion();
  }

  static CounterCubit get counterBloc => _counterBloc;

  static CounterCubit buildPlugin() {
    return _counterBloc;
  }
}
