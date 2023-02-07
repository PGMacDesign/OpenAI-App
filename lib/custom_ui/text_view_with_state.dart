import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardTextField extends StatefulWidget {

  @override
  _ClipboardTextFieldState createState() => _ClipboardTextFieldState();

}

class _ClipboardTextFieldState extends State<ClipboardTextField> {
  String _text = "Responses Will Appear Here"; //Initial

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer.periodic(Duration(seconds: 10), (timer) {
  //     setState(() {
  //       _counter++;
  //     });
  //   });
  // }

  void _onTextChanged(String newText){
    setState(() {
      _text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      readOnly: true,
      controller: TextEditingController(text: _text),
      onTap: () {
        Clipboard.setData(ClipboardData(text: _text));
      },
      onChanged: _onTextChanged,
    );
  }
}