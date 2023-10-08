import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///   Todo : CupertinoButton Using for all App .
CupertinoButton beautifulButton(
    {String text = "",
    VoidCallback? onPressed,
    Color? color,
    bool loading = false}) {
  return CupertinoButton(
    color: color,
    onPressed: onPressed,
    borderRadius: BorderRadius.circular(10),
    child: loading
        ? const Center(child: CircularProgressIndicator())
        : Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
  );
}

/// Todo : Toast Method Using for All App .

class Utils {
  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);
  }
}
