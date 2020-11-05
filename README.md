# opencc_plugin

[copy from flutter_opencc](https://pub.dartlang.org/packages/flutter_opencc) 添加 bundle， 和异步执行转换

> Conversion between Traditional and Simplified Chinese using [opencc](https://github.com/BYVoid/OpenCC)

简繁体相互转换

## Getting Started

```yaml
dependencies:
  opencc_plugin: ^0.0.1
```

### Usage

```dart
import 'package:opencc_plugin/opencc_plugin.dart';

String results;
// Platform messages may fail, so we use a try/catch PlatformException.
try {
    results = await OpenccPlugin.convert(
    """鼠标里面的硅二极管坏了，导致光标分辨率降低。
我们在老挝的服务器的硬盘需要使用互联网算法软件解决异步的问题。
为什么你在床里面睡着？""",
    );
} on PlatformException {
    results = 'Failed to convert.';
}

print(results);

```

