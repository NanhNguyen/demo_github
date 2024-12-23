import 'dart:convert';

import 'package:firebase.demo.app/screens/book_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final DatabaseReference dbRef = FirebaseDatabase.instance.ref('books');
  // ham lay du lieu theo dang Stream
  static Stream<List<BookModel>>? get booksStream {
    /// lay du lieu
    return dbRef.onValue.asBroadcastStream().map<List<BookModel>>(
      (event) {
        // xu li du lieu tu firebase sang dart, cu the la  map<object, object> sang map<string, dynamic>
        final data = event.snapshot.value.toMap ?? {};
        // lay value trong data (lay value trong map vi minh khong can cai key)
        List<Map<String, dynamic>> values =
            data.entries.map<Map<String, dynamic>>((entry) {
          return entry.value as Map<String, dynamic>;
        }).toList();

        //dua du lieu tu List<Map<String, dynamic>> sang dang List<BookModel>
        final books = values.map((value) {
          return BookModel.fromJson(value);
        }).toList();

        return books;
      },
    );
  }

  static void addBook({
    required int id,
    required String name,
    required String type,
  }) {
    final book = {
      'id': id,
      'name': name,
      'type': type,
    };
    dbRef.push().set(book);
  }
}

// viet ham mo rong (extension) cho thang Object?
extension ObjectEX on Object? {
  // get: lay ve du lieu kieu map<string dynamic>
  Map<String, dynamic>? get toMap {
    // this o day = value o dong 14
    if (this == null) return null;
    Map<String, dynamic> data = Map<String, dynamic>.from(this as Map);
    // dua map ve dang string vi co dau ""
    String jsonString = json.encode(data);
    //decode thi xoa dau "" de dua data sang dang map
    Map<String, dynamic> jsonConvert = json.decode(jsonString);
    return jsonConvert;
  }
}
