import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/model.dart';
import 'package:provider/provider.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _feedback;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _feedback = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return StreamBuilder(
        stream: _manager.getCurrentUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _name.text = snapshot.data.data()['name'];
            _email.text = snapshot.data.data()['email'];
          }
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: Text('FeedBack'),
              centerTitle: true,
              brightness: Brightness.dark,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Add a feedback'),
                              content: (_name.text.length == 0 ||
                                      _email.text.length == 0 ||
                                      _feedback.text.length == 0)
                                  ? Text(
                                      'Some values are missing can\'t add the feedback')
                                  : Text(
                                      'Thank\'s for your feedback we will make sure that we meet your needs '),
                              actions: (_name.text.length == 0 ||
                                      _email.text.length == 0 ||
                                      _feedback.text.length == 0)
                                  ? [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok I understood'))
                                    ]
                                  : [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            await _manager.addFeedBack(
                                                _name.text,
                                                _email.text,
                                                _feedback.text);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Submit'))
                                    ],
                            );
                          });
                    },
                    icon: Icon(Icons.add, size: 30)),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    // Text('Feedback'),
                    Divider(),
                    Text('''
    We are very thankful to you to use our app.
    we are too sorry if we are not able to meed your needs.
    We will be greatful if you fill this feedack form regarding your problems'''),
                    Divider(),
                    // SizedBox(height: 4),
                    TextField(
                      controller: _name,
                      decoration: InputDecoration(
                          hintText: ' Your Name',
                          icon: Icon(Icons.person),
                          labelText: 'Name',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                    Divider(),
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Email',
                          labelText: 'Email',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                    Divider(),
                    Expanded(
                        child: TextField(
                      controller: _feedback,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'You can write your feedback here....',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
