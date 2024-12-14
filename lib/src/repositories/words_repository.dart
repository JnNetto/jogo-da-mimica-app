import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../authentication.dart';
import '../core/exceptions/failure.dart';

class WordsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userEmail = Authentication.user?.email ?? "";
  String userId = Authentication.user?.uid ?? "";

  Future<void> saveCategories(
      Map<String, List<String>> allCategories, BuildContext context) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.update({
        'customCategories': allCategories,
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
    }
  }

  Future<void> addCustomCategory(
      String categoryName, BuildContext context) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.set({
        'customCategories': {categoryName: []},
      }, SetOptions(merge: true));
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
    }
  }

  Future<void> deleteCustomCategory(
      String categoryName, BuildContext context) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.update({
        'customCategories.$categoryName': FieldValue.delete(),
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
    }
  }

  Future<void> addItemToCustomCategory(
      String categoryName, String item, BuildContext context) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);

      await documentReference.update({
        'customCategories.$categoryName': FieldValue.arrayUnion([item]),
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
    }
  }

  Future<void> removeItemFromCustomCategory(
      String categoryName, String item, BuildContext context) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);

      await documentReference.update({
        'customCategories.$categoryName': FieldValue.arrayRemove([item]),
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
    }
  }

  Future<List<String>> getItemsFromCustomCategory(
      String categoryName, BuildContext context) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(userEmail).doc(userId).get();

      // Verifica se o documento existe e contém o campo customCategories
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        Map<String, dynamic>? customCategories =
            data?['customCategories'] as Map<String, dynamic>?;

        if (customCategories != null &&
            customCategories.containsKey(categoryName)) {
          List<dynamic> items = customCategories[categoryName];
          return items.cast<String>();
        }
      }
      return []; // Retorna lista vazia se a categoria não existir
    } catch (e) {
      // ignore: use_build_context_synchronously
      Failure.showErrorDialog(context, e);
      return []; // Retorna lista vazia em caso de erro
    }
  }
}
