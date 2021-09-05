import 'package:flutter/gestures.dart';
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

    void addNewTag() {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets, child: NewLabel());
          });
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Welcome',
                      style: TextStyle(
                          color: SettingPage._white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1)),
                  Text(name,
                      style: TextStyle(
                          color: SettingPage._white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1)),
                  Text(email,
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5)),
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
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text('Log Out'),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                  TextButton(onPressed: addNewTag, child: Text('Add a tag')),
                  SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Scaffold(body: Text('data'))),
                        );
                      },
                      child: Text('SnackBar')),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryManager()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(Icons.category, size: 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
