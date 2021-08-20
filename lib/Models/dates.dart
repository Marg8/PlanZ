import 'package:cloud_firestore/cloud_firestore.dart';

class DateModel {
  int ahorro;
  int internet;
  Timestamp semana;
  int luz;
  int agua;

  DateModel({
    this.ahorro,
    this.internet,
    this.semana,
    this.luz,
    this.agua,
  });

  DateModel.fromJson(Map<String, dynamic> json) {
    ahorro = json['ahorro'];
    internet = json['internet'];
    semana = json['semana'];
    luz = json['luz'];
    agua = json['agua'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ahorro'] = this.ahorro;
    data['internet'] = this.internet;
    data['semana'] = this.semana;
    data["luz"] = this.luz;
    data['agua'] = this.agua;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
