import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:weather/home/appwidget/appwidget.dart';
import 'package:weather/model/model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryCard> _card = [];
    List<NoteViewer> _note = [];
    var category = Provider.of<CategoryModel?>(context)!.currentcatergory;
    // print(category);
    if (category != null) {
      category!.forEach((e) => _card.add(
            CategoryCard(
              category: e.data()['label'],
              note: e.data()['note_count'],
              colorcode: e.data()['color'],
            ),
          ));
    }
    var note = Provider.of<NoteModel?>(context)!.currentnotes;
    if (note != null) {
      note!.forEach((e) {
        _note.add(NoteViewer(
            title: e.data()['title'],
            body: e.data()['body'],
            category: e.data()['category'],
            noteId: e.id));
      });
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: _card.length > 0
                ? Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _card[index]);
                    },
                    itemCount: _card.length,
                    pagination: SwiperPagination(
                        builder: SwiperPagination.dots,
                        margin: EdgeInsets.zero),
                    viewportFraction: 0.95,
                    scale: 0.8,
                  )
                : Center(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          CustomLoader(),
                          Divider(height: 5),
                          Text(
                            'Loading',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 5),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
                child: (note != null)
                    ? (_note.length != 0)
                        ? ListView.builder(
                            itemCount: _note.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: (i != 0)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6)
                                    : const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 6),
                                child: GestureDetector(
                                  child: _note[i],
                                  onDoubleTap: () {
                                    print('${_note[i].title}');
                                    Navigator.of(context)
                                        .pushNamed('/update-note', arguments: {
                                      'title': _note[i].title,
                                      'body': _note[i].body,
                                      'category': _note[i].category,
                                      'note_id': _note[i].noteId,
                                    });
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Container(
                            height: 100,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.format_list_bulleted,
                                  size: 50,
                                  color: Colors.black45,
                                ),
                                Text('No notes found ',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ))
                    : Center(
                        child: Container(
                          height: 80,
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Divider(height: 10),
                              Text(
                                'Loading',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
