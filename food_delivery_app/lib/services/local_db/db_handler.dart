import 'package:food_delivery_app/keys/local_db_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DBHandler {
  String? filePath;

  static initializeDB() async {
    String filePath =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    Hive.init(filePath);
    await Hive.openBox(HiveKeys.dbKey, path: filePath);
    await Hive.openBox(HiveKeys.favouriteRecipesBox, path: filePath);
  }

  static Future<Box> getRecipeBox() async {
    Box favouriteRecipesBox = Hive.box(HiveKeys.favouriteRecipesBox);
    if (!favouriteRecipesBox.isOpen) {
      await Hive.openBox(HiveKeys.favouriteRecipesBox);
    }
    return favouriteRecipesBox;
  }

  static Future<Box> openRecipeBox() async {
    return await Hive.openBox(HiveKeys.favouriteRecipesBox);
  }
}
