import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utils/util.dart';

/// 双击返回退出
class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Widget child;

  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null || DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      showToast('再按一次退出', duration: Duration(milliseconds: widget.duration.inMilliseconds));
      return Future.value(false);
    }
    dismissAllToast();
    await SystemNavigator.pop();
    return Future.value(true);
  }
}
