import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/models/note.dart';
import 'package:note_firebase/services/auth_service.dart';

import '../models/user.dart';

final notesFireStoreProvider = Provider<FireStoreService>((ref) {
  final authService = ref.read(notesAuthProvider);
  return FireStoreService(authService);
});

class FireStoreService {
  FireStoreService(this.authService);

  final userData = FirebaseFirestore.instance.collection('users');
  final noteData = FirebaseFirestore.instance.collection('notes');

  final AuthService authService;

  ///  functions for [UserProfileData]

  String get _uid => authService.authUser.uid;

  Future<DocumentSnapshot<UserModel>> fetchUser() async {
    return userData
        .doc(_uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (model, _) => model.toMap(),
        )
        .get();
  }

  Future<void> addUser(UserModel user) {
    return userData.doc(_uid).set(user.toMap());
  }

  Future<void> editUser(UserModel user) {
    return userData.doc(_uid).update(user.toMap());
  }

  ///  functions for [UserNotes]

  Future<void> addNote(Note notes) {
    return userData //
        .doc(_uid)
        .collection('notes')
        .add(notes.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchNote() {
    return userData //
        .doc(_uid)
        .collection('notes')
        .snapshots();
  }

  Future<void> editNote(Note notes, String noteID) async {
    return await userData //
        .doc(_uid)
        .collection('notes')
        .doc(noteID)
        .update(notes.toMap());
  }

  Future<void> deleteNote(String id) async {
    return await userData //
        .doc(_uid)
        .collection('notes')
        .doc(id)
        .delete();
  }
}
