/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesHomeGen get home => const $AssetsImagesHomeGen();

  /// File path: assets/images/ic_arrow_right.png
  AssetGenImage get icArrowRight => const AssetGenImage('assets/images/ic_arrow_right.png');

  /// File path: assets/images/ic_back_black.png
  AssetGenImage get icBackBlack => const AssetGenImage('assets/images/ic_back_black.png');

  $AssetsImagesLoginGen get login => const $AssetsImagesLoginGen();

  /// File path: assets/images/message.png
  AssetGenImage get message => const AssetGenImage('assets/images/message.png');

  /// File path: assets/images/none.png
  AssetGenImage get none => const AssetGenImage('assets/images/none.png');

  /// File path: assets/images/search.png
  AssetGenImage get search => const AssetGenImage('assets/images/search.png');

  /// File path: assets/images/setting.png
  AssetGenImage get setting => const AssetGenImage('assets/images/setting.png');

  /// File path: assets/images/update_head.jpg
  AssetGenImage get updateHead => const AssetGenImage('assets/images/update_head.jpg');
}

class $AssetsImagesHomeGen {
  const $AssetsImagesHomeGen();

  /// File path: assets/images/home/icon_commodity.png
  AssetGenImage get iconCommodity => const AssetGenImage('assets/images/home/icon_commodity.png');

  /// File path: assets/images/home/icon_order.png
  AssetGenImage get iconOrder => const AssetGenImage('assets/images/home/icon_order.png');

  /// File path: assets/images/home/icon_shop.png
  AssetGenImage get iconShop => const AssetGenImage('assets/images/home/icon_shop.png');

  /// File path: assets/images/home/icon_statistics.png
  AssetGenImage get iconStatistics => const AssetGenImage('assets/images/home/icon_statistics.png');
}

class $AssetsImagesLoginGen {
  const $AssetsImagesLoginGen();

  /// File path: assets/images/login/qyg_shop_icon_delete.png
  AssetGenImage get qygShopIconDelete => const AssetGenImage('assets/images/login/qyg_shop_icon_delete.png');

  /// File path: assets/images/login/qyg_shop_icon_display.png
  AssetGenImage get qygShopIconDisplay => const AssetGenImage('assets/images/login/qyg_shop_icon_display.png');

  /// File path: assets/images/login/qyg_shop_icon_hide.png
  AssetGenImage get qygShopIconHide => const AssetGenImage('assets/images/login/qyg_shop_icon_hide.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
