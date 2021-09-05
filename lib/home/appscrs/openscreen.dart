import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/home/homescreen.dart';
import 'package:weather/home/settingspage.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/loggeruser.dart';
import 'package:weather/model/model.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  _OpenScreenState createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  void initState() {
    super.initState();
    _tabs = TabController(
      length: 2,
      vsync: this,
    );
  }

  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<CurrentUser?>(context)!.uid;

    DataManager _manager = DataManager(value);
    return StreamProvider<NoteModel?>.value(
      initialData: NoteModel(),
      value: _manager.currentnotes,
      child: StreamProvider<CategoryModel?>.value(
        initialData: CategoryModel(),
        value: _manager.currentcatergories,
        child: StreamProvider<LoggedUser?>.value(
          initialData: LoggedUser(userdata: null),
          value: _manager.loggedUser,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: TabBarView(controller: _tabs, children: [
              HomeScreen(),
              SettingPage(),
            ]),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        _tabs.animateTo(0);
                      },
                      icon: Icon(Icons.home),
                    ),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        _tabs.animateTo(1);
                      },
                      icon: Icon(Icons.menu),
                    ),
                  ],
                ),
              ),
              notchMargin: 16.0,
              shape: CircularNotchedRectangle(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/note',
                );
              },
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
