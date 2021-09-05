import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/home/appwidget/appwidget.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/model.dart';

class NewLabel extends StatefulWidget {
  NewLabel({Key? key}) : super(key: key);

  @override
  _NewLabelState createState() => _NewLabelState();
}

class _NewLabelState extends State<NewLabel> {
  Color _textColor = Colors.black;

  Color _backgroundColor = Colors.white;
  String _text = 'example';

  TextEditingController _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Color(4282339765),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' Create a Tag!'),
            SizedBox(height: 10),
            TextField(
              controller: _labelController,
              onSubmitted: (t) {
                setState(() {
                  _text = t;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your new label',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Text('Design'),
            Container(
              height: 40,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Choose a foreground color!'),
                                content: MaterialColorPicker(
                                  onColorChange: (color) {
                                    print(color.value);
                                    setState(() {
                                      _textColor = color;
                                    });
                                  },
                                  selectedColor: Colors.red,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done'))
                                ],
                              );
                            });
                      },
                      child: Text('text color',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ))),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text('Choose a  background color!'),
                                content: MaterialColorPicker(
                                  onColorChange: (color) {
                                    setState(() {
                                      _backgroundColor = color;
                                    });
                                  },
                                  selectedColor: Colors.red,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done'))
                                ],
                              );
                            });
                      },
                      child: Text(
                        'background color',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      )),
                  LabelView(
                      label: _text,
                      textColor: _textColor,
                      backgroundColor: _backgroundColor)
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    print(uid);

                    await _manager.addNewLable(_labelController.text,
                        _textColor.value, _backgroundColor.value);

                    Navigator.of(context).pop();
                  },
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50),
                    primary: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Discard'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50),
                    primary: Colors.white10,
                    elevation: 0,
                    side: BorderSide(width: 2, color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
