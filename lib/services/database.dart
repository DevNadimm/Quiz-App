import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  static Future<void> addQuizCategory(
      Map<String, dynamic> quiz, String category) async {
    try {
      await FirebaseFirestore.instance.collection(category).add(quiz);
      print('Quiz category added successfully!');
    } catch (e) {
      print('Error adding quiz category: $e');
    }
  }

  static Future<Stream<QuerySnapshot>> getQuizByCategory(
      String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }

  static Future<void> addUser(
      Map<String, dynamic> userInfo, String userId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(userInfo);
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
