import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

final instance = FirebaseFirestore.instance;

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            final userId = snapshot.data?.docs.map((user) => user.id).toList();

            final users = snapshot.data?.docs
                .map((user) =>
                    Users.fromMap(user.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
                itemCount: users?.length ?? 0,
                itemBuilder: (context, index) {
                  final user = users![index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Text(user.userName),
                          Text(user.address!),
                          Text(user.contactNo),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
