import 'package:flutter/material.dart';
import 'package:weather/home/appwidget/appwidget.dart';

class PickedLabel extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  PickedLabel(
    this.text,
    this.textColor,
    this.backgroundColor, {
    Key? key,
  }) : super(key: key);

  @override
  _PickedLabelState createState() => _PickedLabelState();
}

class _PickedLabelState extends State<PickedLabel> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: _checked,
                  onChanged: (t) {
                    setState(() {
                      _checked = !_checked;
                    });
                  }),
              LabelView(
                label: widget.text,
                textColor: widget.textColor,
                backgroundColor: widget.backgroundColor,
              )
            ],
          )),
    );
  }
}
