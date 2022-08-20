import 'package:flutter_test/flutter_test.dart';
import 'package:counter_plugin/counter_plugin.dart';
import 'package:counter_plugin/counter_plugin_platform_interface.dart';
import 'package:counter_plugin/counter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCounterPluginPlatform 
    with MockPlatformInterfaceMixin
    implements CounterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CounterPluginPlatform initialPlatform = CounterPluginPlatform.instance;

  test('$MethodChannelCounterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCounterPlugin>());
  });

  test('getPlatformVersion', () async {
    CounterPlugin counterPlugin = CounterPlugin();
    MockCounterPluginPlatform fakePlatform = MockCounterPluginPlatform();
    CounterPluginPlatform.instance = fakePlatform;
  
    expect(await counterPlugin.getPlatformVersion(), '42');
  });
}
