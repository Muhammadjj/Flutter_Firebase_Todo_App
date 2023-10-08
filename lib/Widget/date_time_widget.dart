import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget(
      {super.key,
      required this.titleText,
      required this.icon,
      required this.valueText,
      required this.onTap});

  final String titleText;
  final IconData icon;
  final String valueText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        textFieldTitle(text: titleText),
        const Gap(5),
        Material(
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Container(
                height: height * 0.06,
                width: width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    const Gap(10),
                    AutoSizeText(valueText)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget textFieldTitle({
    String text = "",
  }) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: AutoSizeText(text,
            style: GoogleFonts.tiroBangla(
              textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
