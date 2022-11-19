import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/views/sign_up_view.dart';

import 'home_view.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  static const routeName = '/sign-in';

  static Route<void> route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: const SignInView(),
        );
      },
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignInViewState();
}

class SignInViewState extends ConsumerState {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() async {
    try {
      await ref.watch(notesAuthProvider).loginIn(
            email: emailController.text,
            password: passwordController.text,
          );
      Navigator.of(context).push(HomeView.route());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Text(e.message.toString()),
          ),
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(e.message.toString()),
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: "Enter your Email...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: "Enter your Password...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Forgot password?',
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onSignInPressed,
              child: const Text('SignIn'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                SignUpView.route(),
                (route) => false,
              ),
              child: const Text('create a new account?'),
            ),
          ],
        ),
      ),
    );
  }
}
