import 'package:flutter/cupertino.dart';
import 'package:stone_recipe_app/models/recipe.dart';
import 'package:stone_recipe_app/provider/item_model.dart';

class Bookmarkbloc extends ChangeNotifier {
  static int _count = 0;
  List<ItemModel> item = [];
  void addcount() {
    _count++;
    notifyListeners();
  }

  void additem(ItemModel data) {
    item.add(data);
    notifyListeners();
  }

  static count() {
    return _count;
  }

  List<ItemModel> get itemlist {
    return item;
  }
}
                        