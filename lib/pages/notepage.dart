import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/model.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final String? title;
  final String? body;
  final String? category;
  final String? noteId;
  NotePage({Key? key, this.title, this.body, this.category, this.noteId})
      : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _title = TextEditingController();

  TextEditingController _body = TextEditingController();

  String _currentCategory = '';

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);

    if (widget.title != null) {
      _title.text = '${widget.title}';
    }
    if (widget.body != null) {
      _body.text = '${widget.body}';
    }

    List<Widget> actionUpdate = [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: IconButton(
          tooltip: 'Update Note',
          icon: Icon(Icons.update, size: 30),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Update Note'),
                    content: RichText(
                        text: TextSpan(
                            text: 'Updating the current note titled:\n',
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: '${widget.title}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))
                        ])),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                      TextButton(
                          onPressed: () async {
                            await _manager.updateOldNote(
                                _title.text, _body.text, widget.noteId);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Update')),
                    ],
                  );
                });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5, right: 20, left: 5),
        child: IconButton(
          tooltip: 'Delete Note',
          icon: Icon(Icons.delete_forever, size: 30),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Note'),
                    content: RichText(
                        text: TextSpan(
                            text: 'Deleting the current note titled:\n',
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: '${widget.title}\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: 'warning:',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                            text:
                                'This note will be permanently deleted and could not be recycled latter',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                      TextButton(
                          onPressed: () async {
                            await _manager.deleteOldNote(
                                widget.noteId, widget.category);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Delete',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ],
                  );
                });
          },
        ),
      )
    ];
    List<Widget> actionAdd = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add a new  Note'),
                    content: (_title.text.length > 0 && _body.text.length > 0)
                        ? RichText(
                            text: TextSpan(
                                text: 'Adding new note titled:\n',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                children: [
                                TextSpan(
                                    text: '${_title.text}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600))
                              ]))
                        : Text(
                            'Either title or body don\'t contain any character\'s \nTry adding some characters'),
                    actions: (_title.text.length > 0 && _body.text.length > 0)
                        ? [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () async {
                                  await _manager.addNewNote(_title.text,
                                      _body.text, _currentCategory);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                                // Navigator.of(context).pop();
                                ,
                                child: Text('Add'))
                          ]
                        : [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ok I understood'))
                          ],
                  );
                });
          },
          child: Text('Add',
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0,
            fixedSize: Size(25, 10),
            side: BorderSide(width: 2, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      )
    ];
    // void labelSelector() {
    //   showModalBottomSheet(
    //       backgroundColor: Colors.transparent,
    //       context: context,
    //       builder: (context) {
    //         return LabelSelector();
    //       });
    // }

    return FutureBuilder(
        future: _manager.getCurrentCategory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<String> _wid = snapshot.data;
            // print(snapshot.data);
            if (_currentCategory == '') {
              _currentCategory = _wid[0];
            }
            return Scaffold(
              backgroundColor: Colors.blue,
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: AppBar(
                  brightness: Brightness.dark,
                  centerTitle: true,
                  elevation: 0,
                  title: (widget.category != null)
                      ? Text(
                          '${widget.category}',
                          style: TextStyle(fontSize: 25),
                        )
                      : DropdownButton(
                          dropdownColor: Colors.black12,
                          isExpanded: true,
                          hint: Text('categoryy'),
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 20,
                          ),
                          underline: Container(),
                          icon: Icon(
                            Icons.expand_more,
                            // color: Colors.white,
                            size: 25,
                          ),
                          iconEnabledColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentCategory = newValue!;
                            });
                          },
                          value: _currentCategory,
                          items: _wid
                              .map<DropdownMenuItem<String>>(
                                  (String v) => DropdownMenuItem<String>(
                                        value: v,
                                        child: Center(
                                          child: Text(
                                            v,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ))
                              .toList(),
                        ),
                  actions: (widget.category != null) ? actionUpdate : actionAdd,
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextField(
                      controller: _title,
                      autofocus: (widget.category == null) ? true : false,
                      style: TextStyle(fontSize: 20),
                      cursorWidth: 3,
                      cursorHeight: 25,
                      keyboardType: TextInputType.name,
                      cursorRadius: Radius.circular(20),
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(fontSize: 16),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _body,
                        cursorWidth: 3,
                        autofocus: (widget.category != null) ? true : false,
                        cursorHeight: 25,
                        cursorRadius: Radius.circular(20),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(
                            wordSpacing: 1.5,
                            letterSpacing: -0.2,
                            fontSize: 17),
                        decoration: InputDecoration(
                            hintText: 'Body',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
