import 'package:flutter/foundation.dart';

class WelcomeProvider extends ChangeNotifier {
  int _progressIndex = 0;

  int get progressIndex => _progressIndex;

  void selectProgress(int index) {
    if (_progressIndex == index) return;
    _progressIndex = index;
    notifyListeners();
  }
}
