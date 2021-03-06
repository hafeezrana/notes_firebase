import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/firebase_options.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/services/firestore_service.dart';
import 'package:note_firebase/views/home_view.dart';
import 'package:note_firebase/views/sign_in_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        Provider<FireStoreService>(
          create: (context) => FireStoreService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: AuthStateChanges(),
      ),
    );
  }
}

class AuthStateChanges extends StatelessWidget {
  AuthStateChanges({Key? key}) : super(key: key);

  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (conext, snapshot) {
        if (snapshot.data != null) {
          return const HomeView();
        } else {
          return const SignInView();
        }
      },
    );
  }
}
