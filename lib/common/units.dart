import 'package:flutter/cupertino.dart';

class Units extends ChangeNotifier {
  int index = 0;
  Map<String, String> toMetric = {
    "1 oz": "30 ml",
    "1 cl": "10 ml",
    "1 spoon": "15 ml",
    "1 cup": "236 ml",
    "1 tblsp": "15 ml",
    "1 shot": "44 ml",
    "1 tsp": "5 ml",
    "1 gal": "3.78 l"
  };
  Map<String, String> toImperial = {
    "30 ml": "1 oz",
    "10 ml": "0.3 oz",
    "1 spoon": "0.5 oz",
    "236 ml": "8 oz",
    "1 tblsp": "0.5 oz",
    "1 shot": "1.5 oz",
    "3 tsp": "0.5 oz",
    "1 gal": "128 oz"
  };
  changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  Map<String, String> returnMap() {
    return index == 0 ? toMetric : toImperial;
  }
}
