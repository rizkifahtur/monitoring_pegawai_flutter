import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Info {
  static void snackbar(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(milliseconds: 1700),
    );
  }
}
