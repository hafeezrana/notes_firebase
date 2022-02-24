import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_firebase/models/note.dart';
import 'package:note_firebase/services/auth_service.dart';

import '../models/user.dart';

class FireStoreServie {
  final userData = FirebaseFirestore.instance.collection('users');
  final noteData = FirebaseFirestore.instance.collection('notes');

  final authService = AuthService();

  ///  functions for [UserProfileData]

  Future<DocumentSnapshot<Map<String, dynamic>?>> readUser() async {
    return await userData.doc(authService.userId).get();
  }

  Future<void> addUser(Users user) {
    return userData.doc(authService.userId).set(user.toMap());
  }

  Future<void> editUser(Users user) {
    return userData.doc(authService.userId).update(user.toMap());
  }

  ///  functions for [UserNotes]

  Future<void> addNote(Note notes) {
    return userData.doc(authService.userId).collection('notes').add(
          notes.toMap(),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchNote() {
    return userData.doc(authService.userId).collection('notes').snapshots();
  }

  Future<void> editNote(Note notes) async {
    return await userData
        .doc(authService.userId)
        .collection('notes')
        .doc()
        .update(notes.toMap());
  }
}
