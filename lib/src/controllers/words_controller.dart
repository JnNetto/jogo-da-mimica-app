// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mimica_att/src/core/exceptions/failure.dart';
import '../../authentication.dart';
import '../database/lists_database.dart';
import '../repositories/words_repository.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    },
  );
}

class WordsController {
  final WordsRepository _wordsRepository = WordsRepository();
  final ListsDatabase _listsDatabase = ListsDatabase();
  String userEmail = Authentication.user?.email ?? "";
  String userId = Authentication.user?.uid ?? "";

  Future<List<String>> getTitleCategories(BuildContext context) async {
    showLoadingDialog(context);
    try {
      List<String> allCategories = await _listsDatabase.getAllCategoryKeys();
      return allCategories;
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
      return [];
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<Map<String, List<String>>> preloadCategories(
      BuildContext context, bool isItToSave) async {
    showLoadingDialog(context);
    try {
      await hasNetwork();
      final Map<String, List<String>> allDataCategories = {};
      List<String> allCategoriesKeys =
          await _listsDatabase.getAllCategoryKeys();
      for (String key in allCategoriesKeys) {
        allDataCategories[key] =
            await _listsDatabase.getCategoryList(key) ?? [];
      }
      if (await hasNetwork() && isItToSave && userEmail != "") {
        await _wordsRepository.saveCategories(allDataCategories, context);
      }
      return allDataCategories;
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
      return {};
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> addCategory(String categoryName, BuildContext context) async {
    showLoadingDialog(context);
    try {
      await hasNetwork();
      await _listsDatabase.addCategory(categoryName);
      // ignore: no_leading_underscores_for_local_identifiers
      bool _hasNetwork = await hasNetwork();
      if (_hasNetwork && userEmail != "") {
        await _wordsRepository.addCustomCategory(categoryName, context);
      }
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> deleteCategory(String categoryName, BuildContext context) async {
    showLoadingDialog(context);
    try {
      await hasNetwork();
      await _listsDatabase.deleteCategory(categoryName);
      if (await hasNetwork() && userEmail != "") {
        await _wordsRepository.deleteCustomCategory(categoryName, context);
      }
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> addItemToCategory(
      String categoryName, String newWord, BuildContext context) async {
    showLoadingDialog(context);
    try {
      await hasNetwork();
      await _listsDatabase.addItemToCategory(categoryName, newWord);
      if (await hasNetwork() && userEmail != "") {
        await _wordsRepository.addItemToCustomCategory(
            categoryName, newWord, context);
      }
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> deleteItemToCategory(
      String categoryName, String word, BuildContext context) async {
    showLoadingDialog(context);
    try {
      await hasNetwork();
      await _listsDatabase.deleteItemToCategory(categoryName, word);
      if (await hasNetwork() && userEmail != "") {
        await _wordsRepository.removeItemFromCustomCategory(
            categoryName, word, context);
      }
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<List<String>?> getCategoryList(
      String categoryName, BuildContext context) async {
    showLoadingDialog(context);
    try {
      List<String>? words;
      await hasNetwork();
      if (await hasNetwork() && userEmail != "") {
        words = await _wordsRepository.getItemsFromCustomCategory(
            categoryName, context);
      } else {
        words = await _listsDatabase.getCategoryList(categoryName);
      }

      return words;
    } on Exception catch (e) {
      Failure.showErrorDialog(context, e);
      return [];
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
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
