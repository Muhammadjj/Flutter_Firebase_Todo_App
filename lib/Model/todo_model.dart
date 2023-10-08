import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  String? titleTask;
  String? description;
  String? category;
  String? dateTask;
  String? timeTask;
  late bool isDone;

// ** Create Constructor because update this instance member
  TodoModel(
      {this.docID,
      required this.titleTask,
      required this.description,
      required this.category,
      required this.dateTask,
      required this.timeTask,
      required this.isDone});

//  ** Deserialization Map to Object .
  TodoModel.fromMap(Map<String, dynamic> map) {
    docID = map["docID"];
    titleTask = map["titleTask"] as String;
    description = map["description"] as String;
    category = map["category"] as String;
    dateTask = map["dateTask"] as String;
    timeTask = map["timeTask"] as String;
    isDone = map["isDone"] as bool;
  }

// ** Serialization object to Map.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['titleTask'] = titleTask;
    data['description'] = description;
    data['category'] = category;
    data['dateTask'] = dateTask;
    data['timeTask'] = timeTask;
    data["isDone"] = isDone;
    return data;
  }

//   DocumentSnapshot .
  factory TodoModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
        docID: doc.id,
        titleTask: doc["titleTask"],
        description: doc["description"],
        category: doc["category"],
        dateTask: doc["dateTask"],
        timeTask: doc["timeTask"],
        isDone: doc["isDone"]);
  }
}
