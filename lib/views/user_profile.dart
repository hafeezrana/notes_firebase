import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/models/user.dart';
import 'package:note_firebase/services/firestore_service.dart';

class UserProfile extends ConsumerWidget {
//   const UserProfile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _UserProfileState createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final contactInfoController = TextEditingController();

  late Future<DocumentSnapshot<UserModel>> _fetchUser;

  // @override
  // void initState() {
  //   // super.initState();
  //   _fetchUser = context.read<FireStoreService>().fetchUser();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   nameController.text;
  //   addressController.text;
  //   contactInfoController.text;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchUser = ref.read(notesFireStoreProvider).fetchUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<UserModel>>(
        future: _fetchUser,
        builder: (context, snapshot) {
          final user = snapshot.data?.data();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No user found'),
            );
          }
          if (user != null) {
            nameController.text = user.userName ?? 'no name';
            addressController.text = user.address ?? 'no address';
            contactInfoController.text =
                user.contactNo ?? 'no contact information';
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const CircleAvatar(
                    child: Text('Image?'),
                    foregroundColor: Colors.purpleAccent,
                    radius: 60,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  TextFormField(
                    controller: contactInfoController,
                    decoration:
                        const InputDecoration(labelText: 'Contact Info'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(notesFireStoreProvider).editUser(
                            UserModel(
                              userName: nameController.text.trim(),
                              address: addressController.text.trim(),
                              contactNo: contactInfoController.text.trim(),
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
