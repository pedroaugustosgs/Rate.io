import 'package:flutter/material.dart';
import 'package:rate_io/classes/morador.dart';

class MoradorProvider extends ChangeNotifier {
  Morador? _morador;

  Morador? get morador => _morador;

  void setUser(Morador morador) {
    _morador = morador;
    notifyListeners(); // Notify listeners of the change
  }

  void clearUser() {
    _morador = null;
    notifyListeners();
  }
}
