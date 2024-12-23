import 'dart:convert';
import 'package:firebase.demo.app/screens/product_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductFirebaseService {
  static final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('products');
  // ham lay du lieu theo dang Stream
  static Stream<List<ProductModel>>? get productStream {
    /// lay du lieu
    return dbRef.onValue.asBroadcastStream().map<List<ProductModel>>(
      (event) {
        // xu li du lieu tu firebase sang dart, cu the la  map<object, object> sang map<string, dynamic>
        final data = event.snapshot.value.toMap ?? {};
        // lay value trong data (lay value trong map vi minh khong can cai key)
        List<Map<String, dynamic>> values =
            data.entries.map<Map<String, dynamic>>((entry) {
          return entry.value as Map<String, dynamic>;
        }).toList();

        //dua du lieu tu List<Map<String, dynamic>> sang dang List<BookModel>
        final products = values.map((value) {
          return ProductModel.fromJson(value);
        }).toList();

        return products;
      },
    );
  }

  static void addProduct({
    required String name,
    required String id,
    required String quantity,
  }) {
    final product = {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
    dbRef.child(id).set(product);
  }

  static void editProduct({
    required String name,
    required String id,
    required String quantity,
  }) {
    final product = {
      'name': name,
      'quantity': quantity,
    };
    dbRef.child(id).update(product);
  }

  static void deleteProduct({
    required String id,
  }) {
    dbRef.child(id).remove();
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
