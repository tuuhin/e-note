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
            body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                controller: _tabs,
                children: [
                  HomeScreen(),
                  SettingPage(),
                ]),
            // bottomNavigationBar: BottomAppBar(
            //   clipBehavior: Clip.hardEdge,
            //   // elevation: 5,
            //   child: Container(
            //     height: 55,
            //     color: Colors.grey[50],
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 50,
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           IconButton(
            //             iconSize: 30,
            //             onPressed: () {
            //               _tabs.animateTo(0);
            //             },
            //             icon: Icon(Icons.home),
            //           ),
            //           IconButton(
            //             iconSize: 30,
            //             onPressed: () {
            //               _tabs.animateTo(1);
            //             },
            //             icon: Icon(Icons.menu),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   notchMargin: 16.0,
            //   shape: CircularNotchedRectangle(),
            // ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (t) {
                // print(t);
                if (t == 0) {
                  _tabs.animateTo(0);
                }
                if (t == 1) {
                  _tabs.animateTo(1);
                }
              },
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.black45,
              selectedItemColor: Colors.black45,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'Settings')
              ],
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
              child: Icon(Icons.add, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
