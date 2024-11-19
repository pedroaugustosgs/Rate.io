import 'package:flutter/material.dart';
import 'package:rate_io/classes/rep.dart';

class RepProvider extends ChangeNotifier {
  Rep? _rep;

  Rep? get rep => _rep;

  void setUser(Rep rep) {
    _rep = rep;
    notifyListeners(); // Notify listeners of the change
  }

  void clearUser() {
    _rep = null;
    notifyListeners();
  }
}
