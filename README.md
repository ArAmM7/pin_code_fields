<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Pin Code Text Fields

A highly customizable Flutter package for creating PIN code and OTP input fields with native-like behavior.

## Features

- Configurable PIN code field length
- Customizable styling and appearance
- Native-like cursor and input handling
- Support for obscured text (e.g., for passwords)
- Easy to use and integrate

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  pin_code_fields: ^0.0.1
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      onChanged: (value) {
        // Handle pin code changes
        print(value);
      },
      onCompleted: (value) {
        // Handle when all fields are filled
        print('Completed: $value');
      },
    );
  }
}
```

## Customization Options

```dart
PinCodeTextField(
  length: 4,  // Number of PIN code fields
  obscureText: true,  // Hide input (like password)
  pinBoxDecoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
  textStyle: TextStyle(fontSize: 20),
  cursorColor: Colors.black,
  cursorWidth: 2,
  cursorHeight: 24,
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[Add your license information here]
