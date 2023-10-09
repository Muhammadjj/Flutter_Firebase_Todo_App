import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:todo_app_firebase/View/home_page.dart';
import 'package:todo_app_firebase/Widget/small_widget.dart';
import 'package:todo_app_firebase/Widget/text_field_widget.dart';

///                    SKIP THIS PAGE
/// ! abi ays page pr work pra howa ha wo work ya ha ky hm ny
/// ! phone auth sa jo current user home page pr jaye ga ays
/// ! ka all (additional profile data) ko show krwana ha .
class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, required this.id});
  final String id;
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController verifyCode = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    verifyCode = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    verifyCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: screenColors,
        body: Center(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthTextField(
                  maxLength: 6,
                  controller: verifyCode,
                  hintText: "Enter Verify Code",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Verify Code.";
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
                beautifulButton(
                  color: cupertinoButtonColor,
                  text: "VERIFY CODE",
                  loading: loading,
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      setState(() => loading = true);
                      final credential = PhoneAuthProvider.credential(
                          verificationId: widget.id.toString(),
                          smsCode: verifyCode.text.toString());
                      await auth.signInWithCredential(credential).then((value) {
                        Utils().toast("Successfully Verify");
                        setState(() => loading = false);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      }).onError((error, stackTrace) {
                        setState(() => loading = false);
                        Utils().toast("Error : ${error.toString()}");
                      });
                      debugPrint("Successfully Verify");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
