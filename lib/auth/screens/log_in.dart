import 'package:flutter/material.dart';
import 'package:weather/auth/authentication.dart';
import 'package:weather/home/appwidget/customloader.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  final Function()? changeTab;
  LogIn({Key? key, this.changeTab}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String _email = '';
  bool loading = false;
  String _pword = '';
  bool hidepWord = true;

  static final Color _white = Colors.white;

  final _auth = Authentication();
  final _formkey = GlobalKey<FormState>();
  void createDialog(BuildContext context, String str) {
    String _heading = 'Login Failed';
    String _content = '';
    if (str == 'new-user') {
      _heading = 'Welcome ';
      _content = 'Welcome back Hope you have a good day!';
    } else if (str == 'user-not-found') {
      _content =
          'We are not able to find your account. Account with this credintials don\'t exists.Login with a valid account';
    } else if (str == 'wrong-password') {
      _content =
          'The credentials don\'t match please provide the correct password to login';
    } else if (str == 'invalid-email') {
      _content =
          'The provided email is not vaild .Please provide a proper email';
    } else if (str == 'network-request-failed') {
      _content =
          'Is there a issue with the internet connection.Plz try a bit afterwards.Your connection don\'t seems well';
    } else {
      _content =
          'There is some problem that we are too unaware of Plz try again latter';
    }
    AlertDialog _alert = AlertDialog(
      title: Text(_heading),
      content: Text(_content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok I understand'))
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xff31255a),
        body: loading
            ? CustomLoader()
            : Stack(children: [
                Positioned(
                  child: SvgPicture.asset(
                    'assets/in.svg',
                    fit: BoxFit.cover,
                  ),
                  top: 0,
                ),
                Positioned(
                  child: Text(
                    'Welcome \nBack',
                    style: TextStyle(
                        color: _white,
                        fontSize: mediaWidth * 0.1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  bottom: mediaHeight * 0.5,
                  left: 30,
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  child: Container(
                    height: mediaHeight * 0.5,
                    width: mediaWidth * 0.83,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val != null) {
                                return val.isEmpty ? 'enter a email' : null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _email = val;
                              });
                            },
                            style: TextStyle(color: _white),
                            decoration: InputDecoration(
                              icon: Icon(Icons.email, color: _white),
                              hintText: 'Your Email',
                              hintStyle: TextStyle(color: _white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                            ),
                          ),
                          TextFormField(
                            obscuringCharacter: '*',
                            obscureText: hidepWord,
                            validator: (val) {
                              if (val != null) {
                                return val.length < 6 ? 'minimum 6 char' : null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _pword = val;
                              });
                            },
                            style: TextStyle(color: _white),
                            decoration: InputDecoration(
                              icon: Icon(Icons.pin, color: _white),
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidepWord = !hidepWord;
                                    });
                                  },
                                  color: _white,
                                  icon: hidepWord
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              hintText: ' Password',
                              hintStyle: TextStyle(color: _white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                            ),
                          ),
                          SizedBox(height: mediaHeight * 0.05),
                          ElevatedButton(
                            child: Text('Log in'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(mediaWidth - 60, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                String current =
                                    await _auth.signWithEmail(_email, _pword);
                                if (current != 'new-user') {
                                  setState(() {
                                    loading = false;
                                  });
                                  createDialog(context, current);
                                }
                              } else {
                                print('error');
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          Divider(
                            height: 20,
                            color: _white,
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            child: Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(mediaWidth - 60, 50),
                              primary: Color(0x00ffffff),
                              elevation: 0,
                              side: BorderSide(width: 2, color: _white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: widget.changeTab,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]));
  }
}
