import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/user.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/services/firestore_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final fireStoreService = FireStoreServie();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: fireStoreService.readUser(),
        builder: (context, snapshot) {
          final user =
              Users.fromMap(snapshot.data?.data() as Map<String, dynamic>);
          print('========================$user');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (!snapshot.hasData) {
          //   return const Center(
          //     child: Text('No user found'),
          //   );
          // }

          return Center(
            child: Column(
              children: [
                Text(user.userName!),
                Text(user.address!),
                Text(user.contactNo!),
              ],
            ),
          );
        },
      ),
    );
  }
}
