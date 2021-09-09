import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/model.dart';

class UpdateSheet extends StatefulWidget {
  UpdateSheet({
    Key? key,
    required this.title,
    this.mode,
    this.previousData,
  }) : super(key: key);
  final String title;
  final String? mode;
  final String? previousData;

  @override
  _UpdateSheetState createState() => _UpdateSheetState();
}

class _UpdateSheetState extends State<UpdateSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.previousData ?? '',
    );
    _controller.selection =
        TextSelection(baseOffset: 0, extentOffset: widget.previousData!.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: _controller,
                maxLength: (widget.mode == 'name') ? 25 : 125,
                decoration: InputDecoration(
                    labelText: (widget.mode == 'name')
                        ? 'Enter your Name'
                        : 'Add a about.'),
              ),
              // SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      )),
                  TextButton(
                    onPressed: () async {
                      if (widget.mode == 'name') {
                        if (_controller.text.length == 0) {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Failed'),
                                  content: Text(
                                      'Failed to add the new name as the new name contaain no characters'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok! I understood'))
                                  ],
                                );
                              });
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Update name'),
                                content: Text((_controller.text ==
                                        widget.previousData)
                                    ? 'The current name ${widget.previousData} and the new name ${_controller.text} are same only.\nYou may not update this ,On updating nothing will change'
                                    : 'Updaing the current name ${widget.previousData} to new name ${_controller.text} .\nAre you Sure'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await _manager
                                            .updateUserName(_controller.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Update'))
                                ],
                              );
                            },
                          );
                        }
                        // await _manager.updateUserName(_controller.text);

                      } else if (widget.mode == 'about') {
                        if (_controller.text.length == 0) {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Failed'),
                                  content: Text(
                                      'Failed to add the new about as the new about contain no characters'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok! I understood'))
                                  ],
                                );
                              });
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Update About'),
                                content: Text((_controller.text ==
                                        widget.previousData)
                                    ? 'The current about ${widget.previousData} and the new about ${_controller.text} are same only.\nYou may not update this ,On updating nothing will change'
                                    : 'Updaing the current about ${widget.previousData} to new about ${_controller.text} .\nAre you Sure'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await _manager
                                            .updateAbout(_controller.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Update'))
                                ],
                              );
                            },
                          );
                        }
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Update',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
