import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utils/util.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    this.url,
    this.heroTag,
    this.size = 80.0,
    this.remark,
    this.onSelected,
  }) : super(key: key);

  final String? url;
  final String? heroTag;
  final double size;
  final String? remark;
  final void Function(String path)? onSelected;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  XFile? pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        widget.onSelected?.call(pickedFile!.path);
        if (Device.isWeb) {
          _imageProvider = NetworkImage(pickedFile!.path);
        } else {
          _imageProvider = FileImage(File(pickedFile!.path));
        }
      } else {
        _imageProvider = null;
      }
      setState(() {});
    } catch (e) {
      if (e is MissingPluginException) {
        showToast('当前平台暂不支持！');
      } else {
        showToast('没有权限，无法打开相册！');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorFilter colorFilter = ColorFilter.mode(
        ThemeUtils.isDark(context) ? Colours.dark_unselected_item_color : Colours.text_gray, BlendMode.srcIn);

    Widget image = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        // 图片圆角展示
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: _imageProvider ?? _buildImageProvider(widget.url),
          fit: BoxFit.cover,
          colorFilter: _imageProvider == null && widget.url?.isEmpty == true ? colorFilter : null,
        ),
      ),
    );

    if (widget.heroTag != null && !Device.isWeb) {
      image = Hero(tag: widget.heroTag!, child: image);
    }

    return Column(
      children: [
        Semantics(
          label: '选择图片',
          hint: '跳转相册选择图片',
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: _getImage,
            child: image,
          ),
        ),
        Gaps.vGap5,
        Center(
          child: Text(
            widget.remark ?? '',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
          ),
        )
      ],
    );
  }

  ImageProvider _buildImageProvider(String? url) {
    if (url == null || url.isEmpty == true) {
      return const AssetImage('assets/ic_add.png', package: 'share_widgets');
    } else {
      return CachedNetworkImageProvider(url);
    }
  }
}
