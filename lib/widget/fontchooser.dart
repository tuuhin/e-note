import 'package:flutter/material.dart';

class LabelSelector extends StatelessWidget {
  LabelSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pinkAccent,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.format_bold),
                    label: Text('Bold')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.format_italic),
                    label: Text('Italic')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.format_underline),
                    label: Text('Underline'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
