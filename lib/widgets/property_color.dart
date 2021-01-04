import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';

class PropertyColor extends StatelessWidget {
  final String name;
  final Color value;
  final PropertyColorCallback onUpdated;

  const PropertyColor({
    Key key,
    @required this.name,
    @required this.value,
    @required this.onUpdated,
  })  : assert(name != null),
        assert(value != null),
        assert(onUpdated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Text(name),
          Expanded(
            child: Container(),
          ),
          Container(
            width: 50,
            height: 30,
            color: value,
            child: GestureDetector(
              onTap: () {
                _openColorPickerDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openColorPickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Background color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: value,
                onColorChanged: onUpdated,
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
  }
}
