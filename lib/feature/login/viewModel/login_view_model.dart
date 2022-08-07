import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool isCheckBoxOkay = false;
  String? _inputText;
  bool isLoading = false;

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> controlTextValue() async {
    _changeLoading();
    await Future.delayed(const Duration(seconds: 1));
    _changeLoading();
  }

  void checkBoxChecked(bool value) {
    isCheckBoxOkay = value;
    notifyListeners();
  }
}
