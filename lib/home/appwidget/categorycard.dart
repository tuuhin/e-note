import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? category;
  final int? colorcode;
  final int? note;
  final String? noteId;

  CategoryCard({
    Key? key,
    this.category,
    this.note,
    this.colorcode,
    this.noteId,
  }) : super(key: key);
  static final Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(colorcode ?? 0xffa49b45), blurRadius: 10)
            ],
            color: Color(colorcode ?? 0xffa49b45),
            // color: Color(colorcode ?? 0xffa49b45),
            borderRadius: BorderRadius.circular(20)),
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              '$category'.toUpperCase(),
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: _color,
                  letterSpacing: 1.8),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white24),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description,
                      color: Colors.white70,
                    ),
                    Text(
                      '  $note',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
