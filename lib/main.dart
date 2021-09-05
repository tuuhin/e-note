import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather/auth/authentication.dart';
import 'package:weather/model/model.dart';
import 'package:weather/pages/page.dart';
import 'package:weather/partition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return StreamProvider<CurrentUser?>.value(
      value: _auth.currentUser,
      initialData: CurrentUser(uid: null),
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => Partition(),
          '/note': (context) => NotePage(),
          '/update-note': (context) => NoteUpdater(),
        },
        initialRoute: '/',
      ),
    );
  }
}
