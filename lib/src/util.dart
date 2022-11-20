import 'package:firebase_storage/firebase_storage.dart';

/// Storage Reference to Hash
int storageRefToHash(Reference storageRef) {
  String string = storageRef.fullPath;

  return stringToHash(string);
}

/// Create an ID for the Isar database out of the Firebase Storage Reference
int stringToHash(String string) {
  int hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
