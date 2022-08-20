import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_plugin/counter_plugin_method_channel.dart';

void main() {
  MethodChannelCounterPlugin platform = MethodChannelCounterPlugin();
  const MethodChannel channel = MethodChannel('counter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
