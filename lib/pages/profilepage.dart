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
    return FutureBuilder(
        future: _manager.getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Profile'), centerTitle: true),
              body: Container(
                // color: Colors.purple,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.pinkAccent,
                        )),
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
                                  isScrollControlled: false,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewPadding,
                                      child: UpdateSheet(
                                        title: 'Enter your name',
                                        mode: 'name',
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
