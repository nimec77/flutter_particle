import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_particle/nodes/models/particle_preset.dart';
import 'package:flutter_particle/nodes/particle_world.dart';
import 'package:flutter_particle/widgets/main_editor_layout.dart';
import 'package:flutter_particle/widgets/property_blend_mode.dart';
import 'package:flutter_particle/widgets/property_bool.dart';
import 'package:flutter_particle/widgets/property_color.dart';
import 'package:flutter_particle/widgets/property_color_sequence.dart';
import 'package:flutter_particle/widgets/property_double.dart';
import 'package:flutter_particle/widgets/property_texture.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticleDesigner extends StatefulWidget {
  final Size size;
  final ImageMap images;

  const ParticleDesigner({Key key, @required this.size, @required this.images})
      : assert(size != null),
        assert(images != null),
        super(key: key);

  @override
  _ParticleDesignerState createState() => _ParticleDesignerState();
}

class _ParticleDesignerState extends State<ParticleDesigner> with SingleTickerProviderStateMixin {
  ParticleWorld _particleWorld;
  TabController _tabController;
  Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    _particleWorld = ParticleWorld(size: widget.size, images: widget.images);
    _tabController = TabController(length: 5, vsync: this);
    _tabController.index = 0;
    _backgroundColor = Colors.blueGrey[700];
  }

  @override
  Widget build(BuildContext context) {
    final presets = <Widget>[];
    for (final type in ParticlePresetType.values) {
      final tile = ListTile(
        title: Text(type.toString().substring(19)),
        onTap: () {
          setState(() {
            ParticlePreset.updateParticles(_particleWorld, type, (Color bg) {
              _backgroundColor = bg;
            });
          });
        },
      );
      presets.add(tile);
    }
    final propertyEditor = Column(
      children: [
        Container(
          color: Theme.of(context).accentColor,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'PRESETS'),
              Tab(text: 'EMISSION'),
              Tab(text: 'MOVEMENT'),
              Tab(text: 'SIZE & ROTATION'),
              Tab(text: 'TEXTURE & ROTATION'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: presets,
              ),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  PropertyDouble(
                    name: 'Life',
                    value: _particleWorld.particleSystem.life,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.life = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Life variance',
                    value: _particleWorld.particleSystem.lifeVar,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.lifeVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Max particles',
                    digits: false,
                    value: _particleWorld.particleSystem.maxParticles.toDouble(),
                    minValue: 0,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.maxParticles = value.toInt();
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Emission rate',
                    value: _particleWorld.particleSystem.emissionRate,
                    minValue: 0,
                    maxValue: 200,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.emissionRate = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Num particles to emit',
                    digits: false,
                    value: _particleWorld.particleSystem.numParticlesToEmit.toDouble(),
                    minValue: 0,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.numParticlesToEmit = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  PropertyDouble(
                    name: 'Position variance x',
                    value: _particleWorld.particleSystem.posVar.dy,
                    minValue: 0,
                    maxValue: 512,
                    onUpdated: (value) {
                      setState(() {
                        final oldVar = _particleWorld.particleSystem.posVar;
                        _particleWorld.particleSystem.posVar = Offset(oldVar.dx, value);
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Gravity x',
                    value: _particleWorld.particleSystem.gravity.dy,
                    minValue: -512,
                    maxValue: 512,
                    onUpdated: (value) {
                      setState(() {
                        final oldVar = _particleWorld.particleSystem.gravity;
                        _particleWorld.particleSystem.gravity = Offset(oldVar.dx, value);
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Direction',
                    value: _particleWorld.particleSystem.direction,
                    minValue: -360,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.direction = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Direction variance',
                    value: _particleWorld.particleSystem.directionVar,
                    minValue: 0,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.directionVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Speed',
                    value: _particleWorld.particleSystem.speed,
                    minValue: 0,
                    maxValue: 250,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.speed = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Speed variance',
                    value: _particleWorld.particleSystem.speedVar,
                    minValue: 0,
                    maxValue: 250,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.speedVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Radial acceleration',
                    value: _particleWorld.particleSystem.radialAccelerationVar,
                    minValue: 0,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.radialAccelerationVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Radial acceleration variance',
                    value: _particleWorld.particleSystem.radialAccelerationVar,
                    minValue: 0,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.radialAccelerationVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Tangentail acceleration',
                    value: _particleWorld.particleSystem.tangentialAcceleration,
                    minValue: -500,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.tangentialAcceleration = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Tangentail acceleration variance',
                    value: _particleWorld.particleSystem.tangentialAccelerationVar,
                    minValue: 0,
                    maxValue: 500,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.tangentialAccelerationVar = value;
                      });
                    },
                  ),
                ],
              ),
              ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  PropertyBool(
                    name: 'Rotate to movement',
                    value: _particleWorld.particleSystem.rotateToMovement,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.rotateToMovement = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Star size',
                    value: _particleWorld.particleSystem.startSize,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.startSize = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Star size variance',
                    value: _particleWorld.particleSystem.startSizeVar,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.startSizeVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'End size',
                    value: _particleWorld.particleSystem.endSize,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.endSize = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'End size variance',
                    value: _particleWorld.particleSystem.endSizeVar,
                    minValue: 0,
                    maxValue: 10,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.endSizeVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Start rotation',
                    value: _particleWorld.particleSystem.startRotation,
                    minValue: -360,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.startRotation = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Start rotation variance',
                    value: _particleWorld.particleSystem.startRotationVar,
                    minValue: 0,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.startRotationVar = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'End rotation',
                    value: _particleWorld.particleSystem.endRotation,
                    minValue: -360,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.endRotation = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'End rotation variance',
                    value: _particleWorld.particleSystem.endRotationVar,
                    minValue: 0,
                    maxValue: 360,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.endRotationVar = value;
                      });
                    },
                  ),
                ],
              ),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  PropertyColor(
                    name: 'Background color',
                    value: _backgroundColor,
                    onUpdated: (color) {
                      setState(() {
                        _backgroundColor = color;
                      });
                    },
                  ),
                  PropertyColorSequence(
                    name: 'Color sequence',
                    value: _particleWorld.particleSystem.colorSequence,
                    onUpdated: (colorSequence) {
                      setState(() {
                        _particleWorld.particleSystem.colorSequence = colorSequence;
                      });
                    },
                  ),
                  PropertyTexture(
                    name: 'Texture',
                    value: _particleWorld.selectedTexture,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.selectedTexture = value;
                      });
                    },
                  ),
                  PropertyBlendMode(
                    name: 'Transfer Mode',
                    value: _particleWorld.particleSystem.transferMode,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.transferMode = value;
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Alpha variance',
                    digits: false,
                    value: _particleWorld.particleSystem.alphaVar.toDouble(),
                    minValue: 0,
                    maxValue: 255,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.alphaVar = value.toInt();
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Red variance',
                    digits: false,
                    value: _particleWorld.particleSystem.redVar.toDouble(),
                    minValue: 0,
                    maxValue: 255,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.redVar = value.toInt();
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Green variance',
                    digits: false,
                    value: _particleWorld.particleSystem.greenVar.toDouble(),
                    minValue: 0,
                    maxValue: 255,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.greenVar = value.toInt();
                      });
                    },
                  ),
                  PropertyDouble(
                    name: 'Blue variance',
                    digits: false,
                    value: _particleWorld.particleSystem.blueVar.toDouble(),
                    minValue: 0,
                    maxValue: 255,
                    onUpdated: (value) {
                      setState(() {
                        _particleWorld.particleSystem.blueVar = value.toInt();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    return MainEditorLayout(
      spriteDisplay: ClipRect(
        child: Container(
          key: UniqueKey(),
          color: _backgroundColor,
          child: Stack(
            children: [
              SpriteWidget(_particleWorld),
              Positioned(
                right: 16,
                bottom: 16,
                child: IconButton(
                  icon: const Icon(Icons.email),
                  color: Colors.white,
                  onPressed: () {
                    final body =
                        Uri.encodeComponent(json.encode(serializeParticleSystem(_particleWorld.particleSystem)));
                    launch('mailto:?subject=ParticleSystem&body=$body');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      propertyEditor: propertyEditor,
    );
  }
}
