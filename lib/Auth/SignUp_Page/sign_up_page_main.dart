// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_firebase/Auth/Login_page/login_page_main.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:form_validation/form_validation.dart';
import 'package:todo_app_firebase/Model/user_info.dart';
import 'package:todo_app_firebase/User_Detail_Pages/page1.dart';
import 'package:todo_app_firebase/View/home_page.dart';
import '../../Widget/small_widget.dart';
import '../../Widget/text_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  bool loading = false;

  File? images;
  final imagePicker = ImagePicker();
  String? getDownloadURL;

  Future<void> getPickImageForGallery() async {
    var picker = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 90);
    setState(() {
      if (picker != null) {
        images = File(picker.path);
        debugPrint("Image Successfully Picker");
      } else {
        debugPrint("Do'nt Picked Image ");
      }
    });
  }

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneNoController = TextEditingController();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              // IMAGE SECTION .
              Stack(
                // alignment: Alignment.center,
                children: [
                  images != null
                      ? Center(
                          child: SizedBox(
                              height: height * 0.2,
                              width: width * 0.5,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    images!.absolute,
                                    fit: BoxFit.fill,
                                  ))),
                        )
                      : Center(
                          child: Container(
                            height: height * 0.15,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const Image(
                                  image: AssetImage(
                                    "assest/images/todo_pic.png",
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 70,
                    right: 65,
                    child: IconButton(
                        onPressed: () {
                          getPickImageForGallery();
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
                ],
              ),

              // VALIDATION SECTION
              Gap(height * 0.04),
              AuthTextField(
                controller: nameController,
                hintText: "Enter Your Name .",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Name.";
                  }
                  final validator = Validator(
                    validators: [const MaxLengthValidator(length: 20)],
                  );
                  return validator.validate(
                    label: 'Required',
                    value: value,
                  );
                },
              ),
              Gap(height * 0.06),
              AuthTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: "Enter Your Email .",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Email.";
                  }
                  final validator = Validator(
                    validators: [
                      const EmailValidator(),
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
              Gap(height * 0.06),
              AuthTextField(
                controller: phoneNoController,
                hintText: "Enter Your Phone No .",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Phone No .";
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
              //  SIGN IN button section .
              Gap(height * 0.07),
              SizedBox(
                  width: width * 0.85,
                  child: beautifulButton(
                    color: cupertinoButtonColor,
                    text: "SIGN IN",
                    loading: loading,
                    onPressed: () async {
                      // ** Other method ya bhi method name fetch krny ka laya use hota ha
                      // final String username = nameController.text.trim();
                      // final String password = passwordController.text.trim();
                      // final String email = emailController.text.trim();
                      // User? user = auth.currentUser;
                      // user!.updateDisplayName(nameController.text);

                      if (key.currentState!.validate()) {
                        setState(() => loading = true);
                        // Register Account
                        auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) async {
                          Utils().toast("Successfully Create A User");
                          setState(() => loading = false);
                          //! FIRESTORE ALL TEXTFIELD DATA STORE METHOD .
                          storeThisFireStoreUserInfoAllData();

                          //! locally store gallery images firebaseStorage  method
                          uploadFireBaseStorage().then((value) {
                            debugPrint("Successfully Storage");
                            storeImageFireStore();
                          }).onError((error, stackTrace) {
                            debugPrint(
                                "Do ' nt storage >>>>>> ${error.toString()}");
                          });
                          // clear all textField
                          emailController.clear();
                          passwordController.clear();
                          nameController.clear();
                          passwordController.clear();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        }).onError((error, stackTrace) {
                          Utils().toast("Error : ${error.toString()}");
                          setState(() => loading = false);
                        });
                      }
                    },
                  )),
              Gap(height * 0.03),
              // ALREADY CREATE A ACCOUNT NAVIGATE THE LOGIN SCREEN .
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        )),
                    child: AutoSizeText("LOGIN",
                        style: GoogleFonts.tiroBangla(
                          textStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                  AutoSizeText("Already Create a Account",
                      style: GoogleFonts.tiroBangla(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//
  void storeThisFireStoreUserInfoAllData() async {
    // ! Current User TextField All Data .
    /// hm na opr textField bnye ha ka hm jo data (createUserWithEmailAndPassword) krty time all
    /// data profile page ma fetch krwana chaty ha pr hm Email ko hi fetch krwa skty ha aur data ka
    /// laya hm ny ak (*UserInfoModel*) bnye aur as class ma hm ny (name,phone,email,uid) la le
    /// aur hm as class ma a kr ase class ka use kr ka hm log all data (FireStore)  ma store krwa raha
    /// ha . aur store data ko (*UserInfoModel*) ka use krty howa get/fetch krwa raha ha  .
    User? user = auth.currentUser;
    UserInfoModel userInfo = UserInfoModel();
    userInfo.email = user!.email;
    userInfo.uid = user.uid;
    userInfo.firstName = nameController.text;
    userInfo.phoneNo = phoneNoController.text;
    firestore.collection("userInfo").doc(user.uid).set(userInfo.toMap());
  }

  ///* Hm jo apne gallery sa images pick kr raha ha osy hm firebaseStorage ma Save krwa raha ha
  ///* aur hm log ays sa hmy ak getDownloadURL ml raha ha jsy hm ak variable ma store krwa ka
  ///* hm firebaseFireStore ma apni images save krwa raha ha .
  Future uploadFireBaseStorage() async {
    String postImages = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref =
        FirebaseStorage.instance.ref("UserImage/").child(postImages);
    await ref.putFile(images!.absolute);
    getDownloadURL = await ref.getDownloadURL();
    debugPrint(
        "Store Image Firebase Storage >>>>>>>> ${getDownloadURL.toString()}");
  }

// ** This method store images firebaseFirestore
  void storeImageFireStore() {
    User? user = auth.currentUser;
    firestore
        .collection("images")
        .doc(user?.uid)
        .set({"getDownloadURL": getDownloadURL}).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Upload Images Successfully",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
      ));
    });
  }
}
