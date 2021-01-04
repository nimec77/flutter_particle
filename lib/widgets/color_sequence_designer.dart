import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';
import 'package:flutter_particle/widgets/color_sequence_well.dart';
import 'package:spritewidget/spritewidget.dart';

class ColorSequenceDesigner extends StatefulWidget {
  final ColorSequence colorSequence;
  final ColorSequenceDesignerCallback onChange;

  const ColorSequenceDesigner({Key key, @required this.colorSequence, @required this.onChange})
      : assert(colorSequence != null),
        assert(onChange != null),
        super(key: key);

  @override
  _ColorSequenceDesignerState createState() => _ColorSequenceDesignerState();
}

class _ColorSequenceDesignerState extends State<ColorSequenceDesigner> {
  static const int _numMaxStops = 4;

  ColorSequence _colorSequence;
  final _colors = <Color>[]..length = 4;
  final _stops = <double>[]..length = 4;

  @override
  void initState() {
    super.initState();

    final numColors = widget.colorSequence.colors.length;
    for (int i = 0; i < numColors; i++) {
      _colors[i] = widget.colorSequence.colors[i];
      _stops[i] = widget.colorSequence.colorStops[i];
    }

    _updateColorSequence();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    children.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ColorSequenceWell(colorSequence: _colorSequence),
      ),
    );

    for (int i = 0; i < _numMaxStops; i++) {
      final int stopNum = i;

      children.add(
        Row(
          children: [
            Checkbox(
              value: _colors[stopNum] != null,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _addColorStop(stopNum);
                  } else {
                    _removeColorStop(stopNum);
                  }
                });
              },
            ),
            Expanded(
              child: Slider(
                value: _stops[stopNum] ?? 0,
                onChanged: (value) {
                  setState(() {
                    _updateStop(stopNum, value);
                  });
                },
                max: _stops[stopNum] != null ? 1 : 0,
              ),
            ),
            Container(
              width: 50,
              height: 30,
              color: _colors[stopNum] ?? Colors.grey,
              child: GestureDetector(
                onTap: () => _pickColor(stopNum),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  void _updateStop(int stop, double value) {
    for (int i = 0; i < stop; i++) {
      if (_stops[i] != null && _stops[i] > value) {
        _stops[i] = value;
      }
    }

    _stops[stop] = value;

    for (int i = stop + 1; i < _numMaxStops; i++) {
      if (_stops[i] != null && _stops[i] < value) {
        _stops[i] = value;
      }
    }

    _updateColorSequence();
  }

  void _addColorStop(int stopNum) {
    int firstStop = _numMaxStops - 1;
    int lastStop = 0;
    for (int i = 0; i < _numMaxStops; i++) {
      if (_colors[i] != null && i < firstStop) {
        firstStop = i;
      }
      if (_colors[i] != null && i > lastStop) {
        lastStop = i;
      }
    }

    if (stopNum < firstStop) {
      _stops[stopNum] = 0.0;
    } else if (stopNum > lastStop) {
      _stops[stopNum] = 1.0;
    } else {
      int prevStop = 0;
      for (int i = stopNum - 1; i >= 0; i--) {
        if (_stops[i] != null) {
          prevStop = i;
          break;
        }
      }

      int nextStop = _numMaxStops - 1;
      for (int i = stopNum + 1; i < _numMaxStops; i++) {
        if (_stops[i] != null) {
          nextStop = i;
          break;
        }
      }
      _stops[stopNum] = (_stops[prevStop] + _stops[nextStop]) / 2.0;
    }

    _colors[stopNum] = Colors.black;

    _updateColorSequence();
  }

  void _removeColorStop(int stopNum) {
    int numStops = 0;
    for (int i = 0; i < _numMaxStops; i++) {
      if (_stops[i] != null) {
        numStops += 1;
      }
    }

    if (numStops <= 1) {
      return;
    }

    _stops[stopNum] = null;
    _colors[stopNum] = null;

    _updateColorSequence();
  }

  void _pickColor(int stopNum) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Color stop'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _colors[stopNum],
                onColorChanged: (color) {
                  setState(() {
                    _colors[stopNum] = color;
                    _updateColorSequence();
                  });
                },
                showLabel: false,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('DONE'),
              ),
            ],
          );
        });
    _updateColorSequence();
  }

  void _updateColorSequence() {
    final colors = <Color>[];
    final stops = <double>[];

    for (int i = 0; i < _numMaxStops; i++) {
      if (_colors[i] != null) {
        colors.add(_colors[i]);
        stops.add(_stops[i]);
      }
    }

    _colorSequence = ColorSequence(colors, stops);

    if (widget.onChange != null) {
      return widget.onChange(_colorSequence);
    }
  }
}
