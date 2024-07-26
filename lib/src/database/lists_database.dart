import 'package:hive_flutter/hive_flutter.dart';

class ListsDatabase {
  Box? categoriesBox;

  Future<void> initHive() async {
    categoriesBox = await Hive.openBox('categories');
  }

  // Adiciona uma nova categoria
  Future<void> addCategory(String category) async {
    if (categoriesBox == null) await initHive();

    if (!categoriesBox!.containsKey(category)) {
      categoriesBox!.put(category, <String>[]);
    }
  }

  // Recupera todas as chaves de categorias
  Future<List<String>> getAllCategoryKeys() async {
    if (categoriesBox == null) await initHive();
    return categoriesBox!.keys.cast<String>().toList();
  }

  // Recupera uma lista associada a uma chave de categoria específica
  Future<List<String>?> getCategoryList(String category) async {
    if (categoriesBox == null) await initHive();
    dynamic list = categoriesBox!.get(category);
    if (list is List) {
      list = List<String>.from(list);
      return list as List<String>;
    }
    return null;
  }

  // Adiciona um item a uma categoria específica
  Future<void> addItemToCategory(String category, String item) async {
    if (categoriesBox == null) await initHive();
    final dynamic list = categoriesBox!.get(category);
    if (list is List<String>) {
      if (!list.contains(item)) {
        list.add(item);
        categoriesBox!.put(category, list);
      }
    }
  }

  // Remove um item de uma categoria específica
  Future<void> deleteItemToCategory(String category, String item) async {
    if (categoriesBox == null) await initHive();
    final dynamic list = categoriesBox!.get(category);
    if (list is List<String>) {
      list.remove(item);
      categoriesBox!.put(category, list);
    }
  }
}
