import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  final Function()? changeLogTab;
  final Function()? changeSignTab;
  const Home({Key? key, this.changeLogTab, this.changeSignTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        color: Color(0xff44416d),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset('assets/home.svg'),
              top: 0,
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E Note\'s',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create note\'s with a different manner\nAnd make those available with just a login.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: changeLogTab,
                    child: Text('Log In'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(300, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: changeSignTab,
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 50),
                      primary: Color(0x00ffffff),
                      elevation: 0,
                      side: BorderSide(width: 2, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
