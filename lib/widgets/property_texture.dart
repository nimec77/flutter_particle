import 'package:flutter/material.dart';
import 'package:flutter_particle/constants.dart';
import 'package:flutter_particle/nodes/models/function_def.dart';

class PropertyTexture extends StatelessWidget {
  final String name;
  final int value;
  final PropertyIntCallback onUpdated;

  const PropertyTexture({
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
    final items = <DropdownMenuItem<int>>[];
    for (int i = 0; i < kTextureNames.length; i++) {
      items.add(_buildItem(i));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Text(name),
          Expanded(
            child: Container(),
          ),
          DropdownButton<int>(
            items: items,
            value: value,
            onChanged: onUpdated,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<int> _buildItem(int mode) {
    return DropdownMenuItem<int>(
      value: mode,
      child: Text(kTextureNames[mode]),
    );
  }
}
