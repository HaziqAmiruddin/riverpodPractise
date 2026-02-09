import 'package:flutter/material.dart';

class RiverpodModal extends ChangeNotifier {
  int counter;
  RiverpodModal({required this.counter});

  void addCounter() {
    counter++;
    notifyListeners();
  }

  void removeCounter() {
    counter--;
    notifyListeners();
  }
}
