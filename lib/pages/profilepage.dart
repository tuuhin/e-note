import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/home/appwidget/appwidget.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/model.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _name;
  late TextEditingController _about;
  late TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _about = TextEditingController();
    _email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return StreamBuilder(
        stream: _manager.getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          double mediaHeight = MediaQuery.of(context).size.height;
          double mediaWidth = MediaQuery.of(context).size.width;
          List<Widget> _profiledataHolders = [
            SizedBox(height: mediaHeight * 0.06),
            TextField(
              readOnly: true,
              controller: _name,
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: UpdateSheet(
                          title: 'Enter your name',
                          mode: 'name',
                          previousData: snapshot.data.data()['name'],
                        ),
                      );
                    });
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
            ),
            Divider(height: 30),
            TextField(
              readOnly: true,
              controller: _about,
              maxLines: 3,
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
                          mode: 'about',
                          previousData: snapshot.data.data()['about'],
                        ),
                      );
                    });
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  icon: Icon(Icons.info),
                  labelText: 'About',
                  focusedBorder: null,
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
            ),
            Divider(height: 30),
            TextField(
              readOnly: true,
              controller: _email,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  // suffixIcon: Icon(Icons.edit_off),
                  labelText: 'Email',
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
            )
          ];
          if (snapshot.hasData) {
            _name.text = snapshot.data.data()['name'];
            _about.text = snapshot.data.data()['about'];
            _email.text = snapshot.data.data()['email'];
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                title: Text('Profile'),
                centerTitle: true,
                elevation: 0,
                brightness: Brightness.dark,
              ),
              body: Container(
                  height: mediaHeight,
                  width: mediaWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.builder(
                      itemCount: _profiledataHolders.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: _profiledataHolders[i],
                        );
                      })),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
