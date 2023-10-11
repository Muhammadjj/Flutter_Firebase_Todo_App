import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/Auth/Login_page/login_page_main.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:todo_app_firebase/View/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> offset;
  late AnimationController controller;
  Timer? timer;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    offset = Tween(begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.1))
        .animate(controller);
    controller.forward();

    /// Confirm Email Authentication Complete and Open this Page HomeScreen .
    /// otherVise do'nt Email Authentication Complete Open this Page Login Screen
    /// All check current user Authentication FireStore . Thats it.
    confirmLogin();
  }

  confirmLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? current = auth.currentUser;
    if (current != null) {
      timer = Timer.periodic(
          const Duration(
            seconds: 5,
          ), (timer) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      });
    } else {
      timer = Timer.periodic(
          const Duration(
            seconds: 5,
          ), (timer) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      });
    }
  }

  @override
  void dispose() {
    // Todo: implement dispose .
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenColors,
      body: Center(
        child: SlideTransition(
          position: offset,
          child: FadeInRight(
            animate: true,
            duration: const Duration(seconds: 1),
            child: const SizedBox(
                height: 300,
                width: 300,
                child: Image(image: AssetImage(splashImage))),
          ),
        ),
      ),
    );
  }
}
