import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/model.dart';
import 'package:provider/provider.dart';

class CategoryEditor extends StatefulWidget {
  final String? category;
  final int? colorcode;
  final int? note;
  final String? noteId;
  CategoryEditor(
      {Key? key, this.category, this.colorcode, this.note, this.noteId})
      : super(key: key);

  @override
  _CategoryEditorState createState() => _CategoryEditorState();
}

class _CategoryEditorState extends State<CategoryEditor> {
  TextEditingController _ctrl = TextEditingController();

  Color _newColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Select a color for the card'),
                          content: MaterialColorPicker(
                            onColorChange: (color) {
                              print(color.value);
                              setState(() {
                                _newColor = color;
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
                icon: Icon(Icons.colorize, color: _newColor),
                label: Text(
                    (widget.category != null)
                        ? 'Change the card color'
                        : ' Chose a color for the card',
                    style: TextStyle(color: _newColor))),
            TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                  hintText: (widget.category != null)
                      ? 'Change the name of the category'
                      : 'Name of the category'),
            ),
            SizedBox(height: 20),
            (widget.category != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Deleting the category'),
                                  content: Text(
                                      'Deleteing the curent category \n${widget.category}\nDeleting this will delete all your notes of the current category\nAre you Sure? '),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () {}, child: Text('Delete'))
                                  ],
                                );
                              });
                        },
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            fixedSize: Size(150, 50),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Update category'),
                                  content: _ctrl.text.length == 0
                                      ? Text(
                                          'Cannot update the category name no new name found')
                                      : Text(
                                          'updating the current category to ${_ctrl.text} from ${widget.category} '),
                                  actions: _ctrl.text.length != 0
                                      ? [
                                          TextButton(
                                              onPressed: () {
                                                // print(_newColor.value);
                                                // Navigator.of(context).pop();
                                                // Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                await _manager.updatecategory(
                                                    widget.noteId,
                                                    _ctrl.text,
                                                    _newColor.value,
                                                    widget.category);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok'))
                                        ]
                                      : [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok! I understood'))
                                        ],
                                );
                              });
                        },
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            fixedSize: Size(150, 50),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      )
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(_ctrl.text.length != 0
                                    ? 'new Category'
                                    : 'Cannot add the new category no new name found'),
                                content: Text(_ctrl.text.length != 0
                                    ? 'Add category ${_ctrl.text} Now you can make notes categorixed as this category'
                                    : 'We appolize but we need some name to add the category'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('cancell')),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        bool added =
                                            await _manager.addNewCategory(
                                                _ctrl.text, _newColor.value);
                                        print(added ? 'added' : 'failed');
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ok'))
                                ],
                              );
                            });
                      },
                      child: Text('Add a new category'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          fixedSize: Size(300, 50),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
