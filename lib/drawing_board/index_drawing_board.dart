import 'dart:typed_data';

import 'package:drawingboard/drawingboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bacground.dart';

class IndexDrawingBoard extends StatefulWidget {
  const IndexDrawingBoard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawingBoard();
}

class _DrawingBoard extends State<IndexDrawingBoard> {
  ///绘制控制器
  final DrawingController _drawingController = DrawingController(
    ///配置
    config: DrawConfig(
      paintType: PaintType.simpleLine,
      color: Colors.red,
      thickness: 2.0,
      angle: 0,
      text: '输入文本',
    ),
  );

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

  ///获取画板数据 `getImageData()`
  Future<void> _getImageData() async {
    final Uint8List? data =
        (await _drawingController.getImageData())?.buffer.asUint8List();
    if (data == null) {
      print('获取图片数据失败');
      return;
    }
    showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return Material(
          color: Colors.transparent,
          child:
              InkWell(onTap: () => Navigator.pop(c), child: Image.memory(data)),
        );
      },
    );
  }

  /// 构建绘制层
  Widget get _buildBgPainter {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        painter: BgPainter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Drawing Test'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.check), onPressed: _getImageData)
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DrawingBoard(
              controller: _drawingController,
              background:_buildBgPainter,
                  // Container(width: 1400, height: 400, color: Colors.white),
              showDefaultActions: true,
              showDefaultTools: true,
            ),
          ),
        ],
      ),
    );
  }
}
