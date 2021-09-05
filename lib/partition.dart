import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/auth/logger.dart';
import 'package:weather/home/appscrs/openscreen.dart';

import 'package:weather/model/user.dart';

class Partition extends StatelessWidget {
  const Partition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<CurrentUser?>(context)!.uid;
    if (value != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: OpenScreen(),
      );
    } else {
      return Logger();
    }
  }
}
