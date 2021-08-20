import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection("Date").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "ahorro": doc["ahorro"],
            "luz": doc["luz"],
            "internet": doc["internet"],
            "agua": doc["agua"],
            "semana": doc["semana"],
            "estado": doc["estado"],
            "celular": doc["celular"],
            "diversion": doc["diversion"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }
}
