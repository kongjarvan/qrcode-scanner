import 'package:get/get.dart';

class ScanController extends GetxController {
  String? code;

  void saveQRCode(String text) {
    code = text;
    update();
  }
}