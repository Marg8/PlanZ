// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';
// import 'package:intl/intl.dart';
// import 'package:planz/Authentication/authenication.dart';
// import 'package:planz/Config/config.dart';
// import 'package:planz/Models/dates.dart';
// import 'package:planz/Models/valuesModel.dart';
// import 'package:planz/Orders/placeOrderPayment.dart';
// import 'package:planz/Widgets/loadingWidget.dart';
// import 'package:planz/firebase/readdata.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TableTest extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<TableTest> {
//   HDTRefreshController _hdtRefreshController = HDTRefreshController();

//   DataBase db;
//   // List docs = [1, 2, 3, 4, 5, 6, 7, 8];
//   // List docst = [];
//   // initialise() {
//   //   // db = DataBase();
//   //   // db.initiliase();
//   //   // db.read().then((value) => {
//   //   //       setState(() {
//   //   //         docs = value;
//   //   //       })
//   //   //     });
//   //   // db.readTitle().then((valuet) => {
//   //   //       setState(() {
//   //   //         docst = valuet;
//   //   //       })
//   //   //     });
//   // }

//   TextEditingController _inputFieldDateController = new TextEditingController();
//   // static const int sortName = 0;
//   // static const int sortStatus = 1;
//   bool isAscending = true;
//   // int sortType = sortName;
//   String newDate = "";
//   String _fecha = "";
//   int newvalued = 0;
//   String productId;
//   // @override
//   // void initState() {
//   //   // user.initData(100);
//   //   super.initState();
//   //   initialise();
//   //   // _cargarReferencias();
//   // }

//   String columna2 = "columna2";
//   String columna3 = "columna3";
//   String columna4 = "columna4";
//   String columna5 = "columna5";
//   String columna6 = "columna6";
//   String columna7 = "columna7";
//   String columna8 = "columna8";
//   String columna9 = "columna9";
//   String columna10 = "columna10";
//   String columna11 = "Ingreso";
//   String columna12 = "Total de gastos";
//   String columna13 = "Balance";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               icon: Icon(Icons.calendar_today_outlined)),
//           IconButton(
//               onPressed: () {
//                 EcommerceApp.auth.signOut().then((c) {
//                   Route route =
//                       MaterialPageRoute(builder: (c) => AuthenticScreen());
//                   Navigator.push(context, route);
//                 });
//               },
//               icon: Icon(Icons.add))
//         ],
//         title: Text("PLAN Z"),
//       ),
//       body: _getBodyWidget(db),
//     );
//   }

//   Future _selectDate(BuildContext context) async {
//     DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: new DateTime.now(),
//       firstDate: new DateTime(2018),
//       lastDate: new DateTime(2025),
//       // locale: Locale("es")
//     );
//     if (picked != null) {
//       setState(() {
//         _fecha = picked.toString();
//         _inputFieldDateController.text = _fecha;
//       });

//       saveUserInfoToFireStore(context);
//     }
//   }

//   Future saveUserInfoToFireStore(context) async {
//     var dDay = DateTime.parse(_inputFieldDateController.text);
//     EcommerceApp.firestore
//         .collection(EcommerceApp.collectionUser)
//         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection("date")
//         .doc()
//         .set({
//       "columna1": dDay,
//       "columna2": 0.toInt(),
//       "columna3": 0.toInt(),
//       "columna4": 0.toInt(),
//       "columna5": 0.toInt(),
//       "columna6": 0.toInt(),
//       "columna7": 0.toInt(),
//       "columna8": 0.toInt(),
//       "columna9": 0.toInt(),
//       "columna10": 0.toInt(),
//       "columna11": 0.toInt(),
//       "columna12": 0.toInt(),
//       "columna13": 0.toInt(),
//     });
//     // db.read().then((value) => {
//     //       setState(() {
//     //         docs = value;
//     //       })
//     //     });
//   }

//   Widget _getBodyWidget(DataBase dataBase) {
//     return Container(
//       child: HorizontalDataTable(
//         leftHandSideColumnWidth: 110,
//         rightHandSideColumnWidth: 1200,
//         isFixedHeader: true,
//         headerWidgets: _getTitleWidget(context),
//         leftSideItemBuilder: _streamDatatitle,
//         rightSideItemBuilder: _streamData,
//         itemCount: 13,
//         rowSeparatorWidget: const Divider(
//           color: Colors.black54,
//           height: 1.0,
//           thickness: 0.0,
//         ),
//         leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
//         rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
//         verticalScrollbarStyle: const ScrollbarStyle(
//           isAlwaysShown: true,
//           thickness: 4.0,
//           radius: Radius.circular(5.0),
//         ),
//         horizontalScrollbarStyle: const ScrollbarStyle(
//           isAlwaysShown: true,
//           thickness: 4.0,
//           radius: Radius.circular(5.0),
//         ),
//         enablePullToRefresh: true,
//         refreshIndicator: const WaterDropHeader(),
//         refreshIndicatorHeight: 60,
//         onRefresh: () async {
//           //Do sth
//           await Future.delayed(const Duration(milliseconds: 500));
//           _hdtRefreshController.refreshCompleted();

//           // db = DataBase();
//           // db.initiliase();
//           // db.read().then((value) => {
//           //       setState(() {
//           //         docs = value;
//           //       })
//           //     });
//           // db.readTitle().then((valuet) => {
//           //       setState(() {
//           //         docst = valuet;
//           //       })
//           //     });
//         },
//         htdRefreshController: _hdtRefreshController,
//       ),
//       height: MediaQuery.of(context).size.height,
//     );
//   }

//   List<Widget> _getTitleWidget(BuildContext context) {
//     // final course = EcommerceApp.firestore
//     //     .collection("users")
//     //     .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//     //     .collection("categorias")
//     //     .snapshots();
//     return [
//       TextButton(
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//           ),
//           child: _getTitleItemWidget('Fecha', 100),
//           onPressed: () {}),
//       _getTitleItemWidget2(context, "titulo2", 100),
//       _getTitleItemWidget2(context, "titulo3", 100),
//       _getTitleItemWidget2(context, "titulo4", 100),
//       _getTitleItemWidget2(context, "titulo5", 100),
//       _getTitleItemWidget2(context, "titulo6", 100),
//       _getTitleItemWidget2(context, "titulo7", 100),
//       _getTitleItemWidget2(context, "titulo8", 100),
//       _getTitleItemWidget2(context, "titulo9", 100),
//       _getTitleItemWidget2(context, "titulo10", 100),
//       _getTitleItemWidget2(context, "titulo11", 100),
//       _getTitleItemWidget2(context, "titulo12", 100),
//       _getTitleItemWidget2(context, "titulo13", 100),

//       // _getTitleItemWidget(columna4, 100),
//       // _getTitleItemWidget(columna5, 100),
//       // _getTitleItemWidget(columna6, 100),
//       // _getTitleItemWidget(columna7, 100),
//       // _getTitleItemWidget(columna8, 100),
//       // _getTitleItemWidget(columna9, 100),
//       // _getTitleItemWidget(columna10, 100),
//       // _getTitleItemWidget(columna11, 100),
//       // _getTitleItemWidget(columna12, 100),
//       // _getTitleItemWidget(columna13, 100),
//       // StreamBuilder(
//       //   stream: course,
//       //   builder: (context, snapshop) {

//       //   },
//       // )
//     ];
//     // return [
//     //   TextButton(
//     //       style: TextButton.styleFrom(
//     //         padding: EdgeInsets.zero,
//     //       ),
//     //       child: _getTitleItemWidget('Fecha', 100),
//     //       onPressed: () {}),
//     //   TextButton(
//     //     style: TextButton.styleFrom(
//     //       padding: EdgeInsets.zero,
//     //     ),
//     //     child: _getTitleItemWidget2(context, "titulo2", 100),
//     //     onPressed: () {},
//     //   ),
//     //   _getTitleItemWidget(columna3, 100),
//     //   _getTitleItemWidget(columna4, 100),
//     //   _getTitleItemWidget(columna5, 100),
//     //   _getTitleItemWidget(columna6, 100),
//     //   _getTitleItemWidget(columna7, 100),
//     //   _getTitleItemWidget(columna8, 100),
//     //   _getTitleItemWidget(columna9, 100),
//     //   _getTitleItemWidget(columna10, 100),
//     //   _getTitleItemWidget(columna11, 100),
//     //   _getTitleItemWidget(columna12, 100),
//     //   _getTitleItemWidget(columna13, 100),
//     // ];
//   }

//   Widget _getTitleItemWidget(String label, double width) {
//     return InkWell(
//       onTap: () {
//         print(label);

//         // setState(() {});
//       },
//       child: Container(
//         child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//         width: width,
//         height: 55,
//         padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//         alignment: Alignment.centerLeft,
//       ),
//     );
//   }

//   Widget _getTitleItemWidget2(
//       BuildContext context, String label, double width) {
//     final course = EcommerceApp.firestore
//         .collection("users")
//         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection("categorias")
//         .snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: course,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Error");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return circularProgress();
//         }
//         // final datat = snapshot.requireData;

//         return InkWell(
//           onTap: () {
//             _mostrarAlerta(context, label, "A");
//           },
//           child: Container(
//             width: 100,
//             height: 55,
//             child: ListView.builder(
//               itemBuilder: (context, index) {
//                 print(index);
//                 return snapshot.connectionState == ConnectionState.waiting
//                     ? circularProgress()
//                     : Container(
//                       height: 55,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
                        
//                           child: Text(snapshot.data.docs[index][label].toString(),
//                               style: TextStyle(fontWeight: FontWeight.bold)),
                        
//                       ),
//                     );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   _updateData(BuildContext context, index) {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection("date")
//         .doc(productId)
//         .update({
//       "columna2": 100,
//     });
//   }

//     Widget _streamDatatitle(BuildContext context, model1) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//             .collection("date")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
//           return !dataSnapshot.hasData
//               ? Container(
//                   child: Center(
//                     child: circularProgress(),
//                   ),
//                 )
//               : Container(
//                 width: 100,
//                   height: 56,
//                 child: ListView.builder(
//                     itemBuilder: (context, index) {
                      
//                       ValueModel model1 = ValueModel.fromJson(
//                           dataSnapshot.data.docs[index].data());
//                       return _generateFirstColumnRow(context, model1);
//                     },
                    
//                   ),
//               );
//         });
//   }

//   Widget _generateFirstColumnRow(BuildContext context,ValueModel model1) {
//     DateTime myDateTime = (model1.columna1.toDate());
//     return InkWell(
//       onTap: () {
//         print(DateFormat.yMMMd().format(myDateTime));
//         print(myDateTime);
//       },
//       child: Container(
//         child: Text(
//           DateFormat.yMMMd().format(model1.columna1.toDate()),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         width: 100,
//         height: 52,
//         padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//         alignment: Alignment.centerLeft,
//       ),
//     );
//   }

//   Widget _streamData(BuildContext context, model1) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//             .collection("date")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
//           return !dataSnapshot.hasData
//               ? Container(
//                   child: Center(
//                     child: circularProgress(),
//                   ),
//                 )
//               :  Container(
//                 width: 100,
//                   height: 56,
//                 child: ListView.builder(
                          
//                           itemBuilder: (context, index) {
//                             ValueModel model1 = ValueModel.fromJson(
//                                 dataSnapshot.data.docs[index].data());
//                             return _generateRightHandSideColumnRow(context, model1);
//                           },
//                           itemCount: dataSnapshot.data.docs.length,
//                         ),
//               );
//         });
//   }



//   Widget _generateRightHandSideColumnRow(BuildContext context, ValueModel model1) {
//     return Row(
//       children: <Widget>[
//         InkWell(
//           onTap: () {
//             // print(docs[index]["columna2"]);
//             // print(index);
//             // _mostrarAlertaUpdateData(context, index);
//             changeData(context);
//           },
//           child: Container(
//             child: Row(
//               children: <Widget>[Text(model1.columna2.toString())],
//             ),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // print(docs[index]["columna3"]);
//             // print(index);
//             changeDatabyWeek(context);
//           },
//           child: Container(
//             child: Text(model1.columna3.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // print(docs[index]["columna4"]);
//             changeDatabyWeek(context);
//           },
//           child: Container(
//             child: Text(model1.columna4.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna4);
//           },
//           child: Container(
//             child: Text(model1.columna5.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna6);
//           },
//           child: Container(
//             child: Text(model1.columna6.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna7);
//           },
//           child: Container(
//             child: Text(model1.columna7.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna8);
//           },
//           child: Container(
//             child: Text(model1.columna8.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna9);
//           },
//           child: Container(
//             child: Text(model1.columna7.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna10);
//           },
//           child: Container(
//             child: Text(model1.columna10.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna11);
//           },
//           child: Container(
//             child: Text(model1.columna11.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna12);
//           },
//           child: Container(
//             child: Text(model1.columna12.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             print(model1.columna13);
//           },
//           child: Container(
//             child: Text(model1.columna13.toString()),
//             width: 100,
//             height: 52,
//             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//             alignment: Alignment.centerLeft,
//           ),
//         ),
//       ],
//     );
//   }

//   _mostrarAlerta(BuildContext context, String label, String newtitulo) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)),
//             title: Text("Titulo"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextField(
//                   style: TextStyle(color: Colors.black),
//                   onChanged: (value) {
//                     newtitulo = value;
//                     if (newtitulo.isNotEmpty) {
//                       return changeTitlte(label, newtitulo);
//                     }

//                     // _changeValue();
//                     setState(() {});
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Nuevo titulo",
//                     hintStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//                 FlutterLogo(
//                   size: 100.0,
//                 )
//               ],
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("Cancelar"),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//               FlatButton(
//                 child: Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ]);
//       },
//     );
//   }

//   _mostrarAlertaUpdateData(
//     BuildContext context,
//     index,
//   ) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)),
//             title: Text("Nueva Fecha"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextField(
//                   enableInteractiveSelection: false,
//                   controller: _inputFieldDateController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0)),
//                     hintText: "2021-08-12",
//                     labelText: "Fecha de naciemiento",
//                     suffixIcon: Icon(Icons.perm_contact_calendar),
//                     icon: Icon(Icons.calendar_today),
//                   ),
//                   onSubmitted: (valued) {
//                     _updateData(context, index);
//                   },
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("Cancelar"),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//               FlatButton(
//                 child: Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   saveUserInfoToFireStore(context);
//                 },
//               ),
//             ]);
//       },
//     );
//   }

//   //  Widget _crearFecha(contex) {
//   //   return TextField(
//   //     enableInteractiveSelection: false,
//   //     controller: _inputFieldDateController,
//   //     decoration: InputDecoration(
//   //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//   //       hintText: "Fecha de naciemiento",
//   //       labelText: "Fecha de naciemiento",
//   //       suffixIcon: Icon(Icons.perm_contact_calendar),
//   //       icon: Icon(Icons.calendar_today),
//   //     ),
//   //     onTap: () {
//   //       FocusScope.of(context).requestFocus(new FocusNode());

//   //       _selectDate(context);
//   //     },
//   //   );
//   // }

//   //Valor para todas las semanas
//   Future changeData(BuildContext context) async {
//     WriteBatch batch = EcommerceApp.firestore.batch();

//     EcommerceApp.firestore
//         .collection(EcommerceApp.collectionUser)
//         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .collection("date")
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((productId) {
//         try {
//           if (productId.exists) {
//             batch.update(productId.reference, {"columna2": 800});
//           }
//         } on FormatException catch (error) {
//           print("The document ${error.source} could not be parsed.");
//           return null;
//         }
//       });
//       return batch.commit().then((value) {
        
//       });
//     });
//   }
// }

// // User user = User();

// // class User {
// //   List<DataBase> docs = [];

// //   void initData(int size) {
// //     for (int i = 0; i < size; i++) {
// //       docs
// //           .add(DataBase(docs[index]["semana"]));
// //     }
// //   }

// //   ///
// //   /// Single sort, sort Name's id
// //   void sortName(bool isAscending) {
// //     docs.sort((a, b) {
// //       int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
// //       int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
// //       return (aId - bId) * (isAscending ? 1 : -1);
// //     });
// //   }

// //   ///
// //   /// sort with Status and Name as the 2nd Sort
// //   void sortStatus(bool isAscending) {
// //     userInfo.sort((a, b) {
// //       if (a.status == b.status) {
// //         int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
// //         int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
// //         return (aId - bId);
// //       } else if (a.status) {
// //         return isAscending ? 1 : -1;
// //       } else {
// //         return isAscending ? -1 : 1;
// //       }
// //     });
// //   }
// // }

// class UserInfo {
//   String name;
//   bool status;
//   String phone;
//   String registerDate;
//   String terminationDate;
//   String luz;

//   UserInfo(this.name, this.status, this.phone, this.registerDate,
//       this.terminationDate, this.luz);
// }

// class DataBase {
//   FirebaseFirestore firestore;
//   initiliase() {
//     firestore = FirebaseFirestore.instance;
//   }

//   // Future<List> read() async {
//   //   QuerySnapshot querySnapshot;
//   //   List docs = [];
//   //   try {
//   //     querySnapshot = await firestore
//   //         .collection("users")
//   //         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//   //         .collection("date")
//   //         .orderBy("columna1", descending: false)
//   //         .get();
//   //     if (querySnapshot.docs.isNotEmpty) {
//   //       for (var doc in querySnapshot.docs.toList()) {
//   //         Map a = {
//   //           "columna1": doc["columna1"],
//   //           "columna2": doc["columna2"],
//   //           "columna3": doc["columna3"],
//   //           "columna4": doc["columna4"],
//   //           "columna5": doc["columna5"],
//   //           "columna6": doc["columna6"],
//   //           "columna7": doc["columna7"],
//   //           "columna8": doc["columna8"],
//   //           "columna9": doc["columna9"],
//   //           "columna10": doc["columna10"],
//   //           "columna11": doc["columna11"],
//   //           "columna12": doc["columna12"],
//   //           "columna13": doc["columna13"],
//   //         };
//   //         docs.add(a);
//   //       }
//   //       return docs;
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   // Future<List> readTitle() async {
//   //   QuerySnapshot querySnapshot;
//   //   List docst = [];
//   //   try {
//   //     querySnapshot = await firestore
//   //         .collection("users")
//   //         .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//   //         .collection("categorias")
//   //         .get();
//   //     if (querySnapshot.docs.isNotEmpty) {
//   //       for (var doc in querySnapshot.docs.toList()) {
//   //         Map a = {
//   //           "titulo2": doc["titulo2"],
//   //           "titulo3": doc["titulo3"],
//   //           "titulo4": doc["titulo4"],
//   //           "titulo5": doc["titulo5"],
//   //           "titulo6": doc["titulo6"],
//   //           "titulo7": doc["titulo7"],
//   //           "titulo8": doc["titulo8"],
//   //           "titulo9": doc["titulo9"],
//   //           "titulo10": doc["titulo10"],
//   //         };
//   //         docst.add(a);
//   //       }
//   //       return docst;
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

// }

// Future changeTitlte(String label, String newtitulo) async {
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

// // Future addDateData(String label, String newtitulo) async {
// //   WriteBatch batch = EcommerceApp.firestore.batch();

// //   EcommerceApp.firestore
// //       .collection(EcommerceApp.collectionUser)
// //       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
// //       .collection("categorias")
// //       .get()
// //       .then((querySnapshot) {
// //     querySnapshot.docs.forEach((productId) {
// //       try {
// //         if (productId.exists) {
// //           batch.update(productId.reference, {label: newtitulo});
// //         }
// //       } on FormatException catch (error) {
// //         print("The document ${error.source} could not be parsed.");
// //         return null;
// //       }
// //     });
// //     return batch.commit();
// //   });
// // }
// // _changeValue() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();

// //   prefs.setString("columna2", columna2);
// //   prefs.setString("columna3", columna3);
// //   prefs.setString("columna4", columna4);
// //   prefs.setString("columna5", columna5);
// //   prefs.setString("columna6", columna6);
// //   prefs.setString("columna7", columna7);
// //   prefs.setString("columna8", columna8);
// //   prefs.setString("columna9", columna9);
// //   prefs.setString("columna10", columna10);
// //   // prefs.setString("columna11", columna11);
// //   // prefs.setString("columna12", columna12);
// //   // prefs.setString("columna13", columna13);

// //   setState(() {
// //     columna2 = columna2;
// //   });
// // }

// // _cargarReferencias() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   setState(() {
// //     columna2 = prefs.getString("columna2") ?? "Titulo";
// //     columna3 = prefs.getString("columna3") ?? "Titulo";
// //     columna4 = prefs.getString("columna4") ?? "Titulo";
// //     columna5 = prefs.getString("columna5")?? "Titulo";
// //     columna6 = prefs.getString("columna6") ?? "Titulo";
// //     columna7 = prefs.getString("columna7") ?? "Titulo";
// //     columna8 = prefs.getString("columna8") ?? "Titulo";
// //     columna9 = prefs.getString("columna9") ?? "Titulo";
// //     columna10 = prefs.getString("columna1") ?? "Titulo";
// //     // columna11 = prefs.getString("columna11") ?? "Titulo";
// //     // columna12 = prefs.getString("columna12") ?? "Titulo";
// //     // columna13 = prefs.getString("columna13") ?? "Titulo";
// //   });
// // }

// Future changeDatabyWeek(BuildContext context) async {
//   WriteBatch batch = EcommerceApp.firestore.batch();

//   EcommerceApp.firestore
//       .collection(EcommerceApp.collectionUser)
//       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection("date")
//       .get()
//       .then((querySnapshot) {
//     querySnapshot.docs.forEach((productId) {
//       try {
//         if (productId == productId) {
//           batch.update(productId.reference, {"columna4": 600});
//           if (productId != null) {}
//         }
//       } on FormatException catch (error) {
//         print("The document ${error.source} could not be parsed.");
//         return null;
//       }
//     });
//     return batch.commit();
//   });
// }
