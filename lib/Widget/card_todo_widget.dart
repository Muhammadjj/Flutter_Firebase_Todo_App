import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_firebase/Provider/todo_services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/todo_model.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      // if show this error and show text .
      error: (error, stackTrace) {
        return const Center(child: Text("This is Receive This Error"));
      },
      // if wait this data and load data
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      // insert Complete Data and fetch all data show this screen .
      data: (List<TodoModel> fetchData) {
        var colorCategory = Colors.white;
        final getData = fetchData[getIndex].category;
        switch (getData) {
          case "Learning":
            colorCategory = Colors.green;
            break;
          case "Working":
            colorCategory = Colors.blue.shade800;
            break;
          case "General":
            colorCategory = Colors.amber.shade700;
            break;
          default:
        }
        return Container(
          height: height * 0.3,
          width: width * 0.9,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Container Colors Line Part .
              Container(
                height: height,
                width: width * 0.04,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: colorCategory),
              ),
              // Container ListTitle Part .

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                          contentPadding: const EdgeInsets.all(4),
                          title: Text(fetchData[getIndex].titleTask.toString(),
                              style: GoogleFonts.tiroBangla(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: fetchData[getIndex].isDone
                                        ? TextDecoration.lineThrough
                                        : null),
                              )),
                          subtitle: Text(
                            fetchData[getIndex].description.toString(),
                            style: TextStyle(
                                decoration: fetchData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue,
                              shape: const CircleBorder(),
                              value: fetchData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(servicesProvider)
                                  .updateTask(fetchData[getIndex].docID, value),
                            ),
                          )),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(
                          children: [
                            const Divider(thickness: 1.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Today",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Gap(width * 0.04),
                                Text(
                                    "${fetchData[getIndex].dateTask.toString()}\t\t${fetchData[getIndex].timeTask}"),
                                Gap(width * 0.01),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          ref.read(servicesProvider).deleteTask(
                                              fetchData[getIndex]
                                                  .docID
                                                  .toString());
                                        },
                                        icon: const Icon(
                                            CupertinoIcons.delete_simple)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

/*

*/
