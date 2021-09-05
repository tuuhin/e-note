import 'package:flutter/material.dart';
import 'package:weather/auth/screens/screens.dart';

class Logger extends StatefulWidget {
  Logger({Key? key}) : super(key: key);

  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Home(
            changeLogTab: () {
              _tabController.animateTo(1);
            },
            changeSignTab: () {
              _tabController.animateTo(2);
            },
          ),
          LogIn(
            changeTab: () {
              _tabController.animateTo(2);
            },
          ),
          SignUp(
            changeTab: () {
              _tabController.animateTo(1);
            },
          )
        ],
      ),
    );
  }
}
