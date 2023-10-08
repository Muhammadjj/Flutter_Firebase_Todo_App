import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_firebase/Model/todo_model.dart';
import 'package:todo_app_firebase/Services/todo_services.dart';

// servicesProvider and Template type ma TodoServices ki class la raha ha .
final servicesProvider =
    StateProvider<TodoServices>((StateProviderRef<TodoServices> ref) {
  return TodoServices();
});

//  (fetchStreamProvider) ka method hmy insert data ko firebase sa fetch kr
//  Ui's pr show kry ga
final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection("todoApp")
      // .where("uids", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((event) => event.docs
          .map((snapShot) => TodoModel.fromSnapShot(snapShot))
          .toList());
  yield* getData;
});
