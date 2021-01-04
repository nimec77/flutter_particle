import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class ParticleWorld extends NodeWithSize {
  final ImageMap images;

  ParticleSystem _particleSystem;

  ParticleSystem get particleSystem => _particleSystem;

  int _selectedTexture = 5;

  int get selectedTexture => _selectedTexture;

  set selectedTexture(int texture) {
    _particleSystem.texture = SpriteTexture(images['assets/particle-$texture.png']);
    _selectedTexture = texture;
  }

  ParticleWorld({@required Size size, @required this.images})
      : assert(size != null),
        assert(images != null),
        super(size) {
    userInteractionEnabled = true;
    final texture = SpriteTexture(images['assets/particle-$_selectedTexture.png']);

    _particleSystem = ParticleSystem(
      texture,
      autoRemoveOnFinish: false,
    );

    _particleSystem.position = size.center(Offset.zero);
    _particleSystem.insertionOffset = Offset.zero;
    addChild(_particleSystem);
  }

  @override
  bool handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent || event.type == PointerMoveEvent) {
      _particleSystem.insertionOffset = convertPointToNodeSpace(event.boxPosition) - size.center(Offset.zero);
    }

    if (event.type == PointerDownEvent) {
      _particleSystem.reset();
    }

    return true;
  }
}
