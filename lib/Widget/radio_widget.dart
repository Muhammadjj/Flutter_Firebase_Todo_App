import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_firebase/Provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.onChanged,
    required this.valueInput,
    required this.categColor,
    required this.titleRadio,
  });
  final String titleRadio;
  final Color categColor;
  final int valueInput;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ** Using this radio Provider initial value (1)
    final radio = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categColor),
        child: RadioListTile(
          activeColor: categColor,
          title: Transform.translate(
              offset: const Offset(-22, 0),
              child: AutoSizeText(
                titleRadio,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: categColor),
              )),
          value: valueInput,
          groupValue: radio,
          onChanged: (value) => onChanged(),
        ),
      ),
    );
  }
}
