

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLiveVotesOperations {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addVote(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('live_votes').add(data);
      print('Vote added successfully');
    } catch (e) {
      print('Error adding vote: $e');
    }
  }

}
