import 'package:flutter/services.dart';

class HidScannerDetector {
  final Duration maxGap;
  final int minLength;
  final _buffer = StringBuffer();
  DateTime? _lastTime;

  HidScannerDetector({
    this.maxGap = const Duration(milliseconds: 150),
    this.minLength = 4,
  });

  String? processKey(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return null;
    }

    final now = DateTime.now();
    if (_lastTime != null && now.difference(_lastTime!) > maxGap) {
      _buffer.clear();
    }
    _lastTime = now;

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      final code = _buffer.toString().trim();
      _buffer.clear();
      return code.length >= minLength ? code : null;
    }

    if (event.character != null) {
      _buffer.write(event.character);
    }
    return null;
  }
}
