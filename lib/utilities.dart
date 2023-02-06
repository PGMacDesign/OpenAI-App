import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

/// Read a file into a String. Note that this puts the entire file into memory
/// as a string so this shouldn't be used for large files.
FutureOr<String> readFile(String filePath) async {
  String fileContents;
  try {
    final file = File(filePath);
    fileContents = await file.readAsString();
    return fileContents;
  } catch (e) {
    return "";
  }
}


/// Read a resource file / asset into a String. Note that this puts the entire
/// file into memory as a string so this shouldn't be used for large files.
FutureOr<String> readFromAsset(String assetName) async {
  try {
    return await rootBundle.loadString(assetName);
  } catch (e) {
    return "";
  }
}

