import 'package:flutter/material.dart';
import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For MD5 hashing

class EncryptPassword  {
  static toMD5(String password) {
    var bytes = utf8.encode(password); // Convert password to UTF-8 bytes
    var pdw = md5.convert(bytes); // Generate MD5 hash
    return pdw.toString(); // Return hash as a string
  }
}
