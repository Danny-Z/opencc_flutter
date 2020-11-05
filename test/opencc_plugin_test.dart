import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencc_plugin/opencc_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('opencc_plugin');

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
    expect(await OpenccPlugin.platformVersion, '42');
  });
}
