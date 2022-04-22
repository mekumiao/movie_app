import 'package:cached_network_image/cached_network_image.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:utils/util.dart';

/// 缓存图片
class MyCachedNetworkImage extends StatelessWidget {
  const MyCachedNetworkImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    final _image = Image.asset(
      'assets/none.png',
      height: height,
      width: width,
      fit: fit,
      package: 'share_widgets',
    );
    if (url.isNotEmpty && url.startsWith('http')) {
      final cookie = SpUtil.getString(Constant.cookie, defValue: '')!;
      return CachedNetworkImage(
        imageUrl: url,
        httpHeaders: {'Cookie': cookie},
        placeholder: (_, __) => _image,
        errorWidget: (_, __, dynamic error) => _image,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else {
      return _image;
    }
  }
}
