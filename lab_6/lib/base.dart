import 'package:hive_flutter/hive_flutter.dart';

class FoodList {
  List ids = [];
  List foods = [];

  final myBox = Hive.box('mybox');

  void loadData() {
    ids = myBox.get('List', defaultValue: []);
    foods = myBox.get('Food', defaultValue: []);
  }

  void update() {
    myBox.put('List', ids);
    myBox.put('Food', foods);
  }
}
