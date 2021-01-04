import 'package:flutter/material.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';

class PropertyBool extends StatelessWidget {
  final String name;
  final bool value;
  final PropertyBoolCallback onUpdated;

  const PropertyBool({
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
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Text(name),
          Expanded(child: Container()),
          Checkbox(value: value, onChanged: onUpdated),
        ],
      ),
    );
  }
}
