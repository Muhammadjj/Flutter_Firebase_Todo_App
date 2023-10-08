import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/Auth/Google_Button_Page/google_button.dart';
import 'package:todo_app_firebase/Auth/Phone_Auth/login_phone_auth.dart';
import 'package:todo_app_firebase/Auth/SignUp_Page/sign_up_page_main.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:todo_app_firebase/View/home_page.dart';
import '../../Widget/small_widget.dart';
import '../../Widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: screenColors,
      body: SafeArea(
        child: Form(
          key: key,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(19.0),
            children: [
              Gap(height * 0.01),
              Center(
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.4,
                  child: const Image(
                      image: AssetImage(
                        todoImage,
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              Gap(height * 0.1),
              AuthTextField(
                controller: emailController,
                hintText: "Enter Your Email .",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Email.";
                  }
                  final validator = Validator(
                    validators: [
                      const EmailValidator(),
                      const MaxLengthValidator(length: 20)
                    ],
                  );
                  return validator.validate(
                    label: 'Required',
                    value: value,
                  );
                },
              ),
              Gap(height * 0.06),
              AuthTextField(
                controller: passwordController,
                hintText: "Enter Your Password .",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Password.";
                  }
                  final validator = Validator(
                    validators: [const MinNumberValidator(number: 20)],
                  );
                  return validator.validate(
                    label: 'Required',
                    value: value,
                  );
                },
              ),
              Gap(height * 0.07),
              SizedBox(
                  width: width * 0.85,
                  child: beautifulButton(
                    color: cupertinoButtonColor,
                    text: "LOGIN",
                    loading: loading,
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        setState(() => loading = true);
                        auth
                            .signInWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          emailController.clear();
                          passwordController.clear();
                          setState(() => loading = false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                          Utils().toast("Successfully Signup");
                        }).onError((error, stackTrace) {
                          Utils().toast("Error : ${error.toString()}");
                          setState(() => loading = false);
                        });
                      }
                    },
                  )),
              Gap(height * 0.02),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: AutoSizeText("Sign Up",
                        style: GoogleFonts.tiroBangla(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red))),
                  ),
                  AutoSizeText(
                    "Create a New Account",
                    style: GoogleFonts.tiroBangla(
                        textStyle: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Gap(height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 30,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPhoneAuth(),
                                ));
                          },
                          icon: const Icon(
                            Icons.phone,
                            size: 40,
                            color: Colors.white,
                          ))),
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: IconButton(
                          onPressed: () {
                            // signInWithGoogle(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GoogleButtonPage(),
                                ));
                          },
                          icon: const Icon(
                            Icons.g_mobiledata_outlined,
                            size: 40,
                            color: Colors.white,
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
