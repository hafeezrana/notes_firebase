import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/note.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/services/firestore_service.dart';
import 'package:note_firebase/views/sign_in_view.dart';
import 'package:note_firebase/views/user_profile.dart';

import 'add_note_view.dart';
import 'note_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authService = AuthService();
  final fireStoreServie = FireStoreServie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes '),
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  authService.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInView(),
                    ),
                  );
                },
                child: const Text('SignOut'),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfile(),
                    ),
                  );
                },
                child: const Text('profile'),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreServie.fetchNote(),
        builder: (context, snapshot) {
          final noteId = snapshot.data?.docs.map((note) => note.id).toList();

          final notes = snapshot.data?.docs
              .map((note) => Note.fromMap(note.data() as Map<String, dynamic>))
              .toList();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong'));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Add New Data!'),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              height: 4,
              color: Colors.brown,
            ),
            itemCount: notes?.length ?? 0,
            itemBuilder: (context, index) {
              final note = notes![index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {},
                  style: ListTileStyle.list,
                  tileColor: Colors.orangeAccent,
                  hoverColor: Colors.cyan,
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(note.title!),
                  trailing: IconButton(
                    onPressed: () {
                      fireStoreServie.userData
                          .doc(authService.userId)
                          .collection('notes')
                          .doc(noteId![index])
                          .delete();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailView(
                          noteId: noteId![index],
                          note: note,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNoteView()),
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
