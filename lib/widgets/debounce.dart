import 'package:flutter/foundation.dart';
import 'dart:async';

class DebouncerClass {
  int? milliseconds;
  VoidCallback? action;
  Timer? _timer;
  DebouncerClass({this.milliseconds});
  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds ?? 0), action);
  }
}
