import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/home/appwidget/appwidget.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/model.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return StreamBuilder(
        stream: _manager.getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                  title: Text('Profile'), centerTitle: true, elevation: 0),
              body: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: UpdateSheet(
                                          title: 'Enter your name',
                                          mode: 'name',
                                          previousData:
                                              snapshot.data.data()['name'],
                                        ),
                                      );
                                    });
                              },
                              child: ChangeData(
                                  headIcon: Icons.person,
                                  value: snapshot.data.data()['name'],
                                  editable: true,
                                  head: 'Name'),
                            ),
                            Divider(height: 30),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: UpdateSheet(
                                          title: 'Add About.',
                                          mode: 'about',
                                          previousData:
                                              snapshot.data.data()['about'],
                                        ),
                                      );
                                    });
                              },
                              child: ChangeData(
                                  headIcon: Icons.info,
                                  value: snapshot.data.data()['about'],
                                  editable: true,
                                  head: 'About'),
                            ),
                            Divider(height: 30),
                            ChangeData(
                                headIcon: Icons.email,
                                value: snapshot.data.data()['email'],
                                editable: false,
                                head: 'Email')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
