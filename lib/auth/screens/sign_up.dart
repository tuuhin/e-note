import 'package:flutter/material.dart';
import 'package:weather/auth/authentication.dart';
import 'package:weather/widget/customloader.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  final Function()? changeTab;
  SignUp({Key? key, this.changeTab}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = '';
  String _name = '';
  bool loading = false;
  String _pword = '';
  bool hidepWord = true;

  static final Color _white = Colors.white;

  final _auth = Authentication();

  final _formkey = GlobalKey<FormState>();

  void createDialog(BuildContext context, String str) {
    String _heading = 'Sign-In error';
    String _content = '';
    if (str == 'new-user') {
      _heading = 'Welcome';
      _content =
          'Sir/Madam we welcome you to E-Note an note app for maintaing your notes . We promise to deliver your valueable notes with just a simple login in any phones';
    } else if (str == 'email-already-in-use') {
      _content =
          'We are extremly sorry you can\'t use this email. This is currently in use to another user .If it\'s not you plz provide a new email';
    } else if (str == 'invalid-email') {
      _content =
          'The provided email is not vaild .Please provide a proper email';
    } else if (str == 'weak-password') {
      _content =
          'It\'s seems like you have enter a weak password .A strong password keeps you safe .Plz provide a strng password';
    } else if (str == 'network-request-failed') {
      _content =
          'Is there a issue with the internet connection.Plz try a bit afterwards.Your connection don\'t seems well';
    } else {
      print(str);
      _content =
          'There is some problem that we are too unaware of Plz try again latter';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_heading),
            content: Text(_content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok I understood'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff31255a),
        body: loading
            ? CustomLoader()
            : Stack(children: [
                Positioned(
                  child: SvgPicture.asset('assets/up.svg'),
                  top: 0,
                ),
                Positioned(
                  child: Text(
                    'Create \nAccount',
                    style: TextStyle(
                        color: _white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  bottom: 380,
                  left: 30,
                ),
                Positioned(
                  bottom: 10,
                  left: 30,
                  child: Container(
                    height: 370,
                    width: 300,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val != null) {
                                return val.isEmpty ? 'Enter your name' : null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _name = val;
                              });
                            },
                            style: TextStyle(color: _white),
                            decoration: InputDecoration(
                              hintText: 'Name',
                              icon: Icon(Icons.person, color: _white),
                              hintStyle: TextStyle(color: _white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                            ),
                          ),
                          // SizedBox(height: 5),
                          TextFormField(
                            validator: (val) {
                              if (val != null) {
                                return val.isEmpty ? 'Enter a email' : null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _email = val;
                              });
                            },
                            style: TextStyle(color: _white),
                            decoration: InputDecoration(
                              hintText: 'Your Email',
                              icon: Icon(Icons.email, color: _white),
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
                              suffix: IconButton(
                                  iconSize: 20,
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
                              icon: Icon(Icons.pin, color: _white),
                              hintStyle: TextStyle(color: _white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: _white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            child: Text('Sign In'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                String current = await _auth.registerWithEmail(
                                    _email, _pword, _name);
                                if (current != 'new-user') {
                                  // print(current);
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
                            height: 10,
                            color: _white,
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            child: Text('Log In'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 50),
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
