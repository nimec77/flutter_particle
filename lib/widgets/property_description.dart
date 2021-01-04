import 'package:flutter/material.dart';

class PropertyDescription extends StatelessWidget {
  final String name;
  final String value;

  const PropertyDescription({Key key, @required this.name, @required this.value})
      : assert(name != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(name),
          Expanded(
            child: Container(),
          ),
          Text(value),
        ],
      ),
    );
  }
}
