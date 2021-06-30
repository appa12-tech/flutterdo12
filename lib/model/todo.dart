import 'package:flutter/material.dart';
class Todo {
  int id;
  String note;

  String color;
  Todo({this.id, this.note,this.color="0xffffff"});
  //Color color;

  ///Todo({this.id, this.note,this.color=Colors.white});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    color=json['color'];
  }

  // Todo.toJson(Map<String, dynamic> data = new Map<String , dynamic>() {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['note'] = note;
    data['color']=color;
    return data;
  }
}
