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
            "columna2": doc["ahorro"],
            "columna3": doc["luz"],
            "columna4": doc["internet"],
            "columna5": doc["agua"],
            "columna1": doc["semana"],
            "columna7": doc["estado"],
            "columna8": doc["celular"],
            "columna9": doc["diversion"]
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
