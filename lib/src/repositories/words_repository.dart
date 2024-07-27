import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentication.dart';

class WordsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userEmail = Authentication.user?.email ?? "";
  String userId = Authentication.user?.uid ?? "";

  Future<Map<String, dynamic>?> fetchCustomCategories(
      String userEmail, String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(userEmail).doc(userId).get();

      if (snapshot.exists) {
        Map<String, dynamic> customCategories =
            snapshot.data() as Map<String, dynamic>;
        return customCategories["customCategories"];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching custom categories: $e");
      return null;
    }
  }

  Future<void> saveCategories(Map<String, List<String>> allCategories) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.update({
        'customCategories': allCategories,
      });
    } catch (e) {
      print("Error updating custom category: $e");
    }
  }

  Future<void> addCustomCategory(String categoryName) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.set({
        'customCategories': {categoryName: []},
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error adding custom category: $e");
    }
  }

  Future<void> deleteCustomCategory(String categoryName) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(userEmail).doc(userId);
      await documentReference.update({
        'customCategories.$categoryName': FieldValue.delete(),
      });
    } catch (e) {
      print("Error adding custom category: $e");
    }
  }
}
