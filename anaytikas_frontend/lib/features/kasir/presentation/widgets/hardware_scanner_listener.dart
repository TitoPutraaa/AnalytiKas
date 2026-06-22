import 'package:anaytikas_frontend/core/shared/services/hid_scanner_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HardwareScannerListener extends StatefulWidget {
  final Widget child;
  final ValueChanged<String> onScan;
  const HardwareScannerListener({
    super.key,
    required this.child,
    required this.onScan,
  });

  @override
  State<HardwareScannerListener> createState() =>
      _HardwareScannerListenerState();
}

class _HardwareScannerListenerState extends State<HardwareScannerListener> {
  final _detector = HidScannerDetector();

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent e) {
    final code = _detector.processKey(e);
    if (code != null) {
      widget.onScan(code);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
