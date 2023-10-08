import 'package:neumorphic_ui/neumorphic_ui.dart';

class NewTaskShineButton extends StatefulWidget {
  const NewTaskShineButton(
      {super.key,
      required this.child,
      required this.color,
      required this.onTap});
  final Widget child;
  final Color color;
  final GestureTapCallback onTap;

  @override
  State<NewTaskShineButton> createState() => _ShineButtonState();
}

class _ShineButtonState extends State<NewTaskShineButton>
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
                shadowLightColorEmboss:
                    const Color.fromARGB(255, 230, 230, 230),
                shadowDarkColorEmboss: const Color.fromARGB(255, 51, 51, 51)),
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                  height: height * 0.06,
                  width: width * 0.1,
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
                  child: Center(child: widget.child)),
            ),
          );
        });
  }
}
