// ignore_for_file: use_build_context_synchronously, must_be_immutable, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:todo_app_firebase/Model/todo_model.dart';
import 'package:todo_app_firebase/Provider/date_time_provider.dart';
import 'package:todo_app_firebase/Provider/radio_provider.dart';
import 'package:todo_app_firebase/Provider/todo_services.dart';
import 'package:todo_app_firebase/Widget/date_time_widget.dart';
import 'package:todo_app_firebase/Widget/small_widget.dart';
import 'package:todo_app_firebase/Widget/text_field_widget.dart';
import '../Widget/radio_widget.dart';

class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  // ** Using this RadioButton String Values .

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    // final radioCategory = ref.watch(radioProvider);
    final datePro = ref.watch(dateProvider);
    final timePro = ref.watch(timeProvider);
    return Container(
      height: height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(16),
          // Title Section .
          SizedBox(
            width: width,
            child: AutoSizeText(
              "New Task Today",
              style: GoogleFonts.tiroBangla(
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Text Field Section
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          textFieldTitle(text: "Title Task"),
          const Gap(4),
          AuthTextField(
              hintText: "Add Task Name",
              controller: titleController,
              maxLines: 2),
          const Gap(17),
          textFieldTitle(text: "Description"),
          const Gap(4),
          AuthTextField(
            hintText: "Add Description",
            controller: descriptionController,
            maxLines: 5,
          ),
          const Gap(15),
          // Radio Button Section
          textFieldTitle(text: "Category"),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  categColor: Colors.green,
                  titleRadio: "LRN",
                  valueInput: 1,
                  onChanged: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                  child: RadioWidget(
                valueInput: 2,
                categColor: Colors.blue.shade500,
                titleRadio: "WRK",
                onChanged: () =>
                    ref.read(radioProvider.notifier).update((state) => 2),
              )),
              Expanded(
                  child: RadioWidget(
                valueInput: 3,
                categColor: Colors.amberAccent.shade700,
                titleRadio: "GEN",
                onChanged: () =>
                    ref.read(radioProvider.notifier).update((state) => 3),
              )),
            ],
          ),

          // Date and time Section.
          const Gap(30),
          Row(
            children: [
              Expanded(
                  child: DateTimeWidget(
                titleText: "Date",
                icon: CupertinoIcons.calendar,
                valueText: datePro,
                onTap: () async {
                  debugPrint("Date onTap");
                  // * Using This (ShowDatePicker)
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025));

                  if (getValue != null) {
                    debugPrint(getValue.toIso8601String());
                    final format = DateFormat.yMd();
                    debugPrint(format.format(getValue));
                    // using River Pod check this Ui's Date changing Updated
                    ref.read(dateProvider.notifier).update(
                          (state) => format.format(getValue),
                        );
                  }
                },
              )),
              Expanded(
                  child: DateTimeWidget(
                titleText: "Time",
                icon: CupertinoIcons.time,
                valueText: timePro,
                onTap: () async {
                  // ** Using This (ShowTimePicker) ;
                  final getTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  // ** check this time null OR not null
                  if (getTime != null) {
                    debugPrint(getTime.format(context));
                    // using River Pod check this Ui's Time changing Updated
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              )),
            ],
          ),

          // Button Section .

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black))),
                    onPressed: () {
                      Navigator.pop(context);
                      Utils().toast("Do,nt Insert Data");
                      ref.watch(radioProvider.notifier).update((state) => 0);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: screenColors,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // ** Using this RadioButton String Values .
                      final getRadioValue = ref.read(radioProvider);
                      String category = "";

                      // Using this switch case .
                      switch (getRadioValue) {
                        case 1:
                          category = "Learning";
                          break;
                        case 2:
                          category = "Working";
                          break;
                        case 3:
                          category = "General";
                          break;
                        default:
                      }

                      /// this method Press (Create Button) my requirement all
                      /// data add to firebase .
                      ref.read(servicesProvider).addNewTask(TodoModel(
                          titleTask: titleController.text,
                          description: descriptionController.text,
                          category: category,
                          dateTask: ref.read(dateProvider),
                          timeTask: ref.read(timeProvider),
                          isDone: false));

                      /// Data Insert hony ka bd textField ma jo data ho ga wo clear
                      /// ho jaye ga aur agr hm na koi radio button select kya ho ga
                      /// to bhi unselected ho jaye ga .
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                      ref.watch(radioProvider.notifier).update(
                            (state) => 0,
                          );
                      Utils().toast("Successfully Insert Data");
                      debugPrint("Successfully Insert Data .");
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget textFieldTitle({
  String text = "",
}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 30),
      child: AutoSizeText(text,
          style: GoogleFonts.tiroBangla(
            textStyle: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    ),
  );
}
