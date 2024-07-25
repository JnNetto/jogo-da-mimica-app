import '../repositories/words_repository.dart';

class WordsController {
  final WordsRepository _wordsRepository = WordsRepository();

  Future<List<String>> getTitleCategories(
      String userEmail, String userId) async {
    Map<String, dynamic>? categoriesData =
        await _wordsRepository.fetchCustomCategories(userEmail, userId);

    if (categoriesData != null) {
      return categoriesData.keys.toList();
    } else {
      return [];
    }
  }

  Future<void> addCategory(
      String userEmail, String userId, String categoryName) async {
    await _wordsRepository.addCustomCategory(userEmail, userId, categoryName);
  }
}
