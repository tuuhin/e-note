import 'package:flutter/material.dart';
import 'package:weather/home/appwidget/appwidget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                              padding: MediaQuery.of(context).viewInsets,
                              child: UpdateSheet(
                                title: 'Enter Your name',
                                update: () {
                                  print('hellow');
                                },
                              ),
                            );
                          });
                    },
                    child: ChangeData(
                        headIcon: Icons.person,
                        value: 'tuhin',
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
                              padding: MediaQuery.of(context).viewInsets,
                              child: UpdateSheet(
                                title: 'Add About.',
                                update: () {
                                  print('hellow');
                                },
                              ),
                            );
                          });
                    },
                    child: ChangeData(
                        headIcon: Icons.info,
                        value: 'hellow ' * 10,
                        editable: true,
                        head: 'About'),
                  ),
                  Divider(height: 30),
                  ChangeData(
                      headIcon: Icons.email,
                      value: 'tuhinbhowmick2513@gmail.com',
                      editable: false,
                      head: 'Email')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
