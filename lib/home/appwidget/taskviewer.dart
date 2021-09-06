import 'package:flutter/material.dart';

class TaskViewer extends StatelessWidget {
  const TaskViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Tasks',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Icon(
                Icons.task,
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
