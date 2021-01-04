import 'package:flutter/material.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';
import 'package:flutter_particle/widgets/property_description.dart';

class PropertyDouble extends StatelessWidget {
  final String name;
  final double value;
  final double minValue;
  final double maxValue;
  final PropertyDoubleCallback onUpdated;
  final bool digits;

  const PropertyDouble({
    Key key,
    @required this.name,
    @required this.value,
    @required this.minValue,
    @required this.maxValue,
    @required this.onUpdated,
    this.digits = true,
  })  : assert(name != null),
        assert(value != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(onUpdated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PropertyDescription(
            name: name,
            value: value.toStringAsFixed(digits ? 2 : 0),
          ),
          Slider(
            value: value,
            onChanged: onUpdated,
            min: minValue,
            max: maxValue,
          ),
        ],
      ),
    );
  }
}
