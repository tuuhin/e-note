import 'package:flutter/material.dart';
import 'package:weather/pages/page.dart';

class NoteUpdater extends StatelessWidget {
  const NoteUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // print(arg);
    return NotePage(
      title: arg['title'],
      body: arg['body'],
      category: arg['category'],
      noteId: arg['note_id'],
    );
  }
}
