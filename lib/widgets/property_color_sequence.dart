import 'package:flutter/material.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';
import 'package:flutter_particle/widgets/color_sequence_designer.dart';
import 'package:flutter_particle/widgets/color_sequence_well.dart';
import 'package:spritewidget/spritewidget.dart';

class PropertyColorSequence extends StatefulWidget {
  final String name;
  final ColorSequence value;
  final PropertyColorSequenceCallback onUpdated;

  const PropertyColorSequence({
    Key key,
    @required this.name,
    @required this.value,
    @required this.onUpdated,
  }) : super(key: key);

  @override
  _PropertyColorSequenceState createState() => _PropertyColorSequenceState();
}

class _PropertyColorSequenceState extends State<PropertyColorSequence> {
  ColorSequence _newColorSequence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.name),
          ),
          ColorSequenceWell(
            colorSequence: widget.value,
            onTap: () {
              _openColorSequenceDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _openColorSequenceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Color sequence'),
            content: SingleChildScrollView(
              child: ColorSequenceDesigner(
                colorSequence: widget.value,
                onChange: (colorSequence) {
                  _newColorSequence = colorSequence;
                },
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onUpdated(_newColorSequence);
                },
                child: const Text('DONE'),
              ),
            ],
          );
        });
  }
}
