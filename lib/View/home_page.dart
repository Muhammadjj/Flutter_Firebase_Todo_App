// ignore_for_file: must_be_immutable
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_firebase/Auth/Pages/Profile_Page/profile_page_main.dart';
import 'package:todo_app_firebase/Common/show_model.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:todo_app_firebase/Provider/todo_services.dart';
import 'package:todo_app_firebase/Widget/shine_button.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:todo_app_firebase/Widget/small_widget.dart';

import '../Widget/card_todo_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: screenColors,
      // App Bar Section
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: screenColors,
        foregroundColor: Colors.black,
        title: Text("TODO APP",
            style: GoogleFonts.tiroBangla(
                textStyle: const TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ))),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              },
              child: const Icon(
                CupertinoIcons.profile_circled,
                shadows: [Shadow(color: Colors.grey, blurRadius: 10)],
                size: 40,
              )),
          const Gap(15),
        ],
      ),

      // (+ New Task ) Button Section .
      body: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            title: Text("Today's Task",
                style: GoogleFonts.tiroBangla(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
            subtitle: Text(now.toString(),
                style: const TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 175, 175, 175))),
            trailing: SizedBox(
                width: width * 0.35,
                child: NewTaskShineButton(
                    color: Colors.grey,
                    onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        builder: (context) {
                          debugPrint("show bottom bar");
                          return const AddNewTaskModel();
                        }),
                    child: AutoSizeText(
                      "+ New Task",
                      style: GoogleFonts.tienne(
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ))),
          ),

          // ! Needed Uses But Few Hours Using This Insert List .
          // Insert Operation Create Container Section .
          Expanded(
            child: ListView.builder(
              itemCount: todoData.value?.length ?? 0,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardTodoListWidget(
                  getIndex: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
