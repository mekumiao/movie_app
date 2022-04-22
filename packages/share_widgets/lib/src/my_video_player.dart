import 'package:chewie/chewie.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:utils/util.dart';
import 'package:video_player/video_player.dart';

import 'my_material_controls.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({
    Key? key,
    required this.url,
    this.height,
  }) : super(key: key);

  final String url;
  final double? height;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController? _playerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.url.isNotEmpty) {
      final cookie = SpUtil.getString(Constant.cookie, defValue: '')!;
      _playerController = VideoPlayerController.network(
        widget.url,
        httpHeaders: {'Cookie': cookie},
      )
        ..setVolume(0)
        ..initialize().then((value) {
          setState(() {});
          _playerController?.play();
        });

      _chewieController = ChewieController(
        videoPlayerController: _playerController!,
        customControls: const MyMaterialControls(),
      );
    }
  }

  @override
  void dispose() {
    _playerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SizedBox(
        height: widget.height,
        child: _playerController != null
            ? _playerController!.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : const Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: Text(
                  '视频走丢了~~~',
                  style: context.isDark ? TextStyles.text : TextStyles.textDark,
                ),
              ),
      ),
    );
  }
}
