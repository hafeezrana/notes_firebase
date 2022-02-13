import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/note.dart';

import 'add_note_view.dart';
import 'note_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

final firestore = FirebaseFirestore.instance;

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('notes').snapshots(),
          builder: (context, snaphot) {
            final noteId = snaphot.data?.docs.map((note) => note.id).toList();
            print(noteId);

            final notes = snaphot.data?.docs
                .map(
                    (note) => Note.fromMap(note.data() as Map<String, dynamic>))
                .toList();

            print(notes);

            if (!snaphot.hasData) {
              return const Center(
                child: Text('No Data Exists'),
              );
            }
            if (snaphot.hasError) {
              return const Text('Something went Wrong');
            }

            if (snaphot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 12,
                color: Colors.black54,
                thickness: 4.0,
              ),
              itemCount: notes?.length ?? 0,
              itemBuilder: (context, index) {
                final note = notes![index];

                return ListTile(
                  leading: const CircleAvatar(child: Text('')),
                  title: Text(note.title!),
                  trailing: IconButton(
                    onPressed: () {
                      firestore
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
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNoteView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


///___[final noteId = snapshot.data.docs().map(note=> note.Id).]