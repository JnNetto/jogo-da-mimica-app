import 'dart:io';

import '../database/lists_database.dart';
import '../repositories/words_repository.dart';

class WordsController {
  final WordsRepository _wordsRepository = WordsRepository();
  final ListsDatabase _listsDatabase = ListsDatabase();

  Future<List<String>> getTitleCategories(
      String userEmail, String userId) async {
    // // ignore: no_leading_underscores_for_local_identifiers
    // bool _hasNetwork = await hasNetwork();
    // if (_hasNetwork) {
    //   Map<String, dynamic>? categoriesData =
    //       await _wordsRepository.fetchCustomCategories(userEmail, userId);

    //   if (categoriesData != null) {
    //     return categoriesData.keys.toList();
    //   } else {
    //     return [];
    //   }
    // } else {
    List<String> allCategories = await _listsDatabase.getAllCategoryKeys();
    return allCategories;
    // }
  }

  final Map<String, List<String>> _categoryCache = {};

  Future<Map<String, List<String>>> preloadCategories() async {
    List<String> allCategoriesKeys = await _listsDatabase.getAllCategoryKeys();
    for (String key in allCategoriesKeys) {
      _categoryCache[key] = await _listsDatabase.getCategoryList(key) ?? [];
    }
    return _categoryCache;
  }

  Future<void> addCategory(
      String userEmail, String userId, String categoryName) async {
    await _listsDatabase.addCategory(categoryName);
    // ignore: no_leading_underscores_for_local_identifiers
    bool _hasNetwork = await hasNetwork();
    if (_hasNetwork) {
      await _wordsRepository.addCustomCategory(userEmail, userId, categoryName);
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
