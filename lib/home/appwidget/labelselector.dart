import 'package:flutter/material.dart';
import 'package:weather/home/appwidget/appwidget.dart';

class LabelSelector extends StatelessWidget {
  const LabelSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.blueAccent,
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            PickedLabel(
                                'hellow', Colors.orangeAccent, Colors.pink),
                            PickedLabel(
                                'hellow', Colors.orangeAccent, Colors.pink),
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
