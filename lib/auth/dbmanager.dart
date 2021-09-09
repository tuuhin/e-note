import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/model/model.dart';
import 'package:intl/intl.dart';

class DataManager {
  String? uid;
  DataManager(this.uid);
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  Future createUserData(String name, String email) async {
    Set newUser = {
      {'label': 'Uncategorized', 'color': 4288423856, 'note_count': 0},
      {'label': 'Personal', 'color': 4280825235, 'note_count': 0},
      {'label': 'Work', 'color': 4294826037, 'note_count': 0},
      {'label': 'Class', 'color': 4284301367, 'note_count': 0},
      {'label': 'Sports', 'color': 4278221163, 'note_count': 0},
    };

    try {
      await _firestore.doc(uid).set({
        'name': name,
        'about': ' ',
        'email': email,
        'date': FieldValue.serverTimestamp(),
      });
      for (var i in newUser) {
        await _firestore.doc(uid).collection('category').add(i);
      }
      print('done');
    } catch (e) {
      print(e);
    }
  }

  Future updateUserName(String name) async {
    try {
      await _firestore.doc(uid).update({
        'name': name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateAbout(String about) async {
    try {
      await _firestore.doc(uid).update({
        'about': about,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream getCurrentUserData() {
    return _firestore.doc(uid).snapshots();
  }

  Future addNewLable(String head, int foreground, int background) async {
    try {
      await _firestore.doc(uid).collection('label').add({
        'label_header': head,
        'foreground': foreground,
        'background': background
      });
      print('added');
    } catch (e) {
      print(' error  ${e.toString()}');
    }
  }

  Future<String> addNewNote(String title, String body, String category) async {
    try {
      await _firestore.doc(uid).collection('note').add({
        'title': toBeginningOfSentenceCase(title),
        'body': toBeginningOfSentenceCase(body),
        'category': category,
        'created': FieldValue.serverTimestamp(),
      });

      await _firestore
          .doc(uid)
          .collection('category')
          .get()
          .then((value) => value.docs.forEach((element) {
                if (element.data()['label'] == category) {
                  // print(element.data()['label']);
                  print(element.id);
                  _firestore
                      .doc(uid)
                      .collection('category')
                      .doc(element.id)
                      .update({'note_count': element.data()['note_count'] + 1})
                      .then((value) => print('done'))
                      .catchError((e) => print(e));
                }
              }));

      return 'ok';
    } catch (e) {
      print(e.toString());
      return 'notok';
    }
  }

  Future<String> updateOldNote(
      String title, String body, String? noteId) async {
    // print(noteId);
    if (noteId != null) {
      try {
        await _firestore
            .doc(uid)
            .collection('note')
            .doc(noteId)
            .update({'title': title, 'body': body}).catchError((e) => print(e));
        print('updated');
        return 'updated';
      } catch (e) {
        print(e.toString());
        return 'failed';
      }
    } else {
      return 'failed';
    }
  }

  Future updatecategory(String? noteId, String? category, int? colorcode,
      String? oldcategory) async {
    try {
      await _firestore
          .doc(uid)
          .collection('category')
          .doc(noteId)
          .update({'label': category, 'color': colorcode});
      await _firestore
          .doc(uid)
          .collection('note')
          .get()
          .then((value) => value.docs.forEach((element) {
                if (element.data()['category'] == oldcategory) {
                  _firestore
                      .doc(uid)
                      .collection('note')
                      .doc(element.id)
                      .update({'category': category})
                      .then((value) => print('done'))
                      .catchError((e) => print(e));
                }
              }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> addNewCategory(String? category, int? colorcode) async {
    List _currentcategories = [];
    await _firestore
        .doc(uid)
        .collection('category')
        .get()
        .then((value) => value.docs.forEach((element) {
              _currentcategories.add(element.data()['label']);
            }));
    bool _exists = _currentcategories.contains(category);
    if (!_exists) {
      try {
        await _firestore.doc(uid).collection('category').add({
          'label': category,
          'note_count': 0,
          'color': colorcode,
          'date': FieldValue.serverTimestamp()
        });
        return true;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }
    return false;
  }

  Future deleteCategory(String? noteId, String? category) async {
    try {
      await _firestore.doc(uid).collection('category').doc(noteId).delete();
      print('deleted');
      await _firestore
          .doc(uid)
          .collection('note')
          .get()
          .then((value) => value.docs.forEach((element) {
                if (element.data()['category'] == category) {
                  _firestore
                      .doc(uid)
                      .collection('note')
                      .doc(element.id)
                      .delete();
                }
              }));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> deleteOldNote(String? noteId, String? category) async {
    // print(noteId);
    if (noteId != null && category != null) {
      await _firestore
          .doc(uid)
          .collection('category')
          .get()
          .then((value) => value.docs.forEach((element) {
                if (element.data()['label'] == category) {
                  // print(element.data()['label']);
                  print(element.id);
                  _firestore
                      .doc(uid)
                      .collection('category')
                      .doc(element.id)
                      .update({'note_count': element.data()['note_count'] - 1})
                      .then((value) => print('done'))
                      .catchError((e) => print(e));
                }
              }));
      await _firestore
          .doc(uid)
          .collection('note')
          .doc(noteId)
          .delete()
          .catchError((e) => print(e));
      return 'deleted';
    } else {
      return 'failed';
    }
  }

  LoggedUser _loggedUser(DocumentSnapshot snapshot) {
    return LoggedUser(userdata: snapshot.data());
    // if (snapshot != null) {
    //   return LoggedUser(snapshot: snapshot.data());
    // } else {
    //   return LoggedUser(snapshot: null);
    // }
  }

  Stream<LoggedUser> get loggedUser {
    //  _firestore.doc(uid).collection('note').snapshots().forEach((e) {
    //   e.docs.forEach((element) {
    //     print(element.data());
    //   });
    // });
    return _firestore.doc(uid).snapshots().map(_loggedUser);
  }

  CategoryModel _currentcategory(QuerySnapshot snapshot) {
    return CategoryModel(currentcatergory: snapshot.docs);
  }

  Stream<CategoryModel> get currentcatergories {
    // _firestore.doc(uid).collection('category').snapshots();

    return _firestore
        .doc(uid)
        .collection('category')
        .snapshots()
        .map(_currentcategory);
  }

  NoteModel _currentnote(QuerySnapshot snapshot) {
    return NoteModel(currentnotes: snapshot.docs);
  }

  Stream<NoteModel> get currentnotes {
    // _firestore.doc(uid).collection('category').snapshots();

    return _firestore.doc(uid).collection('note').snapshots().map(_currentnote);
  }

  Future getCurrentCategory() async {
    List<String> data = [];
    await _firestore
        .doc(uid)
        .collection('category')
        .get()
        .then((value) => value.docs.forEach((element) {
              data.add(element.data()['label']);
            }));
    return data;
  }

  Future addFeedBack(String name, String email, String feedback) async {
    try {
      await FirebaseFirestore.instance
          .collection('feedback')
          .add({'name': name, 'email': email, 'feedback': feedback});
    } catch (e) {
      print(e.toString());
    }
  }
}
