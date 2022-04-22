import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/util.dart';

import 'empty_layout.dart';

typedef VoidFutureCallBack = Future<void> Function();

/// 封装下拉刷新与加载更多
class MyRefreshView extends StatefulWidget {
  const MyRefreshView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.onLoadMore,
    this.hasMore = false,
    this.emptyType = EmptyType.empty,
    this.pageSize = 10,
    this.padding,
    this.itemExtent,
    this.controller,
    // this.primary,
  }) : super(key: key);

  final VoidFutureCallBack onRefresh;
  final VoidFutureCallBack? onLoadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final EmptyType emptyType;
  final ScrollController? controller;

  final int pageSize;
  // final bool? primary;

  /// padding属性使用时注意会破坏原有的SafeArea，需要自行计算bottom大小
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;

  @override
  MyRefreshViewState createState() => MyRefreshViewState();
}

class MyRefreshViewState extends State<MyRefreshView> {
  final _key = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final Widget child = RefreshIndicator(
      key: _key,
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        controller: widget.controller,
        physics: const AlwaysScrollableScrollPhysics(),
        // shrinkWrap: true,
        // primary: widget.primary,
        itemCount: widget.onLoadMore != null
            ? widget.itemCount + 1
            : widget.itemCount == 0
                ? 1
                : widget.itemCount,
        padding: widget.padding,
        itemExtent: widget.itemExtent,
        itemBuilder: (BuildContext context, int index) {
          if (widget.itemCount == 0) {
            return SizedBox(
              height: 250,
              child: Center(child: EmptyLayout(type: widget.emptyType)),
            );
          } else if (widget.onLoadMore == null) {
            return widget.itemBuilder(context, index);
          } else if (index < widget.itemCount) {
            return widget.itemBuilder(context, index);
          } else {
            return MoreWidget(widget.hasMore);
          }
        },
      ),
    );
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification note) {
          /// 确保是垂直方向滚动，且滑动至底部
          if (note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: child,
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.hasMore) {
      await widget.onLoadMore?.call();
    }
  }

  Future<void> refresh() async {
    if (widget.controller != null) {
      widget.controller!.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    } else {
      await PrimaryScrollController.of(context)
          ?.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    }
    await _key.currentState?.show();
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.hasMore, {Key? key}) : super(key: key);

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.isDark ? TextStyles.textGray14 : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: hasMore
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CupertinoActivityIndicator(),
                Gaps.hGap5,
                Text('正在加载中...', style: style),
              ],
            )
          : Gaps.empty,
    );
  }
}
