import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_firebase/Auth/Phone_Auth/verify_code.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:todo_app_firebase/Widget/small_widget.dart';
import 'package:todo_app_firebase/Widget/text_field_widget.dart';

class LoginPhoneAuth extends StatefulWidget {
  const LoginPhoneAuth({super.key});

  @override
  State<LoginPhoneAuth> createState() => _LoginPhoneAuthState();
}

class _LoginPhoneAuthState extends State<LoginPhoneAuth> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController phoneAuth = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    phoneAuth = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    phoneAuth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthTextField(
                keyboardType: TextInputType.phone,
                hintText: "Country Code And Phone Number.",
                controller: phoneAuth,
                maxLength: 13,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Phone Number.";
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
              Gap(height * 0.1),
              beautifulButton(
                color: cupertinoButtonColor,
                text: "PHONE NUMBER",
                onPressed: () {
                  if (key.currentState!.validate()) {
                    auth.verifyPhoneNumber(
                      phoneNumber: phoneAuth.text.toString(),
                      verificationCompleted: (phoneAuthCredential) {},
                      codeAutoRetrievalTimeout: (verificationId) {},
                      verificationFailed: (error) {
                        debugPrint("Phone Auth Error : ${error.toString()}");
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VerifyCodeScreen(id: verificationId)));
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
