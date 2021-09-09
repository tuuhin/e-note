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
  List<Widget> _settings = [];
  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<LoggedUser?>(context)!.userdata;

    if (_value != null) {
      name = _value['name'];
      email = _value['email'];
    }
    _settings = [
      SizedBox(height: 10),
      Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      TextButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ontext) {
              return AboutPage();
            }));
          },
          label: Text('About'),
          icon: Icon(Icons.question_answer)),
      Divider(height: 1),
      TextButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ontext) {
              return FeedBackPage();
            }));
          },
          label: Text('Feedback'),
          icon: Icon(Icons.message)),
      Divider(height: 1),
      TextButton.icon(
        icon: Icon(Icons.logout, color: Colors.redAccent),
        label: Text('Log Out', style: TextStyle(color: Colors.redAccent)),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
      Divider(height: 1),
    ];

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Container(
                      // color: Colors.red,
                      child: Center(
                          child: Icon(
                        Icons.account_circle,
                        size: 70,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
                Container(
                  // color: Colors.purple,
                  width: 280,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: SettingPage._white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1)),
                        SizedBox(height: 2),
                        Text('Email: ' + email,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.5)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 10),
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
                        // height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text('    Management',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Container(
                              child: Center(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    CategoryViewer(),
                                    ProfileViewer(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 30),
                      Expanded(
                        child: ListView.builder(
                            itemCount: _settings.length,
                            itemBuilder: (BuildContext context, int i) {
                              return _settings[i];
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
