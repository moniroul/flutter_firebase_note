import 'package:flutter_firebase_note/controller/authController.dart';
import 'package:flutter_firebase_note/controller/noteController.dart';
import 'package:get/get.dart';

class ControllerInit {
  static Init() {
    Get.put(Authcontroller()); 
    Get.put(Notecontroller()); 
  }
}
