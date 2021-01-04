import 'package:flutter/material.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';

class PropertyBlendMode extends StatelessWidget {
  final String name;
  final BlendMode value;
  final PropertyBlendModeCallback onUpdated;

  const PropertyBlendMode({
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
    final items = <DropdownMenuItem<BlendMode>>[];
    for (final mode in BlendMode.values) {
      items.add(_buildItem(mode));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Text(name),
          Expanded(child: Container()),
          DropdownButton<BlendMode>(
            items: items,
            value: value,
            onChanged: onUpdated,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<BlendMode> _buildItem(BlendMode mode) {
    return DropdownMenuItem<BlendMode>(
      value: mode,
      child: Text('${mode.toString().substring(10, 11).toUpperCase()}${mode.toString().substring(11)}'),
    );
  }
}
