import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);
  final List _aboutMe = [
    {
      'title': 'Easy to Use',
      'body':
          'With simple functionality it\'s very simple to maintain your notes'
    },
    {'title': 'Helpful', 'body': 'It\'s easy to maintain'},
    {'title': 'Security', 'body': 'Your notes are secure here'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        brightness: Brightness.dark,
        elevation: 0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 5),
              Text(
                  'Welcome to E-Note\nThis is a note app where we hwlp our user to manager there important notes'),
              Divider(height: 5),
              Container(
                height: 300,
                child: ListView.builder(
                    itemCount: _aboutMe.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        leading: Icon(Icons.donut_large),
                        title: Text(_aboutMe[i]['title']),
                        subtitle: Text(_aboutMe[i]['body']),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
