import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:planz/Models/dates.dart';
import 'package:planz/Orders/placeOrderPayment.dart';
import 'package:planz/firebase/readdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableTest extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TableTest> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  DataBase db;
  List docs = [];
  initialise() {
    db = DataBase();
    db.initiliase();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  @override
  void initState() {
    // user.initData(100);
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLAN Z"),
      ),
      body: _getBodyWidget(db),
    );
  }

  Widget _getBodyWidget(DataBase dataBase) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 1000,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: docs.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    String columna2 = "Titulo";
    String columna3 = "Titulo";
    String columna4 = "Titulo";
    String columna5 = "Titulo";
    String columna6 = "Titulo";
    String columna7 = "Titulo";
    String columna8 = "Titulo";
    String columna9 = "Titulo";
    String columna10 = "Titulo";

    TextEditingController _columna2TextEditingController =
        TextEditingController();
    return [
      TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: _getTitleItemWidget('Fecha', 100),
          onPressed: () {}),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            columna2 +
                (sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {},
      ),
      _getTitleItemWidget('Diversion', 100),
      _getTitleItemWidget('Internet', 100),
      _getTitleItemWidget('Celular', 100),
      _getTitleItemWidget('Luz', 100),
      _getTitleItemWidget('otro1', 100),
      _getTitleItemWidget('otro2', 100),
      _getTitleItemWidget('otro3', 100),
      _getTitleItemWidget('otro4', 100),
      _getTitleItemWidget('otro5', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return InkWell(
      onTap: () {
        print(label);
      },
      child: Container(
        child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        width: width,
        height: 56,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, index) {
    DateTime myDateTime = (docs[index]["semana"].toDate());
    return InkWell(
      onTap: () {
        print(DateFormat.yMMMd().format(myDateTime));
      },
      child: Container(
        child: Text(
          DateFormat.yMMMd().format(myDateTime),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            print(docs[index]["estado"]);
          },
          child: Container(
            child: Row(
              children: <Widget>[Text(docs[index]["estado"].toString())],
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            print(docs[index]["diversion"]);
          },
          child: Container(
            child: Text(docs[index]["diversion"].toString()),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            print(docs[index]["internet"]);
          },
          child: Container(
            child: Text(docs[index]["internet"].toString()),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            print(docs[index]["celular"]);
          },
          child: Container(
            child: Text(docs[index]["celular"].toString()),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            print(docs[index]["luz"]);
          },
          child: Container(
            child: Text(docs[index]["luz"].toString()),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

// User user = User();

// class User {
//   List<DataBase> docs = [];

//   void initData(int size) {
//     for (int i = 0; i < size; i++) {
//       docs
//           .add(DataBase(docs[index]["semana"]));
//     }
//   }

//   ///
//   /// Single sort, sort Name's id
//   void sortName(bool isAscending) {
//     docs.sort((a, b) {
//       int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
//       int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
//       return (aId - bId) * (isAscending ? 1 : -1);
//     });
//   }

//   ///
//   /// sort with Status and Name as the 2nd Sort
//   void sortStatus(bool isAscending) {
//     userInfo.sort((a, b) {
//       if (a.status == b.status) {
//         int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
//         int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
//         return (aId - bId);
//       } else if (a.status) {
//         return isAscending ? 1 : -1;
//       } else {
//         return isAscending ? -1 : 1;
//       }
//     });
//   }
// }

class UserInfo {
  String name;
  bool status;
  String phone;
  String registerDate;
  String terminationDate;
  String luz;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate, this.luz);
}

class DataBase {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection("Date").orderBy("semana").get();
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
