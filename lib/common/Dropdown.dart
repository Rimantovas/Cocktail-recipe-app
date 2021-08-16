import 'package:flutter/foundation.dart';

class Dropdown extends ChangeNotifier {
  String _value = "Margarita";
  String get value => _value;
  List<String> _values = [
    "Margarita",
    "Negroni",
    "Mojito",
    "Martini",
    "Vodka",
    "Favourites"
  ];
  List<String> get values => _values;

  changeValue(String val) {
    _value = val;
    notifyListeners();
  }

  startingValues(List<String> val) {
    _values = val;
    notifyListeners();
  }
}
