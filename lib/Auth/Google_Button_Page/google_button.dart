import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:todo_app_firebase/Constant/app_style.dart';
import 'package:animate_do/animate_do.dart';
import 'google_button_widget.dart';

class GoogleButtonPage extends StatefulWidget {
  const GoogleButtonPage({super.key});

  @override
  State<GoogleButtonPage> createState() => _GoogleButtonPageState();
}

class _GoogleButtonPageState extends State<GoogleButtonPage>
    with SingleTickerProviderStateMixin {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: Column(
      children: [
        // Image Sections
        Neumorphic(
          style: NeumorphicStyle(
            depth: -10,
            boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
            shadowLightColorEmboss: const Color.fromARGB(255, 230, 230, 230),
            shadowDarkColorEmboss: const Color.fromARGB(214, 51, 51, 51),
          ),
          child: Container(
            height: height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Color.fromARGB(255, 157, 237, 244),
            ),
            child: Center(
                child: FadeInDown(
                    duration: const Duration(seconds: 1),
                    child: const Image(image: AssetImage(googleLogo)))),
          ),
        ),
        SizedBox(
          height: height * 0.1,
        ),
        //  Google Button Sections .
        ShineButton(
          loading: loading,
          color: const Color.fromARGB(255, 157, 237, 244),
          child: Center(
            child: Text("GOOGLE BUTTON",
                style: GoogleFonts.tiroBangla(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ),
          onTap: () {
            setState(() => loading = false);

            signInWithGoogle(context).then((value) {
              setState(() => loading = true);
            });
          },
        )
      ],
    ));
  }
}
