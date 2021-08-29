

import 'package:cloud_firestore/cloud_firestore.dart';

class ValueModel {
 Timestamp columna1;
 int columna2;
 int columna3;
 int columna4;
 int columna5;
 int columna6;
 int columna7;
 int columna8;
 int columna9;
 int columna10;
 int columna11;
 int columna12;
 int columna13;



  ValueModel({
      
      this.columna1,
      this.columna2,
      this.columna3,
      this.columna4,
      this.columna5,
      this.columna6,
      this.columna7,
      this.columna8,
      this.columna9,
      this.columna10,
      this.columna11,
      this.columna12,
      this.columna13,

});

  ValueModel.fromJson(Map<String, dynamic> json) {
    columna1 = json['columna1'];
    columna2 = json['columna2'];
    columna3 = json['columna3'];
    columna4 = json['columna4'];
    columna5 = json['columna5'];
    columna6 = json['columna6'];
    columna7 = json['columna7'];
    columna8 = json["columna8"];
    columna9 = json["columna9"];
    columna10 = json["columna10"];
    columna11 = json["columna11"];
    columna12 = json["columna12"];
    columna13 = json["columna13"];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['columna1'] = this.columna1;
    data['columna2'] = this.columna2;
    data['columna3'] = this.columna3;
    data["columna4"] = this.columna4;
    data['columna5'] = this.columna5;
    data['columna6'] = this.columna6;
    data['columna7'] = this.columna7;
    data["columna8"] = this.columna8;
    data["columna9"] = this.columna9;
    data["columna10"] = this.columna10;
    data["columna11"] = this.columna12;
    data["columna13"] = this.columna13;
    return data;
  }
}





