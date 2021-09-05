import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:planz/Authentication/authenication.dart';
import 'package:planz/Config/config.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class TableTest extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TableTest> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  DataBase db;
  List docs = [];
  List docst = [];
  List docsid = [];
  initialise() {
    db = DataBase();
    db.initiliase();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
    db.readIDfinal().then((value) => {
          setState(() {
            docsid = value;
          })
        });
    // db.readTitle().then((valuet) => {
    //       setState(() {
    //         docst = valuet;
    //       })
    //     });
  }

  TextEditingController _inputFieldDateController = new TextEditingController();
  dynamic newDateEdit;
  // static const int sortName = 0;
  // static const int sortStatus = 1;
  bool isAscending = true;
  // int sortType = sortName;
  String newDate = "";
  String _fecha = "";
  int newvalued = 0;
  String productId;

  final oCcy = new NumberFormat("#,##0", "en_US");

  @override
  void initState() {
    // user.initData(100);
    super.initState();
    initialise();
    // _cargarReferencias();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  String columna2 = "columna2";
  String columna3 = "columna3";
  String columna4 = "columna4";
  String columna5 = "columna5";
  String columna6 = "columna6";
  String columna7 = "columna7";
  String columna8 = "columna8";
  String columna9 = "columna9";
  String columna10 = "columna10";
  String columna11 = "Expenses/ Gastos";
  String columna12 = "Income/ Ingresos";
  String columna13 = "Balance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: Icon(Icons.calendar_today_outlined)),
          IconButton(
              onPressed: () {
                EcommerceApp.auth.signOut().then((c) {
                  EcommerceApp.sharedPreferences.clear();
                  Route route =
                      MaterialPageRoute(builder: (c) => AuthenticScreen());
                  Navigator.pushReplacement(context, route);
                });
              },
              icon: Icon(Icons.logout_outlined))
        ],
        title: Text("PLAN B"),
      ),
      body: docs.length < 1 ? _nullmenssage() : _getBodyWidget(db),
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      // locale: Locale("es")
    );
    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });

      saveUserInfoToFireStore(context);

      db.read().then((value) => {
            setState(() {
              docs = value;
            })
          });
      db.readIDfinal().then((value) => {
            setState(() {
              docsid = value;
            })
          });
    }
  }

  Future saveUserInfoToFireStore(context) async {
    var dDay = DateTime.parse(_inputFieldDateController.text);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("date")
        .doc(dDay.toString())
        .set({
      "columna1": dDay,
      "columna2": int.parse(docs[0]["columna2"].toString()),
      "columna3": int.parse(docs[0]["columna3"].toString()),
      "columna4": int.parse(docs[0]["columna4"].toString()),
      "columna5": int.parse(docs[0]["columna5"].toString()),
      "columna6": int.parse(docs[0]["columna6"].toString()),
      "columna7": int.parse(docs[0]["columna7"].toString()),
      "columna8": int.parse(docs[0]["columna8"].toString()),
      "columna9": int.parse(docs[0]["columna9"].toString()),
      "columna10": int.parse(docs[0]["columna10"].toString()),
      "columna11": int.parse(docs[0]["columna11"].toString()),
      "columna12": int.parse(docs[0]["columna12"].toString()),
      "columna13": int.parse(docs[0]["columna13"].toString()),
    });
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  Future deleteInfoToFireStore(context, String dateID) async {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("date")
        .doc(dateID)
        .delete()
        .then((value) => {
              db.read().then((value) => {
                    setState(() {
                      docs = value;
                    })
                  }),
              Fluttertoast.showToast(msg: "Date Was Deleted")
            });
  }

  Widget _getBodyWidget(DataBase dataBase) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 110,
        rightHandSideColumnWidth: 1200,
        isFixedHeader: true,
        headerWidgets: docs.length < 1
            ? db.read().then((value) => {
                  setState(() {
                    docs = value;
                  })
                })
            : _getTitleWidget(context),
        leftSideItemBuilder: docs.length < 1
            ? db.read().then((value) => {
                  setState(() {
                    docs = value;
                  })
                })
            : _generateFirstColumnRow,
        rightSideItemBuilder: docs.length < 1
            ? db.read().then((value) => {
                  setState(() {
                    docs = value;
                  })
                })
            : _generateRightHandSideColumnRow,
        itemCount: docs.length > 1 ? docs.length : 13,
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

          db = DataBase();
          db.initiliase();
          db.read().then((value) => {
                setState(() {
                  docs = value;
                })
              });
          // db.readTitle().then((valuet) => {
          //       setState(() {
          //         docst = valuet;
          //       })
          //     });
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget(BuildContext context) {
    // final course = EcommerceApp.firestore
    //     .collection("users")
    //     .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
    //     .collection("categorias")
    //     .snapshots();
    return [
      TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: _getTitleItemWidget('Date', 100),
          onPressed: () {}),
      _getTitleItemWidget2(context, "titulo2", 100),
      _getTitleItemWidget2(context, "titulo3", 100),
      _getTitleItemWidget2(context, "titulo4", 100),
      _getTitleItemWidget2(context, "titulo5", 100),
      _getTitleItemWidget2(context, "titulo6", 100),
      _getTitleItemWidget2(context, "titulo7", 100),
      _getTitleItemWidget2(context, "titulo8", 100),
      _getTitleItemWidget2(context, "titulo9", 100),
      _getTitleItemWidget2(context, "titulo10", 100),
      _getTitleItemWidget(columna11, 100),
      _getTitleItemWidget(columna12, 100),
      _getTitleItemWidget(columna13, 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return InkWell(
      onTap: () {
        print(label);

        // setState(() {});
      },
      child: Container(
        child: Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        width: width,
        height: 56,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _getTitleItemWidget2(
      BuildContext context, String label, double width) {
    final course = EcommerceApp.firestore
        .collection("users")
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("categorias")
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: course,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 100,
          );
        }
        // final datat = snapshot.requireData;

        return InkWell(
          onTap: () {
            _mostrarAlerta(context, label, "A");
          },
          child: Container(
            width: 100,
            height: 16,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data.docs[0][label].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold));
              },
            ),
          ),
        );
      },
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, index) {
    // DateTime myDateTime = (docs[index]["columna1"].toDate());
    return InkWell(
      onTap: () {
        print(docsid[index].id);
        _mostrarAlertaDatedata(context, docsid[index].id, "columna1", "New");
      },
      child: Container(
        child: Text(
          DateFormat.yMMMd().format(docs[index]["columna1"].toDate()),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, index) {
    int gastos = docs[index]["columna2"].toInt() +
        docs[index]["columna3"].toInt() +
        docs[index]["columna4"].toInt() +
        docs[index]["columna5"].toInt() +
        docs[index]["columna6"].toInt() +
        docs[index]["columna7"].toInt() +
        docs[index]["columna8"].toInt() +
        docs[index]["columna9"].toInt() +
        docs[index]["columna10"].toInt();

    int balance = docs[index]["columna12"].toInt() - gastos;
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna2", "New");
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Text(r"$" + oCcy.format(docs[index]["columna2"]),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna3", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna3"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna4", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna4"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna5", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna5"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna6", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna6"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna7", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna7"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna8", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna8"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna9", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna9"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna10", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna10"]),
                style: TextStyle(fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            child: Text(
              r"$" + oCcy.format(gastos),
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () {
            _mostrarAlertaValuedata(
                context, docsid[index].id, "columna12", "New");
          },
          child: Container(
            child: Text(r"$" + oCcy.format(docs[index]["columna12"]),
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
         
        InkWell(
          onTap: () {},
          child: Container(
            child: balance > 0
                ? Text(r"$" + oCcy.format(balance),
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold))
                : Text(r"$" + oCcy.format(balance),
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }

  _mostrarAlerta(BuildContext context, String label, String newtitulo) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("Title"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    newtitulo = value;

                    // _changeValue();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "New title",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                // FlutterLogo(
                //   size: 100.0,
                // )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  if (newtitulo.isNotEmpty) {
                    changeTitlte(label, newtitulo);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  _mostrarAlertaValuedata(
      BuildContext context, valueID, String label, String newqty) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("Quantity"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    newqty = value;

                    // _changeValue();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Quantity",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                // FlutterLogo(
                //   size: 100.0,
                // )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  if (newqty.isNotEmpty) {
                    changeDatabyWeek(context, valueID, label, newqty);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  Future changeDatabyWeek(
      BuildContext context, valueID, String label, String newqty) async {
    WriteBatch batch = EcommerceApp.firestore.batch();

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("date")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((productId) {
        try {
          if (valueID == productId.id) {
            batch.update(productId.reference, {label: int.parse(newqty)});
            if (productId != null) {}
          }
        } on FormatException catch (error) {
          print("The document ${error.source} could not be parsed.");
          return null;
        }
      });
      return batch.commit().then((value) => {
            db.read().then((value) => {
                  setState(() {
                    docs = value;
                  })
                }),
            db.readIDfinal().then((value) => {
                  setState(() {
                    docsid = value;
                  })
                })
          });
    });
  }

  Future changeTitlte(String label, String newtitulo) async {
    WriteBatch batch = EcommerceApp.firestore.batch();

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("categorias")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((productId) {
        try {
          if (productId.exists) {
            batch.update(productId.reference, {label: newtitulo});
          }
        } on FormatException catch (error) {
          print("The document ${error.source} could not be parsed.");
          return null;
        }
      });
      return batch.commit().then((value) => {
          db.read().then((value) => {
          setState(() {
            docs = value;
          })
        }),
    db.readIDfinal().then((value) => {
          setState(() {
            docsid = value;
          })
          })
      });
    });
  }

  _mostrarAlertaDatedata(
      BuildContext context, valueID, String label, String newqty) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("Cantidad"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  child: Column(
                    children: [
                      Text("Do You Want Delete Date?",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  onPressed: () {
                    // _changeValue();
                    setState(() {});
                  },
                ),
                // FlutterLogo(
                //   size: 100.0,
                // )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("Yes, Delete"),
                onPressed: () {
                  deleteInfoToFireStore(context, valueID);
                  Navigator.of(context).pop();

                  db.readIDfinal().then((value) => {
                        setState(() {
                          docsid = value;
                        })
                      });
                },
              ),
            ]);
      },
    );
  }

  //Valor para todas las semanas
  // Future changeData(BuildContext context) async {
  //   WriteBatch batch = EcommerceApp.firestore.batch();

  //   EcommerceApp.firestore
  //       .collection(EcommerceApp.collectionUser)
  //       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
  //       .collection("date")
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((productId) {
  //       try {
  //         if (productId.exists) {
  //           batch.update(productId.reference, {"columna2": 800});
  //         }
  //       } on FormatException catch (error) {
  //         print("The document ${error.source} could not be parsed.");
  //         return null;
  //       }
  //     });
  //     return batch.commit().then((value) {
  //       db.read().then((value) => {
  //             setState(() {
  //               docs = value;
  //             })
  //           });
  //     });
  //   });
  // }

  Widget _nullmenssage() {
    // DateTime myDateTime = (docs[index]["columna1"].toDate());
    return InkWell(
      onTap: () {},
      child: Container(
        child: Text(
          "Loading...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
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
      querySnapshot = await firestore
          .collection("users")
          .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .collection("date")
          .orderBy("columna1", descending: false)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docs = querySnapshot.docs;

        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  // Future readID(context) async {
  //   DocumentReference doc_ref = EcommerceApp.firestore
  //       .collection(EcommerceApp.collectionUser)
  //       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
  //       .collection("date")
  //       .doc();

  //   DocumentSnapshot docSnap = await doc_ref.get();
  //   // var doc_id2 = docSnap.reference.id;
  // }

  Future<List> readIDfinal() async {
    QuerySnapshot querySnapshot;
    List docsid = [];
    try {
      querySnapshot = await firestore
          .collection("users")
          .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .collection("date")
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docsid = querySnapshot.docs;
        return docsid;
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<List> readTitle() async {
  //   QuerySnapshot querySnapshot;
  //   List docst = [];
  //   try {
  //     querySnapshot = await firestore
  //         .collection("users")
  //         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
  //         .collection("categorias")
  //         .get();
  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (var doc in querySnapshot.docs.toList()) {
  //         Map a = {
  //           "titulo2": doc["titulo2"],
  //           "titulo3": doc["titulo3"],
  //           "titulo4": doc["titulo4"],
  //           "titulo5": doc["titulo5"],
  //           "titulo6": doc["titulo6"],
  //           "titulo7": doc["titulo7"],
  //           "titulo8": doc["titulo8"],
  //           "titulo9": doc["titulo9"],
  //           "titulo10": doc["titulo10"],
  //         };
  //         docst.add(a);
  //       }
  //       return docst;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}

// Future addDateData(String label, String newtitulo) async {
//   WriteBatch batch = EcommerceApp.firestore.batch();

//   EcommerceApp.firestore
//       .collection(EcommerceApp.collectionUser)
//       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection("categorias")
//       .get()
//       .then((querySnapshot) {
//     querySnapshot.docs.forEach((productId) {
//       try {
//         if (productId.exists) {
//           batch.update(productId.reference, {label: newtitulo});
//         }
//       } on FormatException catch (error) {
//         print("The document ${error.source} could not be parsed.");
//         return null;
//       }
//     });
//     return batch.commit();
//   });
// }
// _changeValue() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   prefs.setString("columna2", columna2);
//   prefs.setString("columna3", columna3);
//   prefs.setString("columna4", columna4);
//   prefs.setString("columna5", columna5);
//   prefs.setString("columna6", columna6);
//   prefs.setString("columna7", columna7);
//   prefs.setString("columna8", columna8);
//   prefs.setString("columna9", columna9);
//   prefs.setString("columna10", columna10);
//   // prefs.setString("columna11", columna11);
//   // prefs.setString("columna12", columna12);
//   // prefs.setString("columna13", columna13);

//   setState(() {
//     columna2 = columna2;
//   });
// }

// _cargarReferencias() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     columna2 = prefs.getString("columna2") ?? "Titulo";
//     columna3 = prefs.getString("columna3") ?? "Titulo";
//     columna4 = prefs.getString("columna4") ?? "Titulo";
//     columna5 = prefs.getString("columna5")?? "Titulo";
//     columna6 = prefs.getString("columna6") ?? "Titulo";
//     columna7 = prefs.getString("columna7") ?? "Titulo";
//     columna8 = prefs.getString("columna8") ?? "Titulo";
//     columna9 = prefs.getString("columna9") ?? "Titulo";
//     columna10 = prefs.getString("columna1") ?? "Titulo";
//     // columna11 = prefs.getString("columna11") ?? "Titulo";
//     // columna12 = prefs.getString("columna12") ?? "Titulo";
//     // columna13 = prefs.getString("columna13") ?? "Titulo";
//   });
// }

Future changeDateDatabyWeek(
    BuildContext context, valueID, String label, String newqty) async {
  WriteBatch batch = EcommerceApp.firestore.batch();

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection("date")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((productId) {
      try {
        if (valueID == productId.id) {
          batch.update(productId.reference, {label: DateTime.parse(newqty)});
          if (productId != null) {}
        }
      } on FormatException catch (error) {
        print("The document ${error.source} could not be parsed.");
        return null;
      }
    });
    return batch.commit();
  });
}

Future readData() async {
  FirebaseFirestore.instance
      .collection("users")
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .get()
      .then((dataSnapshot) async {
    await EcommerceApp.sharedPreferences
        .setString("uid", dataSnapshot.data()[EcommerceApp.userUID]);
    await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userEmail, dataSnapshot.data()[EcommerceApp.userEmail]);
    await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userName, dataSnapshot.data()[EcommerceApp.userName]);
  });
}
