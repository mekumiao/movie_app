import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utils/util.dart';

/// design/9暂无状态页面/index.html#artboard3
class EmptyLayout extends StatelessWidget {
  const EmptyLayout({
    Key? key,
    this.type = EmptyType.empty,
    this.isLoding,
    this.hintText,
  }) : super(key: key);

  final EmptyType type;
  final bool? isLoding;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (isLoding == true)
          const CupertinoActivityIndicator(radius: 16.0)
        else if (type != EmptyType.empty)
          Opacity(
            opacity: context.isDark ? 0.5 : 1,
            child: Image.asset(
              'assets/zwwl.png',
              width: 120,
              package: 'share_widgets',
            ),
          ),
        const SizedBox(
          width: double.infinity,
          height: Dimens.gap_dp16,
        ),
        Text(
          hintText ?? type.hintText,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum EmptyType {
  /// 订单
  order,

  /// 商品
  goods,

  /// 无网络
  network,

  /// 消息
  message,

  /// 无提现账号
  account,

  /// 空
  empty
}

extension StateTypeExtension on EmptyType {
  String get img => <String>['zwdd', 'zwsp', 'zwwl', 'zwxx', 'zwzh', ''][index];

  String get hintText => <String>['暂无订单', '暂无商品', '无网络连接', '暂无消息', '马上添加提现账号吧', '空空如也~'][index];
}
