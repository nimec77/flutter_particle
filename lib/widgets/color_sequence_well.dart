import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class ColorSequenceWell extends StatelessWidget {
  final ColorSequence colorSequence;
  final VoidCallback onTap;

  static const String _baseEncodedImage =
      'iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAIAAADZF8uwAAAAGUlEQVQYV2M4gwH+YwCGIasIUwhT25BVBADtzYNYrHvv4gAAAABJRU5ErkJggg==';
  final Uint8List _chessTexture = base64.decode(_baseEncodedImage);

  ColorSequenceWell({Key key, @required this.colorSequence, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: colorSequence.colors,
      stops: colorSequence.colorStops,
    );
    return SizedBox(
      height: 30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(_chessTexture),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: gradient,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: onTap != null ? InkWell(onTap: onTap) : Container(),
          ),
        ],
      ),
    );
  }
}
