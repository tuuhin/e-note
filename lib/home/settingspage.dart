import 'package:flutter/material.dart';
import 'package:weather/auth/authentication.dart';
import 'package:provider/provider.dart';
import 'package:weather/home/appwidget/appwidget.dart';

import 'package:weather/model/loggeruser.dart';
import 'package:weather/model/model.dart';
import 'package:weather/pages/page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);
  static final Color _white = Colors.white;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Authentication _auth = Authentication();

  String name = '';

  String email = '';

  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<LoggedUser?>(context)!.userdata;

    if (_value != null) {
      name = _value['name'];
      email = _value['email'];
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('  ',
                      style: TextStyle(
                          color: SettingPage._white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              color: SettingPage._white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1)),
                      SizedBox(height: 2),
                      Text('Email: ' + email,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.5)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Management',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Container(
                            child: Center(
                              child: Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: [
                                  CategoryViewer(),
                                  TaskViewer(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(height: 10),
                    Column(
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.logout),
                          label: Text('Log Out'),
                          onPressed: () async {
                            await _auth.signOut();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
