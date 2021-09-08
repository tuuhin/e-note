import 'package:flutter/material.dart';

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
                            : Text('giu'),
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
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text('Feedback'),
              Divider(),
              Text('''
We are very thankful to you to use our app.
we are too sorry if we are not able to meed your needs.
We will be greatful if you fill this feedack form regarding your problems'''),
              Divider(),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
              Divider(),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
              Divider(),
              Expanded(
                  child: TextField(
                controller: _feedback,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'FeedBack',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
