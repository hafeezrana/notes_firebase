import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final firestore = FirebaseFirestore.instance;
  //final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: firestore.collection('users').doc(widget.userId).get(),
        builder: (context, snapshot) {
          final user =
              Users.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          print('============${widget.userId}');

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

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: [
                  Text(user.userName),
                  Text(user.address),
                  Text(user.contactNo),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
