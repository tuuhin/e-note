import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/model/model.dart';

class ChangeData extends StatelessWidget {
  final IconData headIcon;
  final String value;
  final String head;
  final bool editable;
  ChangeData({
    Key? key,
    required this.headIcon,
    required this.value,
    required this.editable,
    required this.head,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(headIcon, color: Theme.of(context).primaryColor),
        SizedBox(width: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(head,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600)),
                Container(
                    width: editable ? 200 : 230,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ))
              ],
            ),
            SizedBox(width: 20),
            editable
                ? Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )
                : SizedBox(),
          ],
        )
      ],
    );
  }
}

class UpdateSheet extends StatelessWidget {
  UpdateSheet({
    Key? key,
    required this.title,
    this.mode,
  }) : super(key: key);
  final String title;
  final String? mode;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              TextField(
                controller: _controller,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      )),
                  TextButton(
                    onPressed: () async {
                      if (mode == 'name') {
                        await _manager.updateUserName(_controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Update',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
