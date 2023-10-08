// ignore_for_file: must_be_immutable

import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app_firebase/View/home_page.dart';
import 'package:todo_app_firebase/Widget/small_widget.dart';

import '../../Constant/app_style.dart';

class ShineButton extends StatefulWidget {
  ShineButton(
      {super.key,
      this.loading = false,
      required this.child,
      required this.color,
      required this.onTap});
  final Widget child;
  final Color color;
  final GestureTapCallback onTap;
  bool loading;

  @override
  State<ShineButton> createState() => _ShineButtonState();
}

class _ShineButtonState extends State<ShineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    // Todo: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Neumorphic(
            style: NeumorphicStyle(
                depth: -10,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                shadowLightColorEmboss: shadowLightColorEmbossButton,
                shadowDarkColorEmboss: shadowDarkColorEmbossButton),
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                height: height * 0.08,
                width: width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      widget.color,
                      Colors.white,
                      widget.color,
                    ], stops: [
                      0.0,
                      controller.value,
                      1.0
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: widget.loading
                    ? widget.child
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          );
        });
  }
}

// Todo : Google Auth In Flutter Help With Firebase
FirebaseAuth auth = FirebaseAuth.instance;
Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow  means ka end user ko ak dialog view
  // ho ga js pr end user apne email select kr skta ha aur agr hmra user
  // apne current email select krta ha to hmy authentication check krne prte ha
  // aur agr hmra user (Google Dialog) ko bnd krta ha to (GoogleSignInAccount)
  // Object return ma (null) bhjta haa . jo Future<UserCredential> ko mlta ha
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request means ka GoogleSignIn hona ka
  // bd hmy ab Two thing ki zarort ha (AccessToken, IdToken) ya dono hmy
  // hmra email ma majod data tk rasiye daty ha
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential means ka Firebase ka Credential (conditions) ko
  // check krta ha aur asy ya sb kuch krna ka laya (accessToken , IdToken) ki
  //  zarort hote ha .
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  debugPrint("Google User : $googleUser");
  debugPrint("Google User Email : ${googleUser!.email.toString()}");
  debugPrint("Google User DisPlayName : ${googleUser.displayName}");
  // Once signed in, return the UserCredential
  return await auth.signInWithCredential(credential).then((value) {
    debugPrint("Google Button Login");
    Utils().toast("Google Login");

    /// AGr hmra current user GoogleSign Ka process complete kr lata ha to hm
    /// asy HomePage Pr Navigate kr raha ha aur HomePage ma hm Current User ki
    /// information bhj raha ha FOR EXAMPLE => NAME , EMAIL , UID etc .
    /// Aur all data hm HomePage pr fetch krwa raha ha .
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
    return auth.signInWithCredential(credential);
  });
}
