import 'package:flutter/material.dart';
import 'package:weather/pages/page.dart';

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProfilePage();
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Icon(
                Icons.account_circle_outlined,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
