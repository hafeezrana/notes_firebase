import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/firebase_options.dart';
import 'package:note_firebase/views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeView(),
    );
  }
}
