import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/Auth/Login_page/login_page_main.dart';
import 'package:todo_app_firebase/Auth/Pages/Profile_Page/profile_page_widget.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/Model/user_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// (User) hm ny apna current User ka data ko fetch krwany ka laya (User Object ) ka
  /// use kya js ma hm SignUp ma jb apna user ko Register kry ga tb hm apny
  /// user sa ( Name ,Email, PhoneNo ) input ma la la ga aur jo hm na apne (UserInfoModel)
  /// name ki class bnye ha asy call kry ga uar signUp ma jo kuch bhi textField sa input ma la
  /// raa ha wo all input hm Model class ka thro fetch kr raha ha
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserInfoModel userInfoModel = UserInfoModel();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? fireStoreImages;

// ** Fetch this image firestore but store image fireStorage  and save this image firestore or fetch image profile page .
  Future<void> receiveImage() async {
    await firestore.collection("images").doc(user!.uid).get().then((value) {
      debugPrint(
          'datttttttttttttttttttttttttttttttttttttttttttttttttttttttt4\t ${value.data()}');
      fireStoreImages = value.data()?["getDownloadURL"];
      // user!.uid.toString();
      debugPrint("Show UID >>>>>>>...   ${user!.uid.toString()}");
      debugPrint("Show UID >>>>>>>...   ${fireStoreImages.toString()}");
      setState(() {});
      // print(fireStoreImages);
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await receiveImage();
  }

  @override
  void initState() {
    // Todo: implement initState
    /// signUp store all data fetch method (get) view in Profile Page ya wo data ha jo hm model class
    /// sa la raha ha . ays model class ko hm log ays class ma fetch krya raha ha . as all data ki hm na
    /// ak collection bnye ha aur ays ka andr doc bnya ha jaha sa hm easily data fetch kr raha ha
    super.initState();
    FirebaseFirestore.instance
        .collection("userInfo")
        .doc(user!.uid)
        .get()
        .then((value) {
      userInfoModel = UserInfoModel.fromMap(value.data()!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var name = auth.currentUser!.displayName ?? userInfoModel.firstName;
    var email = auth.currentUser!.email ?? userInfoModel.email;
    var phone = auth.currentUser!.phoneNumber ?? userInfoModel.phoneNo;

    return Scaffold(
      backgroundColor: screenColors,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              // *  Image .
              ReceiveImage(
                  backgroundImage: NetworkImage(fireStoreImages.toString())),

              SizedBox(
                height: height * 0.1,
              ),

              // *Name Card .
              ProfileViewListTile(
                  title: Text("Name",
                      style: GoogleFonts.tiroBangla(
                        textStyle: listTileTextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      )),
                  subTitle: Text(
                    name.toString(),
                    style: listTileTextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  leading: const Icon(Icons.person_3)),
              //* Email Card.
              ProfileViewListTile(
                  title: Text("Email",
                      style: GoogleFonts.tiroBangla(
                        textStyle: listTileTextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      )),
                  subTitle: Text(
                    email.toString(),
                    style: listTileTextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  leading: const Icon(Icons.mark_email_read)),
              //* Phone Card.
              ProfileViewListTile(
                  title: Text("Phone",
                      style: GoogleFonts.tiroBangla(
                        textStyle: listTileTextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      )),
                  subTitle: Text(
                    phone.toString(),
                    style: listTileTextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  leading: const Icon(Icons.phone_android_rounded)),
              //* LogOut  Card.
              ProfileViewListTile(
                  title: Text("LogOut",
                      style: GoogleFonts.tiroBangla(
                        textStyle: listTileTextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      )),
                  subTitle: Text(
                    "",
                    style: listTileTextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  onTap: () {
                    auth.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false);
                    });
                  },
                  leading: const Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle listTileTextStyle({double? fontSize, FontStyle? fontStyle}) {
  return TextStyle(
      fontSize: fontSize, fontWeight: FontWeight.bold, fontStyle: fontStyle);
}
