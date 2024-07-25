import 'package:cloud_firestore/cloud_firestore.dart';

class WordsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> addCustomCategory(
      String userEmail, String userId, String categoryName) async {
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
}
