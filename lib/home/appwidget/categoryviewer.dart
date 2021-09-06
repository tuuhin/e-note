import 'package:flutter/material.dart';
import 'package:weather/pages/page.dart';

class CategoryViewer extends StatelessWidget {
  const CategoryViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CategoryManager()));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Icon(
                Icons.category_outlined,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
