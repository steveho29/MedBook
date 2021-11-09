import 'package:get/get.dart';

class SelectionController extends GetxController {
  RxString _currentSelection = "".obs;
  String get currentSelection => _currentSelection.value;
  void Function() callBack;
  SelectionController({required this.callBack});

  void addCallBack(void Function() callBack) {
    _currentSelection.listen((p0) {
      callBack();
    });
  }

  void setSelection(String s) {
    _currentSelection.value = s;
  }
}
