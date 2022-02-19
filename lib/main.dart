import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/firebase_options.dart';
import 'package:note_firebase/views/home_view.dart';
import 'package:note_firebase/views/sign_in_view.dart';

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
      home: const AuthStateChanges(),
    );
  }
}

class AuthStateChanges extends StatelessWidget {
  const AuthStateChanges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (conext, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const HomeView();
        } else {
          return const SignInView();
        }
      },
    );
  }
}
