import 'dart:io';

import 'package:design/design.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/gen/assets.gen.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({
    Key? key,
    required this.url,
    required this.currentVersionName,
    required this.versionName,
    required this.remark,
  }) : super(key: key);

  final String url;
  final String currentVersionName;
  final String versionName;
  final String remark;

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                    image: DecorationImage(
                      image: Assets.images.updateHead,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                      color: context.dialogBackgroundColor,
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('版本更新', style: TextStyles.textSize16),
                      Gaps.vGap10,
                      Text('${widget.currentVersionName} > ${widget.versionName}'),
                      Gaps.vGap10,
                      Text(
                        widget.remark,
                        maxLines: 10,
                      ),
                      Gaps.vGap15,
                      if (_isDownload)
                        LinearProgressIndicator(
                          backgroundColor: Colours.line,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          value: _value,
                        )
                      else
                        _buildButton(context),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildButton(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: '残忍拒绝',
            fontSize: Dimens.font_sp16,
            textColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
            side: BorderSide(
              color: primaryColor,
              width: 0.8,
            ),
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: '立即更新',
            fontSize: Dimens.font_sp16,
            onPressed: () {
              if (Device.isAndroid) {
                setState(() {
                  _isDownload = true;
                });
                _download();
              } else {
                showToast('自动更新仅在Android系统上受支持');
              }
            },
            textColor: Colors.white,
            backgroundColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
          ),
        )
      ],
    );
  }

  String getApiHost() {
    return SpUtil.getString(Constant.apiHost, defValue: Constant.defaultApiHost)!;
  }

  ///下载apk
  Future<void> _download() async {
    try {
      final saveDir = await getApkSaveDir();
      final apkSavePath = '$saveDir/movie.apk';
      final File file = File(apkSavePath);
      await Dio().download(
        widget.url,
        file.path,
        cancelToken: _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            _value = count / total;
            setState(() {});
            if (count == total) {
              Navigator.maybePop(context);
              onClickInstallApk(apkSavePath);
            }
          }
        },
      );
    } catch (e) {
      showToast('下载失败!');
      setState(() {
        _isDownload = false;
      });
    }
  }

  Future<String> getApkSaveDir() async {
    final storageDir = await getExternalStorageDirectory();
    final dirPath = storageDir?.path ?? '/';
    return '$dirPath/Downloads';
  }

  Future<void> onClickInstallApk(String apkPath) async {
    if (File(apkPath).existsSync()) {
      await OpenFile.open(apkPath);
    } else {
      showToast('apk下载失败');
    }
  }
}
