import 'package:flutter/material.dart';
import 'package:weather/auth/dbmanager.dart';
import 'package:weather/home/appwidget/appwidget.dart';
import 'package:weather/model/model.dart';
import 'package:provider/provider.dart';

class CategoryManager extends StatelessWidget {
  CategoryManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<CurrentUser?>(context)!.uid;
    DataManager _manager = DataManager(uid);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: CategoryEditor(),
                    );
                  });
            },
            icon: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            tooltip: 'Add category',
          ),
          SizedBox(
            width: 30,
          )
        ],
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: ClipRect(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: StreamBuilder(
              stream: _manager.currentcatergories,
              builder: (BuildContext context,
                  AsyncSnapshot<CategoryModel?> snapshot) {
                if (snapshot.hasData) {
                  List<CategoryCard> _card = [];
                  snapshot.data!.currentcatergory.forEach(
                    (e) => _card.add(
                      CategoryCard(
                          noteId: e.id,
                          category: e.data()['label'],
                          colorcode: e.data()['color'],
                          note: e.data()['note_count']),
                    ),
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              '    Your Categories',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(height: 10),
                            Divider(height: 10),
                            Text(
                                'You can delete or update your categories here \nTo add a new one tap on the + Button '),
                            Divider(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            itemCount: _card.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: GestureDetector(
                                  child: _card[i],
                                  onDoubleTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: CategoryEditor(
                                              category: _card[i].category,
                                              note: _card[i].note,
                                              noteId: _card[i].noteId,
                                              colorcode: _card[i].colorcode,
                                            ),
                                          );
                                        });
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
