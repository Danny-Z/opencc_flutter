import 'package:opencc_plugin/opencc_plugin.dart';

class OpenCC {
  static Future<String> tw2s(String str) async {
    if (str == null || str.isEmpty) {
      return str;
    }
    return OpenccPlugin.convert(str, config: OpenccConfig.tw2s);
  }

  static Future<String> tw2sp(String str) async {
    if (str == null || str.isEmpty) {
      return str;
    }
    return OpenccPlugin.convert(str, config: OpenccConfig.tw2sp);
  }

  static Future<String> s2twp(String str) async {
    if (str == null || str.isEmpty) {
      return str;
    }
    return OpenccPlugin.convert(str, config: OpenccConfig.s2twp);
  }

  static Future<String> s2hk(String str) async {
    if (str == null || str.isEmpty) {
      return str;
    }
    return OpenccPlugin.convert(str, config: OpenccConfig.s2hk);
  }
}
