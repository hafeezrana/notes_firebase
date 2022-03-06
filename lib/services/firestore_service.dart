import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_firebase/models/note.dart';
import 'package:note_firebase/services/auth_service.dart';

import '../models/user.dart';

class FireStoreService {
  final userData = FirebaseFirestore.instance.collection('users');
  final noteData = FirebaseFirestore.instance.collection('notes');

  final authService = AuthService();

  ///  functions for [UserProfileData]

  Future<DocumentSnapshot<UserModel>> fetchUser() async {
    return userData
        .doc(authService.userId)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (model, _) => model.toMap(),
        )
        .get();
  }

  Future<void> addUser(UserModel user) {
    return userData.doc(authService.userId).set(user.toMap());
  }

  Future<void> editUser(UserModel user) {
    return userData.doc(authService.userId).update(user.toMap());
  }

  ///  functions for [UserNotes]

  Future<void> addNote(Note notes) {
    return userData.doc(authService.userId).collection('notes').add(
          notes.toMap(),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchNote() {
    return userData.doc(authService.userId).collection('notes').snapshots();
  }

  Future<void> editNote(Note notes, String noteID) async {
    return await userData
        .doc(authService.userId)
        .collection('notes')
        .doc(noteID)
        .update(notes.toMap());
  }

  Future<void> deleteNote(String id) async {
    return await userData
        .doc(authService.userId)
        .collection('notes')
        .doc(id)
        .delete();
  }
}
