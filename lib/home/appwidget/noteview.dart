import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoteViewer extends StatelessWidget {
  String title;
  String body;
  String? category;
  String? noteId;

  NoteViewer({
    Key? key,
    required this.title,
    required this.body,
    required this.noteId,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      height: (body.length < 100) ? 100 : 145,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              child: Text('   ' + title.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5)),
            ),
            SizedBox(height: 8),
            Container(
              height: (body.length < 100) ? 40 : 80,
              child: Text(
                body,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 16, letterSpacing: -0.4, color: Colors.black54),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
