import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/firebase_options.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/views/home_view.dart';
import 'package:note_firebase/views/sign_in_view.dart';

void main() {
  runApp(const InitializeFirebase());
}

@immutable
class InitializeFirebase extends StatefulWidget {
  const InitializeFirebase({super.key});

  @override
  State<InitializeFirebase> createState() => _InitializeFirebaseState();
}

class _InitializeFirebaseState extends State<InitializeFirebase> {
  late Future _loading;

  @override
  void initState() {
    super.initState();
    _loading = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loading,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: ColoredBox(
              color: Colors.yellow,
              child: Center(
                child: Text('Splash'),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return ErrorWidget('ERROR');
        }
        return const ProviderScope(child: MyApp());
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StreamBuilder<AuthUser>(
        initialData: authService.authUser,
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.requireData != AuthUser.empty) {
            return const HomeView();
          } else {
            return const SignInView();
          }
        },
      ),
    );
  }
}
