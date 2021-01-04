import 'package:flutter/material.dart';

class MainEditorLayout extends StatelessWidget {
  final Widget spriteDisplay;
  final Widget propertyEditor;

  const MainEditorLayout({
    Key key,
    @required this.spriteDisplay,
    @required this.propertyEditor,
  })  : assert(spriteDisplay != null),
        assert(propertyEditor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: spriteDisplay,
          ),
          Expanded(child: propertyEditor),
        ],
      );
    } else {
      return Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: spriteDisplay,
          ),
          Expanded(child: propertyEditor),
        ],
      );
    }
  }
}
