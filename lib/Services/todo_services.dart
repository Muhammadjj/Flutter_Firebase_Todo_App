import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/Model/todo_model.dart';

class TodoServices {
  CollectionReference<Map<String, dynamic>> todoCollection =
      FirebaseFirestore.instance.collection("todoApp");

  // CRUD OPERATION IN FIREBASE .

  // INSERT DATA IN FIREBASE .
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  // UPDATE DATA IN FIREBASE METHOD 1 UPDATE ALL DATA .
  void updateTasking(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  // UPDATE DATA IN FIREBASE METHOD 2 UPDATE RADIO BUTTON .
  void updateTask(String? docId, bool? valueUpdate) {
    todoCollection.doc(docId).update({
      "isDone": valueUpdate,
    });
  }

  //  DELETE DATA IN FIREBASE .
  void deleteTask(String docId) {
    todoCollection.doc(docId).delete();
  }
}
