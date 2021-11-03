import 'package:get/get.dart';

class SelectionController extends GetxController {
  RxString currentSelection = "".obs;
  
  void setSelection(String s) {
    currentSelection.value = s;
  }
}
